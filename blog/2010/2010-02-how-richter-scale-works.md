---
date: '2010-02-28T23:35:00.001-05:00'
description: ''
published: true
slug: 2010-02-how-richter-scale-works
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Math
- In the News
- legacy-blogger
time_to_read: 5
title: How the Richter Scale Works
---

<p>I saw <a href="http://www.examiner.com/x-4454-Geopolitics-Examiner~y2010m2d28-Chiles-earthquake-500-times-stronger-yet-less-destructive-than-Haitis-Photos">this headline</a>:</p>  <blockquote>   <p><strong>Chile’s earthquake 500 times stronger yet less destructive than Haiti’s</strong></p> </blockquote>  <p>and started wondering: how Chile’s quake could be 500x as powerful as Haiti’s when their respective Richter scale magnitudes are 8.8 vs. 7.0? The “less destructive” part is interesting, too, but everyone’s already talking about that so I’ll focus on the scale.</p>  <p>The first clue is that the scale is <a href="http://en.wikipedia.org/wiki/Logarithm">logarithmic</a>. That means that each increment of 1 is a 10x increase in magnitude. If you were to plot <em>x</em> vs. <em>log<sub>10</sub>(x)</em>, it might look like this:</p>  <p>&#160;<img alt="image" border="0" height="402" src="http://lh3.ggpht.com/_IKD9WtY5kxU/S4tEH9A4jjI/AAAAAAAAApY/bibWf2HfNVc/image%5B11%5D.png?imgmax=800" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="656" />&#160;</p>  <p>Well, that’s not very revealing until you realize that the <em>x</em>-axis is increasing logarithmically. Consider the same data but with the <em>x</em>-axis presented linearly:</p>  <p>&#160;<img alt="image" border="0" height="402" src="http://lh3.ggpht.com/_IKD9WtY5kxU/S4tEIdxSFyI/AAAAAAAAApc/01mTlXYxzss/image%5B8%5D.png?imgmax=800" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="656" /></p>  <p>Now we’re talking. Each increment on the <em>y</em>-axis is a <strong>10x </strong>increment on the y-axis. i.e. 8 is 10x greater in magnitude than a 7:</p>  <blockquote>   <p>10<sup>8</sup>/10<sup>7</sup> = 10</sup></sup></p> </blockquote>  <p>So it follows then that an 8.8 (Chile) vs. 7.0 (Haiti) would be:</p>  <blockquote>   <p>10<sup>8.8</sup>/10<sup>7</sup> = 63</p> </blockquote>  <p>Thus an 8.8 is 63 times greater in magnitude than a 7. Wow. OK so how do we get to 500x more destructive? It would seem that the news is using a different factor: energy. I didn’t dig into all the math behind it but the <a href="http://en.wikipedia.org/wiki/Richter_magnitude_scale#Richter_magnitudes">gist of it</a> seems to be that while the Richter scale measures raw amplitude of the little pencil on the paper wheel/strip triggered by the earthquake's waves, the actual energy factor is much higher than 10:</p>  <blockquote>   <p>Because of the logarithmic basis of the scale, each whole number increase in magnitude represents a tenfold increase in measured amplitude; in terms of energy, each whole number increase corresponds to an <strong>increase of about 31.6 times</strong> the amount of energy released.</p> </blockquote>  <p>So I guess the news people are applying this to the log scale with a <em>base of 31.6 instead of 10</em>. Let’s check:</p>  <blockquote>   <p>31.6<sup>8.8</sup>/31.7<sup>7</sup> = 501</p> </blockquote>  <p>Hooray! I honestly didn’t know that would work until I got to this point and calculated it (phew!). So this makes me wonder how effective a scale is when it’s not…intuitive at all. Certainly a simple, scientific number is helpful, but I’m not sure this is the right number to use in casual conversation. </p>  <p>Instead, numbers related to life lost, people displaced, or damage are probably more relevant and appropriate to compare. For example, the <a href="http://online.wsj.com/article/SB10001424052748704089904575094013194396670.html?mod=WSJ-World-LeadStory">current mortality estimates</a> are: Chile 700, Haiti 220,000:</p>  <blockquote>   <p>220000/700 = 314</p> </blockquote>  <p>The quake in Haiti has killed (to date) 314 times more people than the quake in Chile. (That article also explains the 500 figure pretty well—I should have read it before writing this post :P)</p>  <p>On a very related note, there’s a super cool <a href="http://www.wnyc.org/shows/radiolab/episodes/2009/10/09">Radio Lab podcast</a> about numbers which explores the idea that we count logarithmically when born but learn to count absolutely as children. Neat.</p>  <p>Also of note: decibels—a measurement of sound intensity is in <a href="http://en.wikipedia.org/wiki/Logarithmic_unit#Examples">logarithmic units</a>, too, as is <a href="http://en.wikipedia.org/wiki/PH">pH</a> in chemistry.</p>  <p>Finally, for tons of info on Earthquakes, checkout the <a href="http://earthquake.usgs.gov/earthquakes/">USGS</a>.</p>

---

## 2 comments captured from [original post](https://blog.wassupy.com/2010/02/how-richter-scale-works.html) on Blogger

**Patrick said on 2010-03-01**

a)Why so many blog posts, after two months of silence?  I am confused.

b)What was the mortality in Haiti two days after the quake?  I feel like that would be a more fair comparison - it has been raising since then, and Chile's will raise too.

**Michael Haren said on 2010-03-01**

@Patrick,

&gt; a)Why so many blog posts, after two months of silence? I am confused.

I write when I can. Sarah and the girls were out most of Saturday so I had time to finish off a bunch of posts and write some new ones.

&gt; b)What was the mortality in Haiti two days after the quake? I feel like that would be a more fair comparison - it has been raising since then, and Chile's will raise too.

I agree. In this case, Chile's won't grow nearly as fast as Haiti's but you're right--a time-corrected comparison would be best.

