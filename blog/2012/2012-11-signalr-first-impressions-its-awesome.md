---
date: '2012-11-08T23:59:00.000-05:00'
description: ''
published: true
slug: 2012-11-signalr-first-impressions-its-awesome
tags:
- http://schemas.google.com/blogger/2008/kind#post
- NaBloPoMo 2012
- Work
- Code
- SignalR
- Technology
- legacy-blogger
time_to_read: 5
title: "SignalR: First Impressions (It\u2019s Awesome)"
---

<p><a href="https://github.com/SignalR/SignalR#readme">SignalR</a> is an:</p>  <blockquote>   <p>Async signaling library for .NET to help build real-time, multi-user interactive web applications.</p> </blockquote>  <h4></h4>  <p>It narrows the gap among clients, and between each client and the server. SignalR helps you do neat things like update dashboard information to anyone looking at your page (practically) instantly in a <em>very efficient</em> way.</p>  <p>Have you ever written a little refresh routine to poll the server for something? Was it a pain or terribly heavy duty? Did it make you feel dirty? Yeah. SignalR fixes that, and then some.</p>  <p>How? It uses some new tech (<a href="http://en.wikipedia.org/wiki/WebSocket">web sockets</a>) for the newer browsers and some clever tricks for the older stuff (<a href="http://en.wikipedia.org/wiki/Push_technology#Long_polling">long polling</a>).</p>  <p>Check out the impressive <a href="http://jabbr.net/">live chat</a> sample, or watch this <a href="http://vimeo.com/31938189">stock ticker</a> demo:</p>  <p style="text-align: center;"></p>  <p>After seeing <a href="http://www.hanselman.com/blog/AsynchronousScalableWebApplicationsWithRealtimePersistentLongrunningConnectionsWithSignalR.aspx">Hanselman</a> present the above demo at StirTrek, I’ve been meaning to give it a try. So I finally did at last night’s RoviSys hack-a-thon. Here’s what I came up with:</p>  <p align="center"></p>  <p>That app’s actually <a href="http://blocky.apphb.com/">live right now</a> and the <a href="https://github.com/mharen/devour/tree/master/devour">source is on GitHub</a>. Check it out! (Note: if you’re not on a solid internet connection, or my host is under load, it’s not going to look great…it’s not been optimized all that much—use some imagination!)</p>  <p>Oh, and it works on mobile.</p>  <p>The potential uses for this technology are numerous. I’m excited to experiment with it more.</p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2012/11/signalr-first-impressions-its-awesome.html) on Blogger

**Unknown said on 2012-11-09**

Playing around with this demo gave me one of those &quot;everything I thought I knew about web apps must be wrong&quot; feelings. Amazing.

