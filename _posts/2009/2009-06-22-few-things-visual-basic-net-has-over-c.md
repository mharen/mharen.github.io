---
layout: post
date: '2009-06-22T23:09:00.003-04:00'
categories: code
title: C# and VB.NET Compared
---

C# (and .NET) has come a long, long way since the early days of .NET 1.1. Let me start by clearing up some confusion about version numbers, [quoting](http://stackoverflow.com/questions/247621/what-are-the-correct-version-numbers-for-c/247623#247623):

> These are the versions of C# known about at the time of this writing:     
> * C# 1.0; released with .NET 1.0 and VS2002 (in 2002)  
> * C# 1.2 (bizarrely enough); released with .NET 1.1 and VS2003 (in 2003). First version to call Dispose on IEnumerators which implemented IDisposable. A few other small features.  
> * C# 2.0; released with .NET 2.0 and VS2005 (November 2005). Major new features: generics, anonymous methods, nullable types, iterator blocks  
> * C# 3.0; released with .NET 3.5 and VS2008 (November 2007). Major new features: lambda expressions, extension methods, expression trees, anonymous types, implicit typing (var), query expressions  
> * C# 4.0; to be released with .NET 4.0 and VS2010 (release date unknown). Major new proposed features: late binding (dynamic), delegate and interface generic variance, more COM support, named and optional parameters  
> * C# 5.0; unknown time frame. Major new speculated features: metaprogramming   
>
> **There is no such thing as C# 3.5** - the cause of confusion here is that the C# 3.0 is present in .NET 3.5. The language and framework are versioned independently, however - as is the CLR, which is still (at the time of .NET 3.5) at version 2.0, service packs notwithstanding.

Now to the topic of the day: a few things that VB.NET has that C# lacks:

### XML Literals

XML Literals are definitely worth checking out if you do much with VB. Here's a snippet to give you an idea of what they look like:

```vb
Function ExportAsXml(ByVal invoices As List(Of Invoice)) _ <span class="kwrd">
As</span> String
  Dim XDoc As XElement = _
      <Invoices xmlns="http://tempuri.org/Schema/...">
          <%= From invoice In invoices Select _
              <Invoice ID  = <%= invoice.ID %>
               DueDate     = <%= invoice.DueDate %>
               Amount      = <%= invoice.Amount %>
               Customer    = <%= invoice.Customer %>/> %>
              </Invoices>
  Return XDoc.ToString
End Function
```

The effect is a little subtle at first—look closely and you’ll see something sweet: there is XML floating around in there without quotes. This feature won’t be coming to C# anytime soon, but [similar functionality](http://social.msdn.microsoft.com/forums/en-US/linqprojectgeneral/thread/ba2883c0-b66b-4d5a-a272-de4e86c70bbb/) can be achieved.

### Optional and Named Argument
Another nice feature of VB, optional and named arguments is coming to C# later this year in C#4. While optional arguments can be largely avoided with overloading (and are [not very popular](http://www.knowdotnet.com/articles/optionalparams.html) to begin with), named parameters are nice. They provide a lot of clarity to maintenance programmers by calling our what means what. For example:

```cs
var Invoice = new Invoice(
  CustomerID, InvoiceTotal, false, new DateTime(2009,6,23));

var Invoice = new Invoice(
  customerID: CustomerID, total: InvoiceTotal,
  isCanceled: false, dueDate: new DateTime(2009,6,23));
```

The second version is clearly more verbose but I think it provides some clear benefits. We can now immediately see what the boolean and date parameters were for without hovering or using variables just to get nice names.
IsNumeric and DateDiff are among many common functions that are actually available in C# if you add a reference to Microsoft.VisualBasic. I avoid doing this because without optional argument support, they can be a little awkward to use. C# and .NET now also include other options like TryParse on most types and date arithmetic with TimeSpans.

### Overflow/Underflow Checkin
There are also a few semantic differences between the two languages. For example, VB checks mathematic operations for overflow and underflow whereas [C# does not](http://msdn.microsoft.com/en-us/library/74b4xzyw%28VS.71%29.aspx). C# allows you to control this very easily with checked/unchecked blocks:

```cs
// will raise a System.OverflowException exception
int input = int.MinValue;
checked {
  input--;
}
return input;

// will overflow/underflow silently
int input = int.MinValue;
unchecked {
  input--;
}
return input;
```

As far as I can tell, VB doesn’t provide this level of control—it’s either on or off for the whole project.

### Automatically Implemented Properties

Another feature exclusive to C# is automatically implemented properties. For example, here’s the old style:

```cs
// C#2
private string name;
public string Name
{
  get { return this.name; }
  set { this.name = value; }
}
```

and the new style available in C#3:

```cs
// C#3
public string Name { get; set; }

// C#3: or, with narrower set scope
public string Name { get; protected set; }
```

I love when I can reduce boilerplate/housekeeping code like this. [Less code is better code](http://www.codinghorror.com/blog/archives/000878.html).

### Coalesce
C# also has VB beat with it’s coalesce operator, though admittedly I don’t use this very often:

```cs
// (C#3) returns the first non-null object 
// or null if each is null
return object1 ?? object2 ?? object3;
```

That requires a much less elegant approach in VB or C#2.

### Iterator Block

C# majorly trumps VB with iterator blocks using the yield keyword. I’ve been using these more and more lately and am surprised they aren’t in VB yet. I didn’t really do them justice in [my last post](http://mharen.blogspot.com/2009/04/working-with-yield-keyword-in-c.html) so look elsewhere [for](http://csharpindepth.com/Articles/Chapter6/IteratorBlockImplementation.aspx) [in](http://msdn.microsoft.com/en-us/library/ee5kxzk0%28VS.80%29.aspx) [depth](http://www.developerfusion.com/article/9398/iterators-iterator-blocks-and-data-pipelines-in-c/) [examples](http://www.ondotnet.com/pub/a/dotnet/2004/06/07/liberty.html).

---

### 2 comments

**Math Zombie said on 2009-06-25**

So who is this post for? 

Is C# a programming language? like c and c++?

**Michael Haren said on 2009-06-25**

Yes, C# is a programming language. It's syntax is similar to C/C++ but more closely resembles Java. It's actually very similar to Java, now that I think about it.

Comments closed
{: .comments-closed }