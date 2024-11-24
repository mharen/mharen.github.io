---
layout: post
date: '2009-07-02T10:35:00.001-04:00'
categories:
- work
- usability
- technology
title: Are you Crashing Responsibly?
---

Software crashes are inevitable. We software creators try and try to anticipate problems but we just can’t predict everything that could happen—nor should we. 

> Should I spend time worrying about how to handle bad input? Definitely.   
> 
> Network failure? Absolutely.  
> 
> Power outage? Probably.   
> 
> Disk error? Maybe.  
> 
> Ancient browsers? [Maybe](../../2009/06/troubleshooting-elusive-site-slow-down.html).  
> 
> CPU error? CPU what?  
> 
> User-modified executable? Oh hell no.  
> 
> Virus infestation? Game over.

The fact is, with finite time and resources we do the best we can to provide a good user experience to as many users as we can. The idea of [crashing responsibly](http://www.codinghorror.com/blog/archives/001118.html), though, is to toss in some grace when the unexpected occurs. Check out that post for a lot of really great tips. I’ll just repeat a couple ideas briefly here.

First, blame yourself, not the user. It’s usually not their fault something went wrong. I love the [stackoverflow](http://stackoverflow.com/) error message (only once encountered):

{% imagesize /assets/2009/gooderrorpage7.png:img %}

Obviously [Lolcats](http://icanhascheezburger.com/) won’t work in some professional environments but the message certainly would: **This is our fault and we’re on it.** Here’s a less adorable mockup I made recently for a corporate project (thanks to [Balsamiq mockups](http://www.balsamiq.com/products/mockups/examples), a sweet mockup maker):  

{% imagesize /assets/2009/ErrorPageMockup.png:img %}

It’s clear and simple and better than what this program does today (hint: nothing!). It could still be improved, though. For example, I still think it’s a little busy. I could that by moving the “Your info” box after the “Please follow up with me” checkbox so that it’s only displayed/completed if the user actually wants a follow up. I could also make it more clear that they don’t have to submit this at all—we capture the automatic stuff before this page is even displayed.

Secondly (perhaps obvious): make sure your error handler actually handles all your errors! It’s no good otherwise. The best way to get on this path is to make sure existing bugs are handled well **before** you fix them. After you fix the bug, you can’t tell if the error handler is working (and it *will* be needed again).

You can be proactive, too and fail intentionally to see how your app handles it. For example, in each layer of your n-tiered app, you can toss in random exceptions. Add a 1/0 here, a SQL error in a stored procedure there, and some null references over all and see what happens. If this causes your app to burst into flames (e.g. majorly screw up the database because you’re not using transactions, etc.), you now have some important things to fix and an easy to reproduce problem you can use to verify your fixes.

I’m using live writer to write this and I must say I’m continuous impressed with it. Here’s the latest reason: it almost-crashes often, but handles these crashes very well. The entire app has never crashed on me and I’ve yet to lose any work—here’s what I mean: the app occasionally pops up the dreaded error window when I do certain things (usually with plugins):  

{% imagesize /assets/2009/error-4.gif:img %} <br/> (similar error) 

Much to my surprise, after I clicked “Send Error Report” I was left looking at my document. WLW managed to catch the error before it could affect other parts of the program. Nice!

Crashing is inevitable (it’s the strongest invariant your code has), accept it and handle it.