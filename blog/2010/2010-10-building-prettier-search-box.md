---
date: '2010-10-22T23:50:00.001-04:00'
description: ''
published: true
slug: 2010-10-building-prettier-search-box
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Usability
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Building a Prettier Search Box
---

<p style="border-bottom: #000 1px solid; border-left: #000 1px solid; padding-bottom: 5px; background-color: #ccc; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #000 1px solid; border-right: #000 1px solid; padding-top: 5px;">Note: if you’re reading this off-site (feed reader, facebook, etc.) and it looks funny, click through for a better view.</p>
<p>Let's take a quick look at a typical search box:</p>
<blockquote> 
<p><input /><input type="submit" /></p>
</blockquote>
<p>It's boring, plain, and takes up a lot of space. But, the code is about as simple as it gets:</p>
<blockquote>   <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">input</span> <span class="kwrd">/&gt;<br />&lt;</span><span class="html">input</span> <span class="attr">type</span><span class="kwrd">=&quot;submit&quot;</span> <span class="kwrd">/&gt;<br /></span></pre>
</blockquote>

<p>We can improve things a great deal by adding a shiny graphic:</p>

<blockquote>

<p><input /><input src="http://lh4.ggpht.com/_IKD9WtY5kxU/TMJXvFRpXzI/AAAAAAAABG4/DU79z1bP4WU/search.gif" type="image" /></p>
</blockquote>

<p>That's most easily accomplished by changing the input type from &quot;submit&quot; to &quot;image&quot; like so (this could be accomplished in CSS with a bit <a href="http://stackoverflow.com/q/195632/29">more effort</a>): </p>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">input</span> <span class="kwrd">/&gt;<br />&lt;</span><span class="html">input</span> <span class="attr">src</span><span class="kwrd">=&quot;search.gif&quot;</span> <span class="attr">type</span><span class="kwrd">=&quot;image&quot;</span> <span class="kwrd">/&gt;</span></pre>
</blockquote>

<p>Now we're talking. Let's go a little further:</p>

<blockquote>

<p><input class="post-example-input" /><input class="post-example-go" src="http://www.bing.com/siteowner/s/siteowner/Spyglass_16x16.gif" type="image" /></p>
</blockquote>

<p>Here we've overlaid the image with the box for a very clean effect. This uses the same HTML (I just added classes) but adds just a teenie bit of CSS:</p>

<blockquote>
  <pre class="csharpcode"><span class="rem">/* overlay search button on the actual box */</span>
input.search-button { position:relative; left: -20px; top:1px } 

<span class="rem">/* pad out the input so a user's search won't go under the search button */</span>
input.search-box { padding-right:20px; }</pre>
</blockquote>

<p>Clean and simple. </p>

<p>It has one minor drawback in that it doesn't support CSS sprites. If you want that, you'll need to use one of the <code>background-image</code> tricks at the <a href="http://stackoverflow.com/q/195632/29">link</a> I mentioned earlier.</p>

<p>Of course once Google's Instant Search sweeps the web this will all be a cow's opinion: moo.</p>