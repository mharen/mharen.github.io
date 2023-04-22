---
date: '2009-08-23T00:48:00.001-04:00'
description: ''
published: true
slug: 2009-08-building-windows-sidebar-gadget
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Windows
- Usability
- Technology
- legacy-blogger
time_to_read: 5
title: Building a Windows Sidebar Gadget
---

<p>I use Hudson CI to monitor software builds at work and thought it’d be nice to provide visibility of Hudson’s data through a sidebar gadget. Unfortunately, one didn’t exist so I took it upon myself to make one. It turned out to be very, very easy.</p>
<p>Here’s the end result:</p>
<p>![SNAG-0013%5B6%5D.png](SNAG-0013%5B6%5D.png) </p>
<p>The gadget is on the right side, the regular Hudson interface on the left. The top 11 projects are listed as links to their project pages within Hudson. The colored bullets indicate build status (green = good, red = bad). I experimented with shading, text color, etc. and concluded that just having colored bullets was clear, clean and consistent with the regular Hudson interface.</p>
<p>![image%5B9%5D.png](image%5B9%5D.png)Anyway, the easiest way to get started with Gadget development seems to be starting with an existing gadget. I started with the unofficial Stackoverflow.com <a href="http://flairgadget.codeplex.com/">flair gadget</a>. A .gadget file is really just a zip file. 7zip seems to know this as it allowed me to unzip it without renaming it to .zip which was nice. After unzipping, I stripped out pretty much everything except the structure. </p>
<p>The gadget is remarkably simple—it’s just two web pages, main.html and settings.html. All the other files are just there for support: a few images, jquery (my favorite JS library), and json2 (brings JSON support to IE which is curiously missing on my Windows 7 machine). Obviously main.js/.css/.html go together as do settings.js/.css/.html.</p>
<p>Here’s what the main page looks like:</p>
<blockquote>   <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">html</span> <span class="attr">xmlns</span><span class="kwrd">=&quot;http://www.w3.org/1999/xhtml&quot;</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">head</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">title</span><span class="kwrd">&gt;</span>Hudson Monitor<span class="kwrd">&lt;/</span><span class="html">title</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">link</span> <span class="attr">rel</span><span class="kwrd">=&quot;stylesheet&quot;</span> <span class="attr">href</span><span class="kwrd">=&quot;styles/main.css&quot;</span> <span class="kwrd">/&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">script</span> <span class="attr">type</span><span class="kwrd">=&quot;text/javascript&quot;</span> <span class="attr">src</span><span class="kwrd">=&quot;scripts/jquery-1.3.2.min.js&quot;</span><span class="kwrd">&gt;&lt;/</span><span class="html">script</span><span class="kwrd">&gt;</span>
  &lt;script type=<span class="str">&quot;text/javascript&quot;</span> src=<span class="str">&quot;scripts/main.js&quot;</span>&gt;&lt;/script&gt;
  &lt;script type=<span class="str">&quot;text/javascript&quot;</span>&gt;
    $().ready(<span class="kwrd">function</span>() {
      FillMain();
    });
  <span class="kwrd">&lt;/</span><span class="html">script</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">head</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">body</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">g:background</span> <span class="attr">src</span><span class="kwrd">=&quot;images/bg.png&quot;</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">ul</span> <span class="attr">id</span><span class="kwrd">=&quot;jobs&quot;</span><span class="kwrd">&gt;&lt;/</span><span class="html">ul</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">g:background</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">body</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">html</span><span class="kwrd">&gt;</span></pre>
</blockquote>

<p>The HTML really boils down to a single element: &lt;ul&gt;. The real magic happens within main.js. Here’s the relevant section:</p>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">function</span> FillMain() {
    <span class="rem">// Get the url from the saved settings</span>
    <span class="kwrd">var</span> url = System.Gadget.Settings.readString(<span class="str">&quot;hudsonUrl&quot;</span>);

    <span class="kwrd">if</span> (url == <span class="kwrd">null</span> || url.length == 0) {
        $(<span class="str">&quot;#jobs&quot;</span>).append(<span class="str">&quot;&lt;li class='status-red'&gt; \
            Whoa there! Check your options, pal&lt;/li&gt;&quot;</span>);
        <span class="kwrd">return</span>;
    }

    $.getJSON(url+<span class="str">&quot;/api/json/?jsonp=?&quot;</span>, FillMainCallback);

    <span class="rem">// Repeat every 20 minutes</span>
    setTimeout(<span class="str">&quot;FillMain()&quot;</span>, 20 * 60 * 1000);
}

<span class="kwrd">function</span> FillMainCallback(data) {
    $(<span class="str">&quot;#jobs&quot;</span>).empty(); 

    <span class="rem">// space is limited</span>
    <span class="kwrd">var</span> items = data.jobs.slice(0, 11);
    
    <span class="rem">// add each item to the list</span>
    $.each(items, <span class="kwrd">function</span>(i, item) {
        <span class="kwrd">var</span> itemName = item.name; 
        <span class="kwrd">var</span> itemClass = <span class="str">'status-'</span> + item.color;
        <span class="kwrd">var</span> itemUrl = item.url;

        $(<span class="str">&quot;#jobs&quot;</span>).append(<span class="str">&quot;&lt;li class='&quot;</span> + itemClass + <span class="str">&quot;'&gt;&lt;a href='&quot;</span> 
            + itemUrl + <span class="str">&quot;'&gt;&quot;</span> + itemName + <span class="str">&quot;&lt;/a&gt;&lt;/li&gt;&quot;</span>);
    });
}</pre>
</blockquote>

<p>I won’t talk about that too much except to say jQuery makes all of this so much easier:</p>

<ul>
  <li>$.getJSON(): contacts the Hudson build server and retrieves a terse list of build statuses. Hudson provides a straightforward, albeit limited API at http://hudson-url/api. </li>

  <li>$.each(): iterates over each Hudson project returned by the server; for each one, adds it to the list (#jobs) as a new list item </li>
</ul>

<p>With the data flowing nicely, all that was needed was a little light graphics work and some CSS and I called it a day. I borrows the pretty background image with the curvy, aero border from the Outlook gadget but replaced the Outlook icon with a Hudson logo.</p>

<p>This is a feature-poor gadget, I admit. I plan to add the ability to order the projects by other criteria (e.g. last-activity-date) and the ability to pick which projects are listed. I might try out some other UI designs, too. What I have is functional and clean but leaves a bit to be desired.</p>

---

## 4 comments captured from [original post](https://blog.wassupy.com/2009/08/building-windows-sidebar-gadget.html) on Blogger

**GBtG said on 2009-08-23**

Does jQuery offer a syntax that doesn't involve building markup in strings?

BTW: &quot;20 * 60 * 1000&quot; is brilliant, and my new way of coding durations.

**Michael Haren said on 2009-08-23**

Yes, you can create elements with plain vanilla JS using document.createElement()(http://stackoverflow.com/questions/327047/).

I find the jquery markup method easier as it often leads to less code. Though the native function is faster, I cannot imagine a scenario in which that would matter.

**portella said on 2010-10-06**

Hi, you don't want to provide your gadget? I use Hudson and will be helpfull ... for sure I can redo your work with your usefull tips ... 

[]'s, Portella

**Amani Phoenix said on 2014-05-21**

nice post

