---
date: '2010-10-31T19:54:00.001-04:00'
description: ''
published: true
slug: 2010-10-list-clear-vs-new-variable-passing-in-c
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'List<T>: .Clear() vs. new; Variable Passing in C#'
---

<p>A colleague asked me a C# question on <a href="http://twitter.com/#!/XOver9000/status/29231958731">Twitter</a>:</p>  <p align="center"><img alt="C# - list&lt;T&gt;.clear() or list&lt;T&gt; = new list&lt;T&gt;()?" height="118" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TM4BssqYnrI/AAAAAAAABJw/hqWmieTQhg4/image%5B1%5D.png?imgmax=800" style="margin: 3px; display: inline;" title="" width="465" /></p>  <p>I had some trouble responding in 140 characters, so I replied with <a href="http://twitter.com/#!/mharen/status/29232621954">a</a> <a href="http://twitter.com/#!/mharen/status/29232755840">few</a> <a href="http://twitter.com/#!/mharen/status/29232755840">tweets</a> that really didn’t do the question justice. There are a few issues at hand: style and correctness. </p>  <p>First, when it comes to style, the best guiding principle in programming is clarity. You should express your intent as clearly as possible. If .Clear() represents your intent better than newing up a List, go with it.</p>  <p>The bigger issue is, of course, correctness. Who cares if your code expresses your intent if it’s wrong? In most situations, it probably doesn’t matter which you choose because each will have the effect you wanted. However, these have a few differences. Off the top of my head there’s the pointer/reference issue (noted in my <a href="http://twitter.com/#!/mharen/status/29232621954">first tweet</a>) and I’m betting something to do with Capacity which I’ll test in a minute.</p>  <p>C# doesn’t really have pointers per se. Instead, it feels like every non-value type thing—object (e.g. List)—gets passed around kind of like you’re using pointers, you just don’t know it. This becomes really important when you start newing up objects in helper methods.</p>  <p>For example, what do you suppose happens in this code?:</p>  <blockquote>   <pre class="csharpcode"><span class="kwrd">void</span> Main()
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

<p>Does it work? Of course since I’m asking, it probably doesn’t! Here’s the output:</p>

<blockquote>
  <p>Before Swap: A is 'aaa', B is 'bbb' 
    <br />After Swap:&#160; A is 'aaa', B is 'bbb'</p>
</blockquote>

<p>The reason this doesn’t work is that what we’re passing to the Swap function are just a couple of pointers to the memory location that holds the string data “aaa” and “bbb”. <strong>The objects are <em>not passed by reference</em>, but rather references to the objects are passed <em>by value</em></strong>.</p>

<p>It seems nitpicky, but it really is important to understanding how this stuff works. Here’s the correct implementation:</p>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">void</span> Main()
{
    <span class="kwrd">string</span> A = <span class="str">&quot;aaa&quot;</span>;
    <span class="kwrd">string</span> B = <span class="str">&quot;bbb&quot;</span>;
    
    Console.WriteLine(<span class="str">&quot;Before Swap: A is '{0}', B is '{1}'&quot;</span>, A, B);
    
    Swap(<span class="kwrd"><strong>ref</strong></span> A, <span class="kwrd"><strong>ref</strong></span> B);
    
    Console.WriteLine(<span class="str">&quot;After Swap:  A is '{0}', B is '{1}'&quot;</span>, A, B);
}

<span class="kwrd">void</span> Swap(<span class="kwrd"><strong>ref</strong></span> <span class="kwrd">string</span> a, <span class="kwrd"><strong>ref</strong></span> <span class="kwrd">string</span> b){
    <span class="kwrd">string</span> tmp = a;
    a = b;
    b = a;
}</pre>
</blockquote>

<p>Output:</p>

<blockquote>
  <p>Before Swap: A is 'aaa', B is 'bbb' 
    <br />After Swap:&#160; A is 'bbb', B is 'bbb'</p>
</blockquote>

<p>The only difference is the “ref” keyword added to the method and its call. C# does a great thing for us by making this very explicit (probably because it’s rarely what you actually want).</p>

<p>So back to the original question. “.Clear()” or “new” for a List&lt;T&gt;? As I’ve shown, once the style issue is resolved, it’s merely a matter of correctness. Suppose you had a method for refreshing a list. Which of these is best?:</p>

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

<p>Hopefully it’s starting to sink in at this point that the first one—RefreshNew—doesn’t actually work. Here’s what happens:</p>

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

<p>And the output:</p>

<blockquote>
  <p>Before Refresh: abc 
    <br />After Refresh New:&#160;&#160; abc 

    <br />After Refresh Clear: 123</p>
</blockquote>

<p>Again we see that repointing references that were <strong>passed by value</strong> does not have the desired effect. We could update the first implementation to pass its list as a ref parameter but I discourage that. I like the .Clear approach instead. The reason .Clear/.Add works is that you are working with the right object by the time you start manipulating it. You could also sidestep the whole problem by changing the method name to “Rebuild” and have it <em>return </em>a new list.</p>

<p>If that’s just crazy and not making any sense to you, I suggest checking out some of the <a href="http://www.google.com/images?q=variable%20passing%20reference">textbook diagrams</a> that explain this, or read this <a href="http://www.yoda.arachsys.com/csharp/parameters.html">excellent post</a> by Jon Skeet on the same topic. Both do a far better job at this than me.</p>

<p>This is a topic that was incorrectly taught (or understood) to me in college, so don’t be surprised if you learn something new as I did.</p>

<hr />

<p>There’s that tiny issue of Capacity that I hinted at before. Internally Lists are stored as arrays or whatever—it doesn’t really matter. For performance reasons, since arrays are immutable, they are allocated larger than necessary. This way, you can add elements to them without reallocating the entire thing. The system makes a trade off in avoiding allocating too much by doubling the size of the allocation every time it runs out of space. I suspect that clearing a list does not affect its capacity. Let’s see:</p>

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

<p>And the output:</p>

<blockquote>
  <p>Building list... 
    <br />List count: 1, list capacity: 4 

    <br />List count: 2, list capacity: 4 

    <br />List count: 3, list capacity: 4 

    <br />List count: 4, list capacity: 4 

    <br />List count: 5, list capacity: 8 

    <br />List count: 6, list capacity: 8 

    <br />List count: 7, list capacity: 8 

    <br />List count: 8, list capacity: 8 

    <br />List count: 9, list capacity: 16</p>

  <p>Clearing list... 
    <br />List count: 0, list capacity: 16</p>
</blockquote>

<p>So it’s as expected: clearing the list does not affect the list’s capacity. This implies that if you are creating a new list which is expected to significantly differ in size, than “Clear()” might not be the way to go. It’s probably a micro-optimization, but I’d say the doubling nature of lists is probably something worth knowing.</p>

---

## 2 comments captured from [original post](https://blog.wassupy.com/2010/10/list-clear-vs-new-variable-passing-in-c.html) on Blogger

**Xander Dumaine said on 2010-11-09**

void Swap(ref string a, ref string b){<br />    string tmp = a;<br />    a = b;<br />    b = a;<br />}

I believe should be..

void Swap(ref string a, ref string b){<br />    string tmp = a;<br />    a = b;<br />    b = tmp;<br />}

**Michael Haren said on 2010-11-09**

Yes, thank you! (fixed)

