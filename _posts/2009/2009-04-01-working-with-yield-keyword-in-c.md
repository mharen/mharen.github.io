---
layout: post
date: '2009-04-01T22:24:00.004-04:00'
categories:
title: Working with the Yield keyword in C#
---

I just started using a neat trick in C# when working with iterators: the `yield` keyword. This lets you easily return items as an IEnumerable without having to worry about state.

It looks like this:

```cs
using System;
using System.Collections.Generic;
using System.Text;

namespace WorkingWithYield
{
 class Program
 {
     static IEnumerable<string> GetIDs()
     {
         for (int i = 0; i < 10; i++)
         {
             Console.WriteLine("generating " + i);
             yield return i.ToString();
         }
     }

     static void Main(string[] args)
     {
         IEnumerable<string> IDs = GetIDs();

         foreach (string ID in IDs)
             Console.WriteLine("printing   " + ID);

         Console.Read();
     }
 }
}
```

Output:

```
generating 0
printing   0
generating 1
printing   1
generating 2
printing   2
generating 3
printing   3
generating 4
printing   4
generating 5
printing   5
generating 6
printing   6
generating 7
printing   7
generating 8
printing   8
generating 9
printing   9
```

As you can see, the system effectively pauses the loop when it returns an item to the foreach loop--the numbers are lazily generated when needed, not all at once before they are printed.

When an IEnumerable works, this can be very handy. Neat stuff.