---
layout: post
date: '2012-11-08T23:59:00.000-05:00'
categories:
- nablopomo 2012
- code
- signalr
- technology
title: "SignalR: First Impressions (It's Awesome)"
---

[SignalR](https://github.com/SignalR/SignalR#readme) is an:

> Async signaling library for .NET to help build real-time, multi-user interactive web applications.

It narrows the gap among clients, and between each client and the server. SignalR helps you do neat things like update dashboard information to anyone looking at your page (practically) instantly in a *very efficient* way.

Have you ever written a little refresh routine to poll the server for something? Was it a pain or terribly heavy duty? Did it make you feel dirty? Yeah. SignalR fixes that, and then some.

How? It uses some new tech ([web sockets](http://en.wikipedia.org/wiki/WebSocket)) for the newer browsers and some clever tricks for the older stuff ([long polling](http://en.wikipedia.org/wiki/Push_technology#Long_polling)).

Check out the impressive [live chat](http://jabbr.net/) sample, or watch this [stock ticker](http://vimeo.com/31938189) demo:  

<iframe class="full-embed hd" src="https://player.vimeo.com/video/31938189?badge=0" frameborder="0" allowfullscreen="allowfullscreen" webkitallowfullscreen="webkitallowfullscreen" mozallowfullscreen="mozallowfullscreen"></iframe>

After seeing [Hanselman](http://www.hanselman.com/blog/AsynchronousScalableWebApplicationsWithRealtimePersistentLongrunningConnectionsWithSignalR.aspx) present the above demo at StirTrek, I’ve been meaning to give it a try. So I finally did at last night’s RoviSys hack-a-thon. Here’s what I came up with:  

<iframe class="full-embed hd" src="https://www.youtube.com/embed/cUY6p5CumXI" title="SignalR syncing drag events between iPad and Desktop Chrome" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

That app’s actually [live right now](http://blocky.apphb.com/) and the [source is on GitHub](https://github.com/mharen/devour/tree/master/devour). Check it out! (Note: if you’re not on a solid internet connection, or my host is under load, it’s not going to look great...it’s not been optimized all that much—use some imagination!)

Oh, and it works on mobile.

The potential uses for this technology are numerous. I’m excited to experiment with it more.

---

### 1 comment

**Unknown said on 2012-11-09**

Playing around with this demo gave me one of those "everything I thought I knew about web apps must be wrong" feelings. Amazing.

Comments closed
{: .comments-closed }