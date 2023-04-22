---
layout: post
date: '2009-06-22T23:09:00.003-04:00'
categories: code
title: C# and VB.NET Compared
---


C# (and .NET) has come a long, long way since the early days of .NET 1.1. Let me start by clearing up some confusion about version numbers, [quoting](http://stackoverflow.com/questions/247621/what-are-the-correct-version-numbers-for-c/247623#247623):
<blockquote> 

These are the versions of C# known about at the time of this writing:    <ul>     <li>C# 1.0; released with .NET 1.0 and VS2002 (in 2002)</li>      <li>C# 1.2 (bizarrely enough); released with .NET 1.1 and VS2003 (in 2003). First version to call Dispose on IEnumerators which implemented IDisposable. A few other small features.</li>      <li>C# 2.0; released with .NET 2.0 and VS2005 (November 2005). Major new features: generics, anonymous methods, nullable types, iterator blocks</li>      <li>C# 3.0; released with .NET 3.5 and VS2008 (November 2007). Major new features: lambda expressions, extension methods, expression trees, anonymous types, implicit typing (var), query expressions</li>      <li>C# 4.0; to be released with .NET 4.0 and VS2010 (release date unknown). Major new proposed features: late binding (dynamic), delegate and interface generic variance, more COM support, named and optional parameters</li>      <li>C# 5.0; unknown time frame. Major new speculated features: metaprogramming</li>   </ul>  

**There is no such thing as C# 3.5** - the cause of confusion here is that the C# 3.0 is present in .NET 3.5. The language and framework are versioned independently, however - as is the CLR, which is still (at the time of .NET 3.5) at version 2.0, service packs notwithstanding.
</blockquote>

Now to the topic of the day: a few things that VB.NET has that C# lacks:  <h4>XML Literals</h4>

XML Literals are definitely worth checking out if you do much with VB. Here's a snippet to give you an idea of what they look like:
<blockquote>   <pre class="csharpcode"><span class="kwrd">Function</span> ExportAsXml(<span class="kwrd">ByVal</span> invoices <span class="kwrd">As</span> List(Of Invoice)) _ <span class="kwrd">
As</span> <span class="kwrd">String</span>
  <span class="kwrd">Dim</span> XDoc <span class="kwrd">As</span> XElement = _
      &lt;Invoices xmlns=<span class="str">"http://tempuri.org/Schema/…"</span>&gt;
          &lt;%= From invoice <span class="kwrd">In</span> invoices <span class="kwrd">Select</span> _
              &lt;Invoice ID  = &lt;%= invoice.ID %&gt;
               DueDate     = &lt;%= invoice.DueDate %&gt;
               Amount      = &lt;%= invoice.Amount %&gt;
               Customer    = &lt;%= invoice.Customer %&gt;/&gt; %&gt;
              &lt;/Invoices&gt;
  <span class="kwrd">Return</span> XDoc.ToString
<span class="kwrd">End</span> <span class="kwrd">Function</span></pre></blockquote>
The effect is a little subtle at first—look closely and you’ll see something sweet: there is XML floating around in there without quotes. This feature won’t be coming to C# anytime soon, but [similar functionality](http://social.msdn.microsoft.com/forums/en-US/linqprojectgeneral/thread/ba2883c0-b66b-4d5a-a272-de4e86c70bbb/) can be achieved.<h4>Optional and Named Arguments</h4>
Another nice feature of VB, optional and named arguments is coming to C# later this year in C#4. While optional arguments can be largely avoided with overloading (and are [not very popular](http://www.knowdotnet.com/articles/optionalparams.html) to begin with), named parameters are nice. They provide a lot of clarity to maintenance programmers by calling our what means what. For example:
<blockquote><pre class="csharpcode">var Invoice = <span class="kwrd">new</span> Invoice(
CustomerID, InvoiceTotal, <span class="kwrd">false</span>, <span class="kwrd">new</span> DateTime(2009,6,23));

