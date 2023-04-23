---
layout: post
date: '2011-03-10T16:40:00.001-05:00'
categories:
- code
- technology
title: The Curious Behavior of HTML Image Inputs, Or Why "&x=0&y=0" Is Showing Up
  Uninvited
---


While working on an internal tool I noticed that the search form was producing unexpected <code>get</code> requests. Here’s the form:
<blockquote>   <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">form</span> <span class="attr">action</span><span class="kwrd">=&quot;/Search&quot;</span> <span class="attr">method</span><span class="kwrd">=&quot;get&quot;</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">input</span> <span class="attr">id</span><span class="kwrd">=&quot;s&quot;</span> <span class="attr">name</span><span class="kwrd">=&quot;s&quot;</span> <span class="attr">type</span><span class="kwrd">=&quot;text&quot;</span> <span class="attr">value</span><span class="kwrd">=&quot;&quot;</span> <span class="kwrd">/&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">input</span> <span class="attr">type</span><span class="kwrd">=&quot;image&quot;</span> <span class="attr">src</span><span class="kwrd">=&quot;search.png&quot;</span> <span class="attr">value</span><span class="kwrd">=&quot;Search&quot;</span> <span class="kwrd">/&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">form</span><span class="kwrd">&gt;</span></pre>
</blockquote>


I expected this to create requests like 

<blockquote>
  <pre class="csharpcode">/Search?s=blah</pre>
</blockquote>


but instead I got this:

<blockquote>
  <pre class="csharpcode">/Search?s=blah&amp;x=0&amp;y=0</pre>
</blockquote>


Hmm. Initially I thought this was some sort of ASP.NET trick to [remember scroll position](http://weblogs.asp.net/hosamkamel/archive/2007/09/07/maintain-scroll-position-after-postbacks-in-asp-net-2-0.aspx). But I’m using MVC, which has a lot less unexpected magic in it so I quickly concluded it must be something else. I thought about those image maps that used to be all the rage back in 1999 and determined that my [image input](http://www.whatwg.org/specs/web-apps/current-work/multipage/number-state.html#concept-input-type-image-coordinate) was causing the problem.


This was easily confirmed by actually clicking on the magnifying glass on my page and seeing requests like this:

<blockquote>
  <pre class="csharpcode">/Search?s=blah&amp;x=**<font color="#ff0000">5</font>**&amp;y=**<font color="#ff0000">3</font>**</pre>
</blockquote>


Ah, so yes, it is recording where I click. While I’m sure that’s really great in some situations, it’s not what I want now. Interestingly, the solution to this problem wasn’t so simple. The cleanest workaround seems to be disabling the image input when the form is submitted. Since the browser won’t send the value of disabled inputs upon submission this solves the problem.


Here’s a tiny line of jQuery which solved the problem for me:

<blockquote>
  <pre class="csharpcode"><span class="rem">// disable the image submit buttons so the browser doesn't add &amp;x=&amp;y= to the qs</span>
$(<span class="str">'form.strip-img-inputs-on-submit'</span>).submit(<span class="kwrd">function</span> (e) {
    $(<span class="kwrd">this</span>).find(<span class="str">'input[type=image]'</span>).attr(<span class="str">'disabled'</span>, <span class="kwrd">true</span>);
});</pre>
</blockquote>


Essentially all this does is find all forms with a certain class and disable image inputs when submitted.