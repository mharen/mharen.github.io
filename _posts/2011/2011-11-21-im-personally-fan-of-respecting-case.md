---
layout: post
date: '2011-11-21T13:51:00.001-05:00'
categories:
- work
- nablopomo 2011
- code
- technology
title: Case Sensitivity in ASP.NET
---


I’m personally a fan of respecting case sensitivity. Historically it seems that most programming languages are picky about “a” vs. “A”, and even most operating systems. VB, and Windows, however, are not.

This leads to some frustratingly elusive bugs on occasion because there *are *instances in VB where case does matter. Take for instance the following objects, commonly available while processing an ASP.NET request:  <ul>   <li>Request</li>    <li>Session</li>    <li>Cookies</li>    <li>Viewstate</li> </ul>

The first three (among others) are implemented with a hash table that does case-insensitive lookups. (There’s an [awesome answer](http://stackoverflow.com/q/1731283/29/#1731535) over on Stackoverflow that explains why it works this way).

So after playing fast and loose with case sensitivity, it’s easy to treat the viewstate object the same way. But, as you’ve surely guessed by now, lookups in the viewstate bag are *case-sensitive*. 

Unfortunately, I can’t find a reference that documents this at the moment, but I can confirm it works that way from personal experience. Here’s one of my recent commits:

![image%5B2%5D.png](/assets/2011/image%5B2%5D.png)</a>![image_thumb%5B1%5D.png](/assets/2011/image_thumb%5B1%5D.png) 

And a flood of Google results from others affected confirms it’s not a fluke affecting just me.





Happy debugging! 