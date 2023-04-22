---
date: '2009-06-30T15:58:00.002-04:00'
description: ''
published: true
slug: 2009-06-amoeba-fever-problem
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Math
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Amoeba Fever Problem
---

<p>My brother, Chris, sent me this interesting <a href="http://yofx.blogspot.com/2009/06/amoeba-fever-problem.html">math problem</a>:</p>
<blockquote> 
<p>Toby has a jar with one amoeba in it. Every minute, every amoeba turns into 0, 1, 2, or 3 amoebae with a probability of 1/4 for each case (dies, does nothing, splits into two, or splits into three). What is the probability that the amoeba population eventually dies out?</p>
</blockquote>
<p>I initially threw out a guess of “slightly more than 25%”. I figured that the amoeba population either dies out right away (1/4 chance) or starts growing rapidly.</p>
<p>I was up a bit with Maya and thought about this some more and revised my guess to somewhere between 25% and 33%. My reasoning was looking more professional (but not actually any more accurate, as we’ll discuss). I reasoned that the change of an amoeba population die out after n iterations is </p>  <p align="center"><img alt="clip_image002" border="0" height="36" src="http://lh6.ggpht.com/_IKD9WtY5kxU/SkpuXAfjJ6I/AAAAAAAAANw/a1aB5p2PYM8/clip_image002%5B3%5D.gif" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="clip_image002" width="16" /></p>
<p>So the chance of the first 3 iterations leading to die out would be something like:</p>  <p align="center"><img alt="clip_image002[4]" border="0" height="36" src="http://lh6.ggpht.com/_IKD9WtY5kxU/SkpuXRZrk0I/AAAAAAAAAN0/C7tA73mFz5w/clip_image002%5B4%5D%5B2%5D.gif" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="clip_image002[4]" width="234" /></p>
<p></p>
<p>Or more generally:</p>  <p align="center"><img alt="clip_image002[6]" border="0" height="51" src="http://lh5.ggpht.com/_IKD9WtY5kxU/SkpuXV3tKmI/AAAAAAAAAN4/DMPRf-PwmkA/clip_image002%5B6%5D%5B2%5D.gif" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="clip_image002[6]" width="43" /></p>
<p></p>
<p>This converges very rapidly so any additional terms beyond n=3 are insignificant here.</p>
<p>This approach is not very accurate as it assumes linear growth of the population which is not promised, though I figured it’d be close. Being a programmer, I decided to write a <a href="http://jsbin.com/afoli">simple simulator</a> to just brute force the answer.</p>
<p>This little in-browser JavaScript application runs through hundreds or thousands of “jars” to see how often the jar flourishes with life or dies out. I assume that if the population reaches 1000 amoebae that it will *never* die off (that is, the chances of it are small enough to consider it a win). In fact, flipping through my results shows that if a jar can survive 9 iterations, it’s almost certain it will flourish (a much lower standard would probably suffice).</p>
<p>Anyway, so after 10000 jars are tested, I get a number of about 41%. (note: don’t use the 10000x button unless you’re using FF3.5, Chrome, or a recent Safari…it’s too slow for less recent browsers including IE8).</p>
<p>Chris has promised to check the math later and determine if I’m close.</p>
<p>Feel free to do a view-source, or look at the page in <a href="http://jsbin.com/afoli/edit">edit mode</a>. It won’t let you overwrite my version so hack away. When readying to criticize my code, keep in mind that I wrote it at 4am and haven’t prepared it for public scrutiny. The fact that it’s so slow tells me I’m doing something horribly inefficient somewhere…</p>

---

## 2 comments captured from [original post](https://blog.wassupy.com/2009/06/amoeba-fever-problem.html) on Blogger

**Math Zombie said on 2009-06-30**

Well, i didn't exactly promise. But I guess that puts more pressure on me. Time to bust off the ol' probability notes.

**Michael Haren said on 2009-07-01**

You're committed.

