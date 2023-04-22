---
date: '2009-06-29T14:06:00.002-04:00'
description: ''
published: true
slug: 2009-06-diagnosis-ii-why-cant-livewriter-post
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Windows
- Technology
- legacy-blogger
time_to_read: 5
title: "Diagnosis II: Why Can\u2019t LiveWriter Post from Work?"
---


The remote server returned an error: (403) Forbidden.I’m at working trying to toss up blog post here and there and things are coasting along smoothly with Windows Live Writer when I see this when I hit *publish* (bonk):  

![image8.png](image8.png)   

It seems that even none of the blogger/blogspot domains are blocked here, blogger ships its images to [http://picasaweb.google.com/](http://picasaweb.google.com/), which *is *blocked. No matter, I asked our friendly IT admin to unblock it. Now I can publish. But did it work?  

Sort of. The publish worked but the image wasn’t coming through. It seems that the img src is actually on another domain. e.g. http://**lh3**.ggpht.com/…. In my case, lh3 is blocked but lh5 isn’t. So I switched the images to lh5 and they all work just fine from within my corporate firewall (for now).