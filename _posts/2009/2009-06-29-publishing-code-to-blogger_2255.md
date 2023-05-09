---
layout: post
date: '2009-06-29T14:01:00.002-04:00'
categories:
- windows
- technology
title: Publishing Code to Blogger
---

Publishing code to a blog can be tough. On my old blog engine (wordpress), I felt like I had more control with respect to plugins, javascript, css, etc. Here, on blogger, things are a little different. 

I’ve turned to [Windows Live Writer](http://windowslivewriter.spaces.live.com/). It’s actually pretty slick and integrates well with Blogger. I added the [Code Block plugin](http://gallery.live.com/liveItemDetail.aspx?li=1f57bd9b-a692-4593-9e9e-e2962d9c0eee) which does syntax highlighting pretty well. 

**A Few Gripes and Gotchas**

Live Writer comes with a whole suite of “Live” tools. After installing Live Writer, I had MSN popping up and new addons in outlook wanting my attention. It is certainly not the light and easy text editor I was hoping for.

Next, posts published with Live Writer will often have a bunch of extra newlines in them. This can be fixed by telling Blogger not to convert line breaks:

{% imagesize /assets/2009/pub-to-blogger.png:img %}

Finally, I’m not a big fan of the way the code block plugin I mentioned earlier handles CSS. It inserts a new block of styles with every single code block. The workaround seems to be simple enough, though: add the CSS block to the template’s styles and make sure to uncheck “Embed Stylesheet” each time you insert code.

**On a Positive Note**

It handles images well (I can paste in images from other programs). It handles links well. It blends the WYSIWYG/HTML editing well and with a pretty good plugin community, I’m liking it better than other editors I’ve used in the past.

I’m a fan—I’m using it to write this post!
