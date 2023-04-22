---
date: '2011-11-21T13:51:00.001-05:00'
description: ''
published: true
slug: 2011-11-im-personally-fan-of-respecting-case
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- NaBloPoMo 2011
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Case Sensitivity in ASP.NET
---

<p>I’m personally a fan of respecting case sensitivity. Historically it seems that most programming languages are picky about “a” vs. “A”, and even most operating systems. VB, and Windows, however, are not.</p>  <p>This leads to some frustratingly elusive bugs on occasion because there <em>are </em>instances in VB where case does matter. Take for instance the following objects, commonly available while processing an ASP.NET request:</p>  <ul>   <li>Request</li>    <li>Session</li>    <li>Cookies</li>    <li>Viewstate</li> </ul>  <p>The first three (among others) are implemented with a hash table that does case-insensitive lookups. (There’s an <a href="http://stackoverflow.com/q/1731283/29/#1731535">awesome answer</a> over on Stackoverflow that explains why it works this way).</p>  <p>So after playing fast and loose with case sensitivity, it’s easy to treat the viewstate object the same way. But, as you’ve surely guessed by now, lookups in the viewstate bag are <em>case-sensitive</em>. </p>  <p>Unfortunately, I can’t find a reference that documents this at the moment, but I can confirm it works that way from personal experience. Here’s one of my recent commits:</p>  <p><a href="http://lh3.ggpht.com/-Og4JcYjreqg/TsqduOusbBI/AAAAAAAAEIk/ZnKRtSICYT0/s1600-h/image%25255B2%25255D.png"><img alt="image" height="32" src="http://lh5.ggpht.com/-ltiQNxGE02k/TsqduT5hyZI/AAAAAAAAEIs/O0_Uw2Yq0hw/image_thumb.png?imgmax=800" style="display: block; float: none; margin-left: auto; margin-right: auto;" title="image" width="356" /></a><img alt="image" height="31" src="http://lh4.ggpht.com/-hcIDsDzo2mc/Tsqdu4JSLcI/AAAAAAAAEIw/TiUUQJTrtLg/image_thumb%25255B1%25255D.png?imgmax=800" style="display: block; float: none; margin-left: auto; margin-right: auto;" title="image" width="452" /> </p>  <p>And a flood of Google results from others affected confirms it’s not a fluke affecting just me.</p>  <p></p>  <p></p>  <p>Happy debugging! </p>