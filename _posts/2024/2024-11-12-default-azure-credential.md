---
layout: post
date: "2024-11-12"
categories:
    - technology
title: "Speeding up .NET DefaultAzureCredential"
---

Connecting to Azure services with role-based access controls (RBAC) and tokens is an increasingly delightful experience.
You run your local build *as you*, and run your deployment *as a managed identity*. At no point do you need to save
tokens, secrets, or keys in your code or deployment environment. The [`DefaultAzureCredential`][1] class provides an
easy start by attempting to get an auth token from all of these sources, stopping when it gets one:

1. EnvironmentCredential
2. WorkloadIdentityCredential
3. ManagedIdentityCredential
4. SharedTokenCacheCredential
5. VisualStudioCredential
6. VisualStudioCodeCredential
7. AzureCliCredential
8. AzurePowerShellCredential
9. AzureDeveloperCliCredential
{: .col-15}

As you can imagine, when running locally, it will get a token from your IDE, or CLI, and when deployed, it'll get a
token from the managed identity. This works _really well_ and it's _so convenient_. But there are two things we can do
to _make it a lot faster._

## Use something more specific than _DefaultAzureCredential_

First, follow the [documentation's advice][2] and use something more specific instead. For instance, if you _know_
you'll use managed identity when deployed, and various others in local dev, then set it up that way:

```cs
TokenCredential azureCredential =
    builder.Environment.IsProduction()
        ? new ManagedIdentityCredential()
        : new ChainedTokenCredential(
            new AzureCliCredential(),
            new VisualStudioCodeCredential(),
            new VisualStudioCredential());
```

This will speed things up by jumping right to the auth methods that are expected to work in each place.

## Reuse the token credential

The docs recommend you reuse this `TokenCredential` object since it contains a cache of the token, and manages
refreshes. Keep it around!

```cs
builder.Services.AddSingleton(azureCredential);
```

And inject it this one instance wherever you need a token, e.g.:

```cs
// or connect to blob service with a TokenCredential
// requires RBAC role "Storage Blob Data Contributor" for you and your managed identity
BlobServiceClient client = new(primaryBlobUri, azureCredential);
//                           TokenCredential --^

// or connect to table service with a TokenCredential
// requires RBAC role "Storage Table Data Contributor" for you and your managed identity
TableServiceClient tsc = new(primaryTableUri, azureCredential);

// or connect to GraphAPI with Http calls, with a token from the TokenCredential
// requires graphapi permissions for you and your managed identity: https://techcommunity.microsoft.com/blog/integrationsonazureblog/grant-graph-api-permission-to-managed-identity-object/2792127
builder.Services.AddHttpClient<YourGraphApiHttpClient>(client =>
{
    var accessToken = azureCredential.GetToken(new TokenRequestContext(["https://graph.microsoft.com/.default"]), default);
    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken.Token);
    client.BaseAddress = new Uri("https://graph.microsoft.com/");
});
```

## Logging

To help see that the expected token providers are being used, and that tokens aren't being created more than you expect
(i.e. that caching and refreshes are working) you can [enable logging][3]:

```cs
// Program.cs
// log azure credential events to verify they're getting reused as desired
using Azure.Core.Diagnostics.AzureEventSourceListener listener = new((args, message) =>
{
    if (args is { EventSource.Name: "Azure-Identity" })
        Console.WriteLine(message);
}, System.Diagnostics.Tracing.EventLevel.LogAlways);
```

## Where to put other non-Azure secrets like API keys?

Connecting to services with your own identity and a managed identity is so nice, but what about a random API key or
other secret that doesn't fit? Instead of sticking that into your `appsettings.json` file, try using Azure Key Vault and
its [configuration provider][4] (requires [a package][5]). This is magical:

```cs
// use managed identity in prod, and whatever in dev (same as above)
TokenCredential azureCredential = builder.Environment.IsProduction()
    ? new ManagedIdentityCredential()
    : new ChainedTokenCredential(new AzureCliCredential(), new VisualStudioCodeCredential(), new VisualStudioCredential(), new AzurePowerShellCredential());
builder.Services.AddSingleton(azureCredential);

// load config from Key Vault
// requires RBAC role "Key Vault Secrets User" for you and your managed identity
// requires package Azure.Extensions.AspNetCore.Configuration.Secrets
string keyVaultUrl = builder.Configuration["KeyVaultUri"] ?? throw new InvalidOperationException("KeyVaultUri is missing");
builder.Configuration.AddAzureKeyVault(new Uri(keyVaultUrl), azureCredential);
```

Then over in Key Vault you can enter a secret like `ApiKey: foo` or `Section--SecretName: secret_value123!`, and load it
from your code like you would any other configuration value:

```cs
// like this
string secret = builder.Configuration["ApiKey"];

// or 
SomeServiceConfig config = builder.Configuration.GetSection("SomeService").Get<SomeServiceConfig>() ?? throw new InvalidOperationException("SomeServiceConfig configuration is missing");
```

The configuration providers will coalesce your environment variables, appsettings, Key Vault secrets, etc. to meet your
expectations.

[1]: https://learn.microsoft.com/en-us/dotnet/api/azure.identity.defaultazurecredential?view=azure-dotnet "DefaultAzureCredential Class"
[2]: https://learn.microsoft.com/en-us/dotnet/azure/sdk/authentication/credential-chains?tabs=dac#usage-guidance-for-defaultazurecredential "Usage guidance for DefaultAzureCredential"
[3]: https://learn.microsoft.com/en-us/dotnet/azure/sdk/authentication/credential-chains?tabs=dac#debug-a-chained-credential "Debug a chained credential"
[4]: https://learn.microsoft.com/en-us/aspnet/core/security/key-vault-configuration?view=aspnetcore-8.0 "Azure Key Vault configuration provider in ASP.NET Core"
[5]: https://www.nuget.org/packages/Azure.Extensions.AspNetCore.Configuration.Secrets "Azure.Extensions.AspNetCore.Configuration.Secrets package"
