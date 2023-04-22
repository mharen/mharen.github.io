---
date: '2009-07-02T10:35:00.001-04:00'
description: ''
published: true
slug: 2009-07-are-you-crashing-responsibly
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Usability
- Technology
- legacy-blogger
time_to_read: 5
title: Are you Crashing Responsibly?
---

<p>Software crashes are inevitable. We software creators try and try to anticipate problems but we just can’t predict everything that could happen—nor should we. </p>
<blockquote> 
<p>Should I spend time worrying about how to handle bad input? Definitely. </p>  
<p>Network failure? Absolutely.</p>  
<p>Power outage? Probably. </p>  
<p>Disk error? Maybe.</p>  
<p>Ancient browsers? <a href="http://mharen.blogspot.com/2009/06/troubleshooting-elusive-site-slow-down.html">Maybe</a>.</p>  
<p>CPU error? CPU what?</p>  
<p>User-modified executable? Oh hell no.</p>  
<p>Virus infestation? Game over.</p>
</blockquote>
<p>The fact is, with finite time and resources we do the best we can to provide a good user experience to as many users as we can. The idea of <a href="http://www.codinghorror.com/blog/archives/001118.html">crashing responsibly</a>, though, is to toss in some grace when the unexpected occurs. Check out that post for a lot of really great tips. I’ll just repeat a couple ideas briefly here.</p>
<p>First, blame yourself, not the user. It’s usually not their fault something went wrong. I love the <a href="http://stackoverflow.com/">stackoverflow</a> error message (only once encountered):</p>
<p>&#160;![gooderrorpage7.png](gooderrorpage7.png) </p>
<p>Obviously <a href="http://icanhascheezburger.com/">Lolcats</a> won’t work in some professional environments but the message certainly would: <strong>This is our fault and we’re on it.</strong> Here’s a less adorable mockup I made recently for a corporate project (thanks to <a href="http://www.balsamiq.com/products/mockups/examples">Balsamiq mockups</a>, a sweet mockup maker):</p>  <p align="center">![ErrorPageMockup.png](ErrorPageMockup.png) </p>
<p>It’s clear and simple and better than what this program does today (hint: nothing!). It could still be improved, though. For example, I still think it’s a little busy. I could that by moving the “Your info” box after the “Please follow up with me” checkbox so that it’s only displayed/completed if the user actually wants a follow up. I could also make it more clear that they don’t have to submit this at all—we capture the automatic stuff before this page is even displayed.</p>
<p>Secondly (perhaps obvious): make sure your error handler actually handles all your errors! It’s no good otherwise. The best way to get on this path is to make sure existing bugs are handled well <strong>before</strong> you fix them. After you fix the bug, you can’t tell if the error handler is working (and it <em>will </em>be needed again).</p>
<p>You can be proactive, too and fail intentionally to see how your app handles it. For example, in each layer of your n-tiered app, you can toss in random exceptions. Add a 1/0 here, a SQL error in a stored procedure there, and some null references over all and see what happens. If this causes your app to burst into flames (e.g. majorly screw up the database because you’re not using transactions, etc.), you now have some important things to fix and an easy to reproduce problem you can use to verify your fixes.</p>
<p>I’m using live writer to write this and I must say I’m continuous impressed with it. Here’s the latest reason: it almost-crashes often, but handles these crashes very well. The entire app has never crashed on me and I’ve yet to lose any work—here’s what I mean: the app occasionally pops up the dreaded error window when I do certain things (usually with plugins):</p>  <p align="center">![error%5B4%5D.gif](error%5B4%5D.gif)(similar error) </p>
<p>Much to my surprise, after I clicked “Send Error Report” I was left looking at my document. WLW managed to catch the error before it could affect other parts of the program. Nice!</p>
<p>Crashing is inevitable (it’s the strongest invariant your code has), accept it and handle it.</p>