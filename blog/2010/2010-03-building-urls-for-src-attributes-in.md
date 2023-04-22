---
date: '2010-03-10T12:01:00.001-05:00'
description: ''
published: true
slug: 2010-03-building-urls-for-src-attributes-in
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Technology
- legacy-blogger
time_to_read: 5
title: "Building URLs for \u201CSRC\u201D Attributes in ASP.NET MVC"
---

<p>I’ve been told that these programming posts are not interesting or funny. For those that have no interest in programming, I offer the following jokes: </p>
<blockquote> 
<p>“Chuck Norris can divide by zero” </p>  
<p>“Chuck Norris can touch MC Hammer”</p>  
<p>“Chuck Norris CAN believe it's not butter.”</p>
</blockquote>
<p>–<a href="http://www.chucknorrisfacts.com/chuck-norris-top-50-facts">Chuck Norris Facts</a> </p>
<p>Now would be a good time for you to stop reading. </p>
<p>   <hr /></p>
<p>Dive into ASP.NET MVC and it won’t be long before you do this in a master page:</p>  <pre class="csharpcode">    <span class="kwrd">&lt;</span><span class="html">link</span> <span class="attr">type</span><span class="kwrd">=&quot;text/css&quot;</span> <span class="attr">rel</span><span class="kwrd">=&quot;Stylesheet&quot;</span> <span class="attr">href</span><span class="kwrd">=&quot;~/Content/all-src.min.css&quot;</span> <span class="kwrd">/&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">script</span> <span class="attr">type</span><span class="kwrd">=&quot;text/javascript&quot;</span> <span class="attr">src</span><span class="kwrd">=&quot;~/Scripts/all-src.min.js&quot;</span><span class="kwrd">&gt;&lt;/</span><span class="html">script</span><span class="kwrd">&gt;</span></pre>

<p>This of course includes a couple global files—one for styles and one for scripts. Here’s the rub: it doesn’t work at all. It’ll seem like it works at first, because you’ll have nice styles and some of your scripts might even work, but it will be a short-lived experience.</p>

<p>Unfortunately something funny is going on here. Those URLs are not valid—they’re more than relative (relative URLs are fine), they’re relative from an application root, denoted by the tilde (<code>~</code>). That tilde means nothing to the browser. </p>

<p>Now the funny business is that ASP.NET will rewrite the link tag <em>automatically</em> to include the correct relative URL by replacing the “<code>~</code>” with the appropriate path. It <em>does not </em>do that with script tags. So you try to be clever and use a web-friendly relative URL syntax like this:</p>

<pre class="csharpcode">    <span class="kwrd">&lt;</span><span class="html">script</span> <span class="attr">type</span><span class="kwrd">=&quot;text/javascript&quot;</span> <span class="attr">src</span><span class="kwrd">=&quot;../../Scripts/all-src.min.js&quot;</span><span class="kwrd">&gt;&lt;/</span><span class="html">script</span><span class="kwrd">&gt;</span></pre>

<p>Sorry, that doesn’t cut it. The “<code>../../</code>” will only work properly if the content page (which uses the master page) is nested 2-levels deep, which is not likely to be true very often.</p>

<p>The trick is to call into <code>Url.Content</code> or <code>Url.Content</code> like so:</p>

<pre class="csharpcode">    <span class="kwrd">&lt;</span><span class="html">script</span> <span class="attr">type</span><span class="kwrd">=&quot;text/javascript&quot;</span> <span class="attr">src</span><span class="kwrd">=&quot;&lt;%=<strong>Url.Content</strong>(&quot;</span>~/<span class="attr">Scripts</span>/<span class="attr">all-src</span>.<span class="attr">min</span>.<span class="attr">js</span><span class="kwrd">&quot;)%&gt;&quot;</span><span class="kwrd">&gt;&lt;/</span><span class="html">script</span><span class="kwrd">&gt;</span></pre>

<p>This extra step will give me a nice URL, regardless of the page’s depth in my tree. So what’s the difference between <a href="http://aspnet.codeplex.com/sourcecontrol/network/Show?projectName=aspnet&amp;changeSetId=23011#266520"><code>Url.Content</code></a> and <a href="http://msdn.microsoft.com/en-us/library/system.web.ui.control.resolveurl.aspx"><code>Url.Content</code></a>? <code>ResolveUrl</code> has been around <em>forever</em> as part of <code>Url.Content</code>. On the other hand, <code>Url.Content</code> is relatively new and ships as part of <code>Url.Content</code>. Aside from that, I have no idea—if you do, <a href="http://stackoverflow.com/questions/2418050">please share</a>.</p>

<p>Note: these commands work pretty much everywhere—<code>imgs</code>, <code>Url.Content</code>, etc.</p>