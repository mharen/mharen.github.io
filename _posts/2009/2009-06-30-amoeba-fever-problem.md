---
layout: post
date: '2009-06-30T15:58:00.002-04:00'
categories:
- math
- code
- technology
title: Amoeba Fever Problem
---

My brother, Chris, sent me this interesting [math problem](http://yofx.blogspot.com/2009/06/amoeba-fever-problem.html):

> Toby has a jar with one amoeba in it. Every minute, every amoeba turns into 0, 1, 2, or 3 amoebae with a probability of 1/4 for each case (dies, does nothing, splits into two, or splits into three). What is the probability that the amoeba population eventually dies out?

I initially threw out a guess of “slightly more than 25%”. I figured that the amoeba population either dies out right away (1/4 chance) or starts growing rapidly.

I was up a bit with Maya and thought about this some more and revised my guess to somewhere between 25% and 33%. My reasoning was looking more professional (but not actually any more accurate, as we’ll discuss). I reasoned that the change of an amoeba population die out after n iterations is   

![](/assets/2009/amoeba-1.gif)

So the chance of the first 3 iterations leading to die out would be something like:  

![](/assets/2009/amoeba-2.gif)

Or more generally:  

![](/assets/2009/amoeba-3.gif)

This converges very rapidly so any additional terms beyond n=3 are insignificant here.

This approach is not very accurate as it assumes linear growth of the population which is not promised, though I figured it’d be close. Being a programmer, I decided to write a [simple simulator](http://jsbin.com/afoli) to just brute force the answer.

This little in-browser JavaScript application runs through hundreds or thousands of “jars” to see how often the jar flourishes with life or dies out. I assume that if the population reaches 1000 amoebae that it will *never* die off (that is, the chances of it are small enough to consider it a win). In fact, flipping through my results shows that if a jar can survive 9 iterations, it’s almost certain it will flourish (a much lower standard would probably suffice).

Anyway, so after 10000 jars are tested, I get a number of about 41%. (note: don’t use the 10000x button unless you’re using FF3.5, Chrome, or a recent Safari...it’s too slow for less recent browsers including IE8).

Chris has promised to check the math later and determine if I’m close.

Feel free to do a view-source, or look at the page in [edit mode](http://jsbin.com/afoli/edit). It won’t let you overwrite my version so hack away. When readying to criticize my code, keep in mind that I wrote it at 4am and haven’t prepared it for public scrutiny. The fact that it’s so slow tells me I’m doing something horribly inefficient somewhere...

---

### 2 comments

**Math Zombie said on 2009-06-30**

Well, i didn't exactly promise. But I guess that puts more pressure on me. Time to bust off the ol' probability notes.

**Michael Haren said on 2009-07-01**

You're committed.

