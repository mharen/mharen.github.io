---
date: '2012-11-13T23:31:00.001-05:00'
description: ''
published: true
slug: 2012-11-building-analog-clock-without-flash-or
tags:
- http://schemas.google.com/blogger/2008/kind#post
- NaBloPoMo 2012
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Building an Analog Clock without Flash or Images
---


Thing1 is learning to tell time on analog and digital clocks. Her uncle was kind enough to send over a link to an <a href="http://www.oswego.org/ocsd-web/games/StopTheClock/sthec1.html">online game</a> that helps reinforce what she’s learning. 

![image2.png](image2.png)

It is pretty neat! Unfortunately, though, it’s implemented in Flash so we can’t use it on our iOS devices. Let’s fix that by turning it into a regular web page. We might end up using some of the fancier HTML/CSS/JS things as we go.

The first thing we’ll need is an analog clock so we’ll build that today. I’m going to do it the hard way by insisting that no images be used. Just for fun.

*(Note: very little of this is likely to work in anything except Chrome. Sorry.)*

Let’s start by defining where the clocks should go with some very basic layout:



Now we need some elements to hold the times. Let’s use that fancy new &lt;time&gt; tag:



Now let’s restyle them into clock faces by making some circles and hiding the text:



How about some tick marks? We’ll use a little Javascript to help us add the 60 ticks, but we’ll style them with CSS:



And some numerals:



Next, let's add the hour and minute hands:



Looking good. Now let's cap those off with a pin in the middle:



It's nice, but a little flat. Let's use some spiffy gradients to the face and pin:



How about some box-shadow on the hands for more depth?



Err. Ew. That doesn't work because the effect is applied before the rotation. That leads to each shadow going in a different direction...not very natural. Luckily, someone <a href="http://stackoverflow.com/a/8833172/29">figured out</a> a better way by factoring in the rotation angle. Much better:



Next time I’ll build a digital clock widget…but don’t get your hopes up—it will be simpler.

NB: I <a href="https://twitter.com/mharen/status/268426088076697600">tweeted</a> a version of this clock before writing the post and my pal <a href="http://xdumaine.com/">Xander</a> wired up the clock’s state to a view model with <a href="http://knockoutjs.com/">Knockout</a> and animated it. <a href="http://jsfiddle.net/frCyn/4/">Spiffy</a>.

---

## 1 comments captured from [original post](https://blog.wassupy.com/2012/11/building-analog-clock-without-flash-or.html) on Blogger

**Sarah said on 2012-11-14**

This is great!  Looking forward to seeing it in action!

