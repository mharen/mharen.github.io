---
layout: post
date: "2026-08-27"
categories:
    - technology
    - code
title: ".NET config merges arrays by index"
---

TIL if you define an array in config (e.g. `appsettings.json`) and then override it in another file (e.g. `appsettings.Development.json`), .NET's config system will merge the arrays _by index_ rather than replacing one with the other:

```csharp
var config = new ConfigurationBuilder()
    // e.g. appsettings.json
    .AddJsonStream(new MemoryStream(Encoding.UTF8.GetBytes(
        """{ "numbers": [0, 1, 2] }"""
    )))

    // e.g. appsettings.Development.json
    .AddJsonStream(new MemoryStream(Encoding.UTF8.GetBytes(
        """{ "numbers": [3] }"""
    )))

    .Build();

// [3, 1, 2]
var numbers = config.GetSection("numbers").Get<int[]>()!;

// ✔️
Assert.Equal([3, 1, 2], numbers);
```

The second file only overrides index `0`, so indexes `1` and `2` leak through from the first file, giving `[3, 1, 2]`.

If you [expected](https://github.com/dotnet/runtime/issues/118204) the last value to win, i.e. just `[3]`, you're in good company. I found [Patrick Westerhoff](https://github.com/dotnet/runtime/issues/36569#issuecomment-1107003676)'s explanation for why it works this way (and why changing the behavior via options isn't easy) to be the most helpful:

> ...the underlying configuration does not support this.
> 
> ...configuration is loaded as a list of key/value pairs...
> 
> So taking one of the examples above, a JSON `"Modules": [ "Module1", "Module2", "Module3" ]` would
> result in the following configuration values:
> ```
> Modules:0 = Module1
> Modules:1 = Module2
> Modules:2 = Module3
> ```
> And if there’s now another JSON file that contains `"Modules": ["Module4", "Module5"]`, then this 
> would result in these values:
>```
> Modules:0 = Module4
> Modules:1 = Module5
> ```
> At that time, the information that this is JSON is gone. So when the configuration system now 
> overlays the configuration providers on top of each other, you will get these values:
> ```
> Modules:0 = Module4
> Modules:1 = Module5
> Modules:2 = Module3
> ```
