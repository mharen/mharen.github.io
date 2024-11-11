---
layout: post
date: '2024-11-11'
categories:
- technology
title: "Running one job at a time with Azure Blob Storage leases"
---

I really like using [background tasks][1] to host things like periodic jobs _inside_ my .NET web apps. It's a very
convenient way to run some light task without building out a separate service, cron, etc., and it can leverage all the
dependency injection and configuration you've already set up for your web app.

Essentially you create a worker like this:

```cs
using System;
using System.Threading;
using Microsoft.Extensions.Hosting;

public class Worker : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        Console.WriteLine("Started");

        using PeriodicTimer timer = new(TimeSpan.FromMinutes(5));
        while (await timer.WaitForNextTickAsync(stoppingToken))
        {
            try
            {
                Console.WriteLine("Doing work");
                await Task.Delay(TimeSpan.FromSeconds(2));
                Console.WriteLine("Finished doing work");
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error in DoWork: {e}");
            }
        }

        Console.WriteLine("Stopped");
    }
}
```

And add it to your DI container like this:

```cs
builder.Services.AddHostedService<Worker>();
```

And then when you run your web app, that background job will also run.

But this does create a problem when you deploy to multiple hosts: _how do you coordinate the job so only one host runs
it?_ It is tempting to add a config flag that you can toggle on a single host so that the job only runs there. But
that's a little cumbersome, and you lose one of the benefits of having multiple hosts: redundancy. It would be nice if
all the hosts remained identical, and coordinated amongst themselves. You can achieve this by having the worker take a
lock on some external shared resource, like a record in a database table, a shared file, etc. In this example, I'll use
an _Azure Storage Blob lease_, which is especially convenient if your project is already using blob storage.

Leases are cheap, fast, exclusive, and can have an optional short lifetime. Whether you use a blob lease or some other shared
state, the approach is similar:

```

  +---------------+
 /                 \
/   Acquire Lease?  \ -------+
\                   /  fail  |
 \-----------------/         |
          | success          |
          v                  |
+-------------------+        |
|      Do Work      |        |
+-------------------+        |
          |                  |
          v                  |
+-------------------+        |
|   Release Lease   |        |
+-------------------+        |
          |                  |
          v                  |
+-------------------+        |
|  Wait and repeat  |<-------+
+-------------------+
```

Let's create this helper to do that, `Lease.cs`:

```cs
// Lease.cs
// dotnet add package azure.storage.blobs
// dotnet add package azure.storage.blobs
using Azure;
using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Specialized;
using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

public class Lease : IAsyncDisposable
{
    public string? LeaseId { get; private set; }
    private PeriodicTimer? _renewTimer;
    private Task? _renewTask;
    protected BlobLeaseClient? blobLeaseClient;

    /// <summary>
    /// Acquire a lease on the given blob. Returns null if unsuccessful.
    /// </summary>
    public static async Task<Lease?> AcquireLease(BlobContainerClient blobContainerClient, string blobName, CancellationToken cancellationToken)
    {
        Lease lease = new();
        var blob = blobContainerClient.GetBlobClient(blobName);

        // create empty blob if it doesn't exist
        if (!await blob.ExistsAsync(cancellationToken: cancellationToken))
            await blob.UploadAsync(new MemoryStream([]), cancellationToken: cancellationToken);

        // get a 1-minute lease (the maximum, unless you want an infinite lease)
        lease.blobLeaseClient = blob.GetBlobLeaseClient();

        try
        {
            var leaseResponse = await lease.blobLeaseClient.AcquireAsync(TimeSpan.FromMinutes(1), cancellationToken: cancellationToken);
            Console.WriteLine("Lease acquired");
            lease.LeaseId = leaseResponse.Value.LeaseId;
        }
        catch (RequestFailedException e) when (e.Status == 409)
        {
            return null; // couldn't get lease because blob is already leased
        }

        // renew the lease regularly to keep other workers from stepping on our toes
        lease._renewTimer = new PeriodicTimer(TimeSpan.FromSeconds(50));
        lease._renewTask = Task.Factory.StartNew(async () =>
        {
            try
            {
                while (await lease._renewTimer.WaitForNextTickAsync(cancellationToken))
                {
                    if (lease.LeaseId is not null)
                    {
                        await lease.blobLeaseClient.RenewAsync(cancellationToken: cancellationToken);
                        Console.WriteLine("Lease renewed");
                    }
                }
            }
            catch (OperationCanceledException) { /* shutting down */ }
        });

        return lease;
    }

    public async ValueTask DisposeAsync()
    {
        _renewTimer?.Dispose(); // stop the timer

        if (_renewTask is not null)
            await _renewTask; // wait for the timer to finish any active work

        if (LeaseId is not null && blobLeaseClient is not null)
        {
            await blobLeaseClient.ReleaseAsync(cancellationToken: CancellationToken.None);
            Console.WriteLine("Lease released");
        }
    }
}
```

Then our worker code might look like this:

```cs
// Worker.cs
using Azure.Storage.Blobs;
using Microsoft.Extensions.Hosting;
using System;
using System.Threading;
using System.Threading.Tasks;

public class Worker(BlobContainerClient blobContainerClient) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        Console.WriteLine("Started");

        using PeriodicTimer timer = new(TimeSpan.FromSeconds(10));
        while (await timer.WaitForNextTickAsync(stoppingToken))
        {
            try
            {
                Console.WriteLine("Doing work");

                var blobName = nameof(Worker);
                await using var lease = await Lease.AcquireLease(blobContainerClient, blobName, stoppingToken);
                if (lease is null)
                {
                    Console.WriteLine($"Failed to acquire lease on {blobName}. Will try again next time.");
                    continue;
                }

                await Task.Delay(TimeSpan.FromSeconds(2));
            }
            catch (Exception e) when (e is not OperationCanceledException)
            {
                Console.WriteLine($"Error in DoWork: {e}");
            }
            finally
            {
                Console.WriteLine("Finished doing work");
            }
        }

        Console.WriteLine("Stopped");
    }
}
```

And add something like this to Program.cs:

```cs
builder.Services.AddSingleton(di =>
{
    var blobContainerClient = new BlobContainerClient(builder.Configuration["BlobStorageConnectionString"], "container");
    if (!blobContainerClient.Exists())
        blobContainerClient.Create();

    return blobContainerClient;
});
```

With all that in place, running two concurrent instances of this app shows how they coordinate with the lease to
continue doing the periodic job, but only one at a time:

```sh
# terminal window one:
$ DOTNET_URLS="http://*:5202" dotnet run
Doing work
Lease acquired
Lease released
Finished doing work

Doing work
Failed to acquire lease on Worker. Will try again next time.
Finished doing work
```

```sh
# terminal window two
$ DOTNET_URLS="http://*:5203" dotnet run
Doing work
Lease acquired
Lease released
Finished doing work
```

That's a fair bit if set-up, but once it's in place, adding another exclusive worker is very simple. You could even make
an abstract worker that hides virtually everything, demanding that you only implement a `DoWork` method and set a period
🤔...

[1]: https://learn.microsoft.com/en-us/aspnet/core/fundamentals/host/hosted-services?view=aspnetcore-8.0&tabs=visual-studio "Background tasks with hosted services in ASP.NET Core"
