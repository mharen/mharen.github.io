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

<p>The remote server returned an error: (403) Forbidden.I’m at working trying to toss up blog post here and there and things are coasting along smoothly with Windows Live Writer when I see this when I hit <em>publish</em> (bonk):</p>  <p align="center"><img alt="image" border="0" height="225" src="http://lh5.ggpht.com/_IKD9WtY5kxU/SkkCsZdm6yI/AAAAAAAAANo/ZXQTMOHLO9Y/image3.png?imgmax=800" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="357" /> (The remote server returned an error: (403) Forbidden.)</p>  <p align="left">This was working fine yesterday so I’m assuming I’m being blocked by my corporate firewall. OK, let’s confirm that.</p>  <p align="left">I can access blogger.com, mharen.blogspot.com, my dashboard, the post editor…everything’s fine through the browser, just not through Live Writer. I fired up Fiddler to see what LW’s doing and saw the problem right away:</p>  <p align="left"><img alt="image" border="0" height="134" src="http://lh5.ggpht.com/_IKD9WtY5kxU/SkkCsqqDiOI/AAAAAAAAANs/yK8xGQo6ExM/image8.png?imgmax=800" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="420" /> </p>  <p align="left">It seems that even none of the blogger/blogspot domains are blocked here, blogger ships its images to <a href="http://picasaweb.google.com/">http://picasaweb.google.com/</a>, which <em>is </em>blocked. No matter, I asked our friendly IT admin to unblock it. Now I can publish. But did it work?</p>  <p align="left">Sort of. The publish worked but the image wasn’t coming through. It seems that the img src is actually on another domain. e.g. http://<strong>lh3</strong>.ggpht.com/…. In my case, lh3 is blocked but lh5 isn’t. So I switched the images to lh5 and they all work just fine from within my corporate firewall (for now).</p>