---
layout: post
date: '2024-11-08'
categories:
- technology
title: "Don't use async callbacks with System.Threading.Timer"
---

You might be tempted to do this in cs/.net, which compiles and seems to run just fine:

```cs
// do something every 10 seconds
System.Threading.Timer timer = new (async _ =>
{
    try
    {
        // do work
        await Task.Delay(TimeSpan.FromSeconds(5));
    }
}, null, TimeSpan.Zero, TimeSpan.FromSeconds(10));
```

While it will work on the happy path, there are two problems with this approach:
1. Exceptions will not bubble up anywhere
2. Shutdown will not block for an active task—it will be abandoned

Attempts to improve it by manually disposing the timer with a `WaitHandle` on shutdown do not work:

```cs
// this does not help anything!
AutoResetEvent reset = new(false);
timer.Dispose(reset); 
reset.WaitOne();
```

The problem is that the timer's callback is not `await`ed anywhere—the callback finishes as soon as it
constructs the Task to hold it (i.e. instantly) so there's nothing for `.WaitOne` to wait for.

Here's a better option, which works better with async semantics and has fewer surprises:

```cs
// do something every 10 seconds
using PeriodicTimer timer = new(TimeSpan.FromSeconds(10));

while (await timer.WaitForNextTickAsync(cancellationToken))
{
  // do work
  await Task.Delay(TimeSpan.FromSeconds(5));
}
```

The `PeriodicTimer` has a lot going for it:
* It won't lead to overlapping executions if the body takes longer than the timer period
* `.WaitForNextTickAsync` returns _false_ when the `CancellationToken` is fired, which is very convenient
* All the fraught threading stuff is limited to the existing `async` paradigm
* Shutdown is blocked until the "do work" task is finished, and you can handle cancellation appropriately for your situation

The only lingering annoyance is that you can't initialize a `PeriodicTimer` with a _due time_ different from the _period_,
i.e. you can't make it fire immediately, and then again every period, like you can with a `Timer`. Accounting for that
is not so bad, though:


```cs
// do it now
await DoWork();

// and every 10 seconds
using PeriodicTimer timer = new(TimeSpan.FromSeconds(10));

while (await timer.WaitForNextTickAsync(cancellationToken))
{
  // do work
  await DoWork();
}

// ...
private async Task DoWork() { /* ... */ }
```

Ref: [System.Threading.PeriodicTimer](https://learn.microsoft.com/en-us/dotnet/api/system.threading.periodictimer?view=net-8.0),
[System.Threading.Timer](https://learn.microsoft.com/en-us/dotnet/api/system.threading.timer?view=net-8.0) 