var Invoice = <span class="kwrd">new</span> Invoice(
customerID: CustomerID, total: InvoiceTotal,
isCanceled: <span class="kwrd">false</span>, dueDate: <span class="kwrd">new</span> DateTime(2009,6,23));</pre></blockquote>
The second version is clearly more verbose but I think it provides some clear benefits. We can now immediately see what the boolean and date parameters were for without hovering or using variables just to get nice names.
IsNumeric and DateDiff are among many common functions that are actually available in C# if you add a reference to Microsoft.VisualBasic. I avoid doing this because without optional argument support, they can be a little awkward to use. C# and .NET now also include other options like TryParse on most types and date arithmetic with TimeSpans.<h4>Overflow/Underflow Checking</h4>
There are also a few semantic differences between the two languages. For example, VB checks mathematic operations for overflow and underflow whereas [C# does not](http://msdn.microsoft.com/en-us/library/74b4xzyw%28VS.71%29.aspx). C# allows you to control this very easily with checked/unchecked blocks:<blockquote><pre class="csharpcode"><span class="rem">// will raise a System.OverflowException exception</span>
<span class="kwrd">int</span> input = <span class="kwrd">int</span>.MinValue;
<span class="kwrd">checked</span> {
 input--;
}
<span class="kwrd">return</span> input;

<span class="rem">// will overflow/underflow silently</span>
<span class="kwrd">int</span> input = <span class="kwrd">int</span>.MinValue;
<span class="kwrd">unchecked</span> {
 input--;
}
<span class="kwrd">return</span> input;</pre></blockquote>
As far as I can tell, VB doesn’t provide this level of control—it’s either on or off for the whole project.<h4>Automatically Implemented Properties</h4>
Another feature exclusive to C# is automatically implemented properties. For example, here’s the old style:<blockquote><pre class="csharpcode"><span class="rem">// C#2</span>
<span class="kwrd">private</span> <span class="kwrd">string</span> name;
<span class="kwrd">public</span> <span class="kwrd">string</span> Name
{
  get { <span class="kwrd">return</span> <span class="kwrd">this</span>.name; }
  set { <span class="kwrd">this</span>.name = <span class="kwrd">value</span>; }
}</pre></blockquote>
and the new style available in C#3:
<blockquote><pre class="csharpcode"><span class="rem">// C#3</span>
<span class="kwrd">public</span> <span class="kwrd">string</span> Name { get; set; }

<span class="rem">// C#3: or, with narrower set scope</span>
<span class="kwrd">public</span> <span class="kwrd">string</span> Name { get; <span class="kwrd">protected</span> set; }</pre></blockquote>
I love when I can reduce boilerplate/housekeeping code like this. [Less code is better code](http://www.codinghorror.com/blog/archives/000878.html).<h4>Coalesce </h4>
C# also has VB beat with it’s coalesce operator, though admittedly I don’t use this very often:<blockquote><pre class="csharpcode"><span class="rem">// (C#3) returns the first non-null object </span>
<span class="rem">// or null if each is null</span>
<span class="kwrd">return</span> object1 ?? object2 ?? object3;</pre></blockquote>
























That requires a much less elegant approach in VB or C#2.<h4>Iterator Blocks</h4>
C# majorly trumps VB with iterator blocks using the yield keyword. I’ve been using these more and more lately and am surprised they aren’t in VB yet. I didn’t really do them justice in [my last post](http://mharen.blogspot.com/2009/04/working-with-yield-keyword-in-c.html) so look elsewhere [for](http://csharpindepth.com/Articles/Chapter6/IteratorBlockImplementation.aspx) [in](http://msdn.microsoft.com/en-us/library/ee5kxzk0%28VS.80%29.aspx) [depth](http://www.developerfusion.com/article/9398/iterators-iterator-blocks-and-data-pipelines-in-c/) [examples](http://www.ondotnet.com/pub/a/dotnet/2004/06/07/liberty.html).

---

## 2 comments captured from [original post](https://blog.wassupy.com/2009/06/few-things-visual-basic-net-has-over-c.html) on Blogger

**Math Zombie said on 2009-06-25**

So who is this post for? 

Is C# a programming language? like c and c++?

**Michael Haren said on 2009-06-25**

Yes, C# is a programming language. It's syntax is similar to C/C++ but more closely resembles Java. It's actually very similar to Java, now that I think about it.

