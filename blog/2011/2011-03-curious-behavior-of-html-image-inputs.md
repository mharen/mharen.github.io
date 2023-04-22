---
date: '2011-03-10T16:40:00.001-05:00'
description: ''
published: true
slug: 2011-03-curious-behavior-of-html-image-inputs
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: The Curious Behavior of HTML Image Inputs, Or Why "&x=0&y=0" Is Showing Up
  Uninvited
---

<p>While working on an internal tool I noticed that the search form was producing unexpected <code>get</code> requests. Here’s the form:</p>  <blockquote>   <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">form</span> <span class="attr">action</span><span class="kwrd">=&quot;/Search&quot;</span> <span class="attr">method</span><span class="kwrd">=&quot;get&quot;</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">input</span> <span class="attr">id</span><span class="kwrd">=&quot;s&quot;</span> <span class="attr">name</span><span class="kwrd">=&quot;s&quot;</span> <span class="attr">type</span><span class="kwrd">=&quot;text&quot;</span> <span class="attr">value</span><span class="kwrd">=&quot;&quot;</span> <span class="kwrd">/&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">input</span> <span class="attr">type</span><span class="kwrd">=&quot;image&quot;</span> <span class="attr">src</span><span class="kwrd">=&quot;search.png&quot;</span> <span class="attr">value</span><span class="kwrd">=&quot;Search&quot;</span> <span class="kwrd">/&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">form</span><span class="kwrd">&gt;</span></pre>
</blockquote>

<p>I expected this to create requests like </p>

<blockquote>
  <pre class="csharpcode">/Search?s=blah</pre>
</blockquote>

<p>but instead I got this:</p>

<blockquote>
  <pre class="csharpcode">/Search?s=blah&amp;x=0&amp;y=0</pre>
</blockquote>

<p>Hmm. Initially I thought this was some sort of ASP.NET trick to <a href="http://weblogs.asp.net/hosamkamel/archive/2007/09/07/maintain-scroll-position-after-postbacks-in-asp-net-2-0.aspx">remember scroll position</a>. But I’m using MVC, which has a lot less unexpected magic in it so I quickly concluded it must be something else. I thought about those image maps that used to be all the rage back in 1999 and determined that my <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/number-state.html#concept-input-type-image-coordinate">image input</a> was causing the problem.</p>

<p>This was easily confirmed by actually clicking on the magnifying glass on my page and seeing requests like this:</p>

<blockquote>
  <pre class="csharpcode">/Search?s=blah&amp;x=<strong><font color="#ff0000">5</font></strong>&amp;y=<strong><font color="#ff0000">3</font></strong></pre>
</blockquote>

<p>Ah, so yes, it is recording where I click. While I’m sure that’s really great in some situations, it’s not what I want now. Interestingly, the solution to this problem wasn’t so simple. The cleanest workaround seems to be disabling the image input when the form is submitted. Since the browser won’t send the value of disabled inputs upon submission this solves the problem.</p>

<p>Here’s a tiny line of jQuery which solved the problem for me:</p>

<blockquote>
  <pre class="csharpcode"><span class="rem">// disable the image submit buttons so the browser doesn't add &amp;x=&amp;y= to the qs</span>
$(<span class="str">'form.strip-img-inputs-on-submit'</span>).submit(<span class="kwrd">function</span> (e) {
    $(<span class="kwrd">this</span>).find(<span class="str">'input[type=image]'</span>).attr(<span class="str">'disabled'</span>, <span class="kwrd">true</span>);
});</pre>
</blockquote>

<p>Essentially all this does is find all forms with a certain class and disable image inputs when submitted.</p>