---
date: '2010-10-31T19:54:00.001-04:00'
description: ''
published: true
slug: 2010-10-list-clear-vs-new-variable-passing-in-c
categories:
- Code
- Technology
time_to_read: 5
title: 'List<T>: .Clear() vs. new; Variable Passing in C#'
---


A colleague asked me a C# question on [Twitter](http://twitter.com/#!/XOver9000/status/29231958731):  

![image%5B1%5D.png](image%5B1%5D.png)

I had some trouble responding in 140 characters, so I replied with [a](http://twitter.com/#!/mharen/status/29232621954) [few](http://twitter.com/#!/mharen/status/29232755840) [tweets](http://twitter.com/#!/mharen/status/29232755840) that really didn’t do the question justice. There are a few issues at hand: style and correctness. 

First, when it comes to style, the best guiding principle in programming is clarity. You should express your intent as clearly as possible. If .Clear() represents your intent better than newing up a List, go with it.

The bigger issue is, of course, correctness. Who cares if your code expresses your intent if it’s wrong? In most situations, it probably doesn’t matter which you choose because each will have the effect you wanted. However, these have a few differences. Off the top of my head there’s the pointer/reference issue (noted in my [first tweet](http://twitter.com/#!/mharen/status/29232621954)) and I’m betting something to do with Capacity which I’ll test in a minute.

C# doesn’t really have pointers per se. Instead, it feels like every non-value type thing—object (e.g. List)—gets passed around kind of like you’re using pointers, you just don’t know it. This becomes really important when you start newing up objects in helper methods.

For example, what do you suppose happens in this code?:
<blockquote>   <pre class="csharpcode"><span class="kwrd">void</span> Main()
{
    <span class="kwrd">string</span> A = <span class="str">&quot;aaa&quot;</span>;
    <span class="kwrd">string</span> B = <span class="str">&quot;bbb&quot;</span>;
    
    Console.WriteLine(<span class="str">&quot;Before Swap: A is '{0}', B is '{1}'&quot;</span>, A, B);
    
    Swap(A, B);
    
    Console.WriteLine(<span class="str">&quot;After Swap:  A is '{0}', B is '{1}'&quot;</span>, A, B);
}

<span class="kwrd">void</span> Swap(<span class="kwrd">string</span> a, <span class="kwrd">string</span> b){
    <span class="kwrd">string</span> tmp = a;
    a = b;
    b = tmp;
}</pre>
</blockquote>


Does it work? Of course since I’m asking, it probably doesn’t! Here’s the output:

<blockquote>


Before Swap: A is 'aaa', B is 'bbb' 
    

After Swap:&#160; A is 'aaa', B is 'bbb'
</blockquote>


The reason this doesn’t work is that what we’re passing to the Swap function are just a couple of pointers to the memory location that holds the string data “aaa” and “bbb”. **The objects are *not passed by reference*, but rather references to the objects are passed *by value***.


It seems nitpicky, but it really is important to understanding how this stuff works. Here’s the correct implementation:

<blockquote>
  <pre class="csharpcode"><span class="kwrd">void</span> Main()
{
    <span class="kwrd">string</span> A = <span class="str">&quot;aaa&quot;</span>;
    <span class="kwrd">string</span> B = <span class="str">&quot;bbb&quot;</span>;
    
    Console.WriteLine(<span class="str">&quot;Before Swap: A is '{0}', B is '{1}'&quot;</span>, A, B);
    
    Swap(<span class="kwrd">**ref**</span> A, <span class="kwrd">**ref**</span> B);
    
    Console.WriteLine(<span class="str">&quot;After Swap:  A is '{0}', B is '{1}'&quot;</span>, A, B);
}

<span class="kwrd">void</span> Swap(<span class="kwrd">**ref**</span> <span class="kwrd">string</span> a, <span class="kwrd">**ref**</span> <span class="kwrd">string</span> b){
    <span class="kwrd">string</span> tmp = a;
    a = b;
    b = a;
}</pre>
</blockquote>


Output:

<blockquote>


Before Swap: A is 'aaa', B is 'bbb' 
    

After Swap:&#160; A is 'bbb', B is 'bbb'
</blockquote>


The only difference is the “ref” keyword added to the method and its call. C# does a great thing for us by making this very explicit (probably because it’s rarely what you actually want).


So back to the original question. “.Clear()” or “new” for a List&lt;T&gt;? As I’ve shown, once the style issue is resolved, it’s merely a matter of correctness. Suppose you had a method for refreshing a list. Which of these is best?:

<blockquote>
  <pre class="csharpcode"><span class="rem">// return { &quot;1&quot;, &quot;2&quot;, &quot;3&quot; }</span>
<span class="kwrd">void</span> RefreshNew(List&lt;<span class="kwrd">string</span>&gt; list)
{
    list = <span class="kwrd">new</span> List&lt;<span class="kwrd">string</span>&gt;() { <span class="str">&quot;1&quot;</span>, <span class="str">&quot;2&quot;</span>, <span class="str">&quot;3&quot;</span>};
}

<span class="rem">// return { &quot;1&quot;, &quot;2&quot;, &quot;3&quot; }</span>
<span class="kwrd">void</span> RefreshClear(List&lt;<span class="kwrd">string</span>&gt; list)
{
    list.Clear();
    list.Add(<span class="str">&quot;1&quot;</span>);
    list.Add(<span class="str">&quot;2&quot;</span>);
    list.Add(<span class="str">&quot;3&quot;</span>);
}</pre>
</blockquote>


Hopefully it’s starting to sink in at this point that the first one—RefreshNew—doesn’t actually work. Here’s what happens:

<blockquote></blockquote>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">void</span> Main()
{
    List&lt;<span class="kwrd">string</span>&gt; Strings = <span class="kwrd">new</span> List&lt;<span class="kwrd">string</span>&gt;(){ <span class="str">&quot;a&quot;</span>, <span class="str">&quot;b&quot;</span>, <span class="str">&quot;c&quot;</span> };

    Console.Write(<span class="str">&quot;Before Refresh: &quot;</span>);
    Strings.ForEach(x=&gt;Console.Write(x));
    
    RefreshNew(Strings);
    Console.Write(<span class="str">&quot;\nAfter Refresh New:   &quot;</span>);
    Strings.ForEach(x=&gt;Console.Write(x));

    RefreshClear(Strings);
    Console.Write(<span class="str">&quot;\nAfter Refresh Clear: &quot;</span>);
    Strings.ForEach(x=&gt;Console.Write(x));
}</pre>
</blockquote>


And the output:

<blockquote>


Before Refresh: abc 
    

After Refresh New:&#160;&#160; abc 

    

After Refresh Clear: 123
</blockquote>


Again we see that repointing references that were **passed by value** does not have the desired effect. We could update the first implementation to pass its list as a ref parameter but I discourage that. I like the .Clear approach instead. The reason .Clear/.Add works is that you are working with the right object by the time you start manipulating it. You could also sidestep the whole problem by changing the method name to “Rebuild” and have it *return *a new list.


If that’s just crazy and not making any sense to you, I suggest checking out some of the [textbook diagrams](http://www.google.com/images?q=variable%20passing%20reference) that explain this, or read this [excellent post](http://www.yoda.arachsys.com/csharp/parameters.html) by Jon Skeet on the same topic. Both do a far better job at this than me.


This is a topic that was incorrectly taught (or understood) to me in college, so don’t be surprised if you learn something new as I did.

<hr />


There’s that tiny issue of Capacity that I hinted at before. Internally Lists are stored as arrays or whatever—it doesn’t really matter. For performance reasons, since arrays are immutable, they are allocated larger than necessary. This way, you can add elements to them without reallocating the entire thing. The system makes a trade off in avoiding allocating too much by doubling the size of the allocation every time it runs out of space. I suspect that clearing a list does not affect its capacity. Let’s see:

<blockquote>
  <pre class="csharpcode">var List = <span class="kwrd">new</span> List&lt;<span class="kwrd">int</span>&gt;();

Console.WriteLine(<span class="str">&quot;Building list...&quot;</span>);
<span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i&lt;9; i++){
    List.Add(i);
    Console.WriteLine(<span class="str">&quot;List count: {0}, list capacity: {1}&quot;</span>, List.Count, List.Capacity);
}

Console.WriteLine(<span class="str">&quot;\nClearing list...&quot;</span>);
List.Clear();
Console.WriteLine(<span class="str">&quot;List count: {0}, list capacity: {1}&quot;</span>, List.Count, List.Capacity);</pre>
</blockquote>


And the output:

<blockquote>


Building list... 
    

List count: 1, list capacity: 4 

    

List count: 2, list capacity: 4 

    

List count: 3, list capacity: 4 

    

List count: 4, list capacity: 4 

    

List count: 5, list capacity: 8 

    

List count: 6, list capacity: 8 

    

List count: 7, list capacity: 8 

    

List count: 8, list capacity: 8 

    

List count: 9, list capacity: 16



Clearing list... 
    

List count: 0, list capacity: 16
</blockquote>


So it’s as expected: clearing the list does not affect the list’s capacity. This implies that if you are creating a new list which is expected to significantly differ in size, than “Clear()” might not be the way to go. It’s probably a micro-optimization, but I’d say the doubling nature of lists is probably something worth knowing.

---

## 2 comments captured from [original post](https://blog.wassupy.com/2010/10/list-clear-vs-new-variable-passing-in-c.html) on Blogger

**Xander Dumaine said on 2010-11-09**

void Swap(ref string a, ref string b){

    string tmp = a;

    a = b;

    b = a;

}

I believe should be..

void Swap(ref string a, ref string b){

    string tmp = a;

    a = b;

    b = tmp;

}

**Michael Haren said on 2010-11-09**

Yes, thank you! (fixed)

