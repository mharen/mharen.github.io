---
layout: post
date: "2024-12-12"
categories:
    - technology
    - code
title: "Faking microseconds with .NET Blazor WASM"
---

Today I learned that `DateTime` objects are only preceise down to the millisecond when compiled down to WebAssembly (WASM) and hosted by the browser. For instance:

```cs
DateTime d = new DateTime();
d.ToString("o"); 
// server-side => 2024-12-12T21:18:14.8730419
// client-side => 2024-12-12T21:18:14.8730000
                                         ^^^^
```

This shows up anywhere you look beyond milliseconds:

```cs
d.ToString("FFFFFFF"); 
// server-side => 8730419
// client-side => 8730000
                     ^^^^

d.Ticks;
// server-side => 638696350948730419
// client-side => 638696350948730000
                                ^^^^
```

I guess this makes sense since JS dates only have millisecond precision, and that's what we have in WASM-land. And I imagine greater precision is rarely needed. But I need it! About 11 years ago I made a simple site that showed a live-updating view of all the `DateTime` format strings. It updated once per second:

<picture>
    <source srcset="/assets/2024/old-datetime-tostring-dark.gif" media="(prefers-color-scheme: dark)">
    <img height="720" width="1280" src="/assets/2024/old-datetime-tostring-light.gif" alt='an animation showing the seconds tick by of datetimetostring.com' />
</picture>

As I ported a bunch of my random sites to a new host it seemed like a good time to migrate this thing to modern .NET. The old site had two goals above all others:

1. It should accurately show what .NET does with format strings
2. It should update dynamically

The old one achieved this by calling an API to render the format strings with c# code on the server, and then loading them into the page. It's lightweight work, but it's a little sad that it had to hit the server every second to update. As I faced the challenge of porting it from .NET 4.5 to .NET 8, I realized that there's a new tool available now: WASM. With Blazor, I can deploy actual .NET assemblies to the browser and do all that formatting and refreshing _locally_.

But I had a problem with my first pass at this: the server-rendered page hit looked good, but the WASM-powered, dynamic updates had zeroes for all numbers finer than a millisecond. Boo! Rather than _actually_ achieving sub-millisecond precision, I can just fake it; I just want it to _look_ good, I don't actually need the numbers to be correct.

There are two places where my page shows sub-millisecond values and I used simple solutions in each. 

First, I call `.ToString()` with up to 7 Fs. WASM would produce something like this:

```cs
d.ToString("FFF");     // client-side => 873
d.ToString("FFFF");    // client-side => 8730
d.ToString("FFFFF");   // client-side => 87300
d.ToString("FFFFFF");  // client-side => 873000
d.ToString("FFFFFFF"); // client-side => 8730000
```

The fix:

```cs
// e.g. "0419"
string fakeMicroseconds = Random.Shared.Next(0, 9999).ToString("D4");

d.ToString("FFF");                              // => 873
d.ToString("FFFF")    + fakeMicroseconds[0];    // => 8730
d.ToString("FFFFF")   + fakeMicroseconds[..2];  // => 87304
d.ToString("FFFFFF")  + fakeMicroseconds[..3];  // => 873041
d.ToString("FFFFFFF") + fakeMicroseconds[..4];  // => 8730419
```

And then we have strings like `2024-12-12T21:18:14.8730000` and `2024-12-12T21:18:14.8730000-05:00`. Fixing those is pretty easy too:

```cs
public static string FillMicroseconds(this string formattedDate, string fakeMicroseconds)
{
    var index = formattedDate.LastIndexOf("0000");

    if (index < 0)
        return formattedDate;

    return string.Concat(
        formattedDate.AsSpan(0, index),
        fakeMicroseconds,
        formattedDate.AsSpan(index + 4));
}
```

That's right, we just find the four zeros and replace them with the fake value. I think the <a href="https://datetimetostring.wassupy.com">result is pretty neat</a>. It works so well that I updated the refresh rate to 10x/sec:

<picture>
    <source srcset="/assets/2024/new-datetime-tostring-dark.gif" media="(prefers-color-scheme: dark)">
    <img height="720" width="1280" src="/assets/2024/new-datetime-tostring-light.gif" alt='an animation showing the seconds tick by of datetimetostring.com' />
</picture>