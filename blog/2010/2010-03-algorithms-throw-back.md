---
date: '2010-03-04T14:23:00.001-05:00'
description: ''
published: true
slug: 2010-03-algorithms-throw-back
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Technology
- legacy-blogger
time_to_read: 5
title: Algorithms Throw Back
---


I was given a question today that really took me back. Here’s a hint: it had to do with [binary search trees](http://en.wikipedia.org/wiki/Binary_search_tree), data structures, and pretty printing.

I haven’t touched a BST in six years so it took some priming to get me going.  

![image%5B2%5D.png](image%5B2%5D.png)([BST builder](http://people.ksp.sk/~kuko/bak/index.html))

The task was to print this tree level by level. So the output should be 3, 1, 6, 2, 5, 7, 4. If you’re a programmer, I encourage you to solve this problem as an exercise before looking at my solution. It was humbling for me.

After wasting a half hour messing around with recursion, I was given a pretty nice hint to do it iteratively with a queue. 

I still failed miserably with my good old paper and pencil, but afterwards set out to do it in a more comfortable environment (C#).

Here’s my basic node class (structs are for sissys):  <pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">class</span> Node
    {
        <span class="kwrd">public</span> Node(<span class="kwrd">int</span> <span class="kwrd">value</span>, Node left = <span class="kwrd">null</span>, Node right = <span class="kwrd">null</span>)
        {
            Value = <span class="kwrd">value</span>; Left = left; Right = right;
        }
        <span class="kwrd">public</span> <span class="kwrd">int</span> Value { get; set; }
        <span class="kwrd">public</span> Node Left { get; set; }
        <span class="kwrd">public</span> Node Right { get; set; }
    }</pre>


And my main program:

<pre class="csharpcode">    <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
    {
        Node n = <span class="kwrd">new</span> Node(3);
        n.Left = <span class="kwrd">new</span> Node(1, <span class="kwrd">null</span>, <span class="kwrd">new</span> Node(2));
        n.Right = <span class="kwrd">new</span> Node(6, <span class="kwrd">new</span> Node(5, <span class="kwrd">new</span> Node(4)), <span class="kwrd">new</span> Node(7));

        PrettyPrintByLevel(n);
        Console.ReadKey();
    }</pre>


And the magic:

<pre class="csharpcode">    <span class="kwrd">static</span> <span class="kwrd">void</span> PrettyPrintByLevel(Node n)
    {
        Queue&lt;Node&gt; Nodes = <span class="kwrd">new</span> Queue&lt;Node&gt;();
        Nodes.Enqueue(n);

        <span class="kwrd">do</span>
        {
            Node QNode = Nodes.Dequeue();
            Console.WriteLine(QNode.Value);

            <span class="kwrd">if</span> (QNode.Left != <span class="kwrd">null</span>) Nodes.Enqueue(QNode.Left);
            <span class="kwrd">if</span> (QNode.Right != <span class="kwrd">null</span>) Nodes.Enqueue(QNode.Right);

        } <span class="kwrd">while</span> (Nodes.Count &gt; 0);
    }</pre>


A quick test reveals that it works:

<blockquote>
  <pre class="csharpcode">3 1 6 2 5 7 4</pre>
</blockquote>
Yay! So what did I learn today? I’m rusty on the basics and need to do some more [Project Euler problems](http://projecteuler.net/). 


I’ve taken this opportunity to brush up on some Java. Here’s the same app in the similar, but different Java:

<pre class="csharpcode">    <span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">void</span> main(String[] args) {
        <span class="rem">// build up a tree</span>
        Node n = <span class="kwrd">new</span> Node(3, <span class="kwrd">null</span>, <span class="kwrd">null</span>);
        n.Left = <span class="kwrd">new</span> Node(1, <span class="kwrd">null</span>, <span class="kwrd">new</span> Node(2, <span class="kwrd">null</span>, <span class="kwrd">null</span>));
        n.Right = <span class="kwrd">new</span> Node(6, <span class="kwrd">new</span> Node(5, <span class="kwrd">new</span> Node(4, <span class="kwrd">null</span>, <span class="kwrd">null</span>), <span class="kwrd">null</span>), <span class="kwrd">new</span> Node(7, <span class="kwrd">null</span>, <span class="kwrd">null</span>));

        <span class="rem">// print out the tree to the console</span>
        PrettyPrintByLevel(n);
    }

    <span class="kwrd">private</span> <span class="kwrd">static</span> <span class="kwrd">void</span> PrettyPrintByLevel(Node n) {
        Queue&lt;Node&gt; Nodes = <span class="kwrd">new</span> LinkedList&lt;Node&gt;();
        Nodes.add(n);

        <span class="kwrd">do</span>
        {
            Node QNode = Nodes.remove();
            System.<span class="kwrd">out</span>.println(QNode.Value);

            <span class="kwrd">if</span> (QNode.Left != <span class="kwrd">null</span>) Nodes.add(QNode.Left);
            <span class="kwrd">if</span> (QNode.Right != <span class="kwrd">null</span>) Nodes.add(QNode.Right);

        } <span class="kwrd">while</span> (Nodes.peek() != <span class="kwrd">null</span>);        
        <span class="rem">// process the queue until it's empty</span>
        <span class="rem">// peeking for a null element is certainly faster (or as fast) as</span>
        <span class="rem">// calling for the list's length over and over again</span>
    }</pre>


It’s pretty much the same thing.

---

## 2 comments captured from [original post](https://blog.wassupy.com/2010/03/algorithms-throw-back.html) on Blogger

**Michael Haren said on 2010-03-04**

(note: I skipped essential things like error checking, etc. e.g. this assumes that the root node n isn’t null)

**Michael Haren said on 2010-03-04**

This is better known as a Breadth First Search, btw 

http://en.wikipedia.org/wiki/Breadth-first_search

