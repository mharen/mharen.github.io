---
layout: post
date: '2012-12-12T18:55:00.001-05:00'
categories: technology
title: 'Google Analytics: Fun with Advanced Segments'
---


I was curious about how my blog’s visitor’s tech has changed over the years. Perhaps Google Analytics can help?

The normal stats you get for your users are pretty nice:

![image%5B2%5D.png](image%5B2%5D.png)

But this doesn’t show us how they’ve changed *over time*. For instance, how has Internet Explorer fared over the last two years? You can do this with [advanced segments](https://support.google.com/analytics/bin/answer.py?hl=en-GB&amp;answer=1033017&amp;topic=1032940&amp;rd=1).

Click the advanced segments button and add a few custom segments for the metric you’re interested in. In my case, I added one for browsers that look like IE, and browsers that don’t:

![image%5B20%5D.png](image%5B20%5D.png)

![image%5B28%5D.png](image%5B28%5D.png)

Then add those to your report:

![image%5B31%5D.png](image%5B31%5D.png)

And you get something like this:

![image%5B11%5D.png](image%5B11%5D.png)

It looks like my IE traffic has always been less than other browsers, and it’s also grown at a much slower rate leading to the huge disparity I see today.

This shows the visitor count for each month, so this shows raw growth, too. I’d prefer to look at this in percentage terms but I couldn’t figure that out. Dumping these data into a spreadsheet lets me view things the way I wanted initially:

![image%5B14%5D.png](image%5B14%5D.png)

After a little pivot table action and a chart, I have what I want:

![image%5B17%5D.png](image%5B17%5D.png)

We can see that IE popularity is dropping slowly…much more slowly than I expected. Let’s see if we can abuse visualizations a little to make this look more dramatic. Here’s the “trend” view:

![image%5B34%5D.png](image%5B34%5D.png)

I used independent scales. It’s super effective.

Google Analytics is a fun thing to turn on when a project starts and then forget about for a while. Some day later, you can come back and lose two hours exploring the trove of data you’ve collected.  <hr />

Here’s some more stat candy if that’s what you’re in to. Watch out, BlackBerry users, you’re as popular as PS3 (#LOLWUT):

![image%5B5%5D.png](image%5B5%5D.png)

I’m pleasantly surprised to see that 1280px+-wide monitors make up more than 80% of my traffic. I’m sad for all those poor souls using the BS “HD” resolution of 1366x768, though. 

![image%5B8%5D.png](image%5B8%5D.png)

---

## 1 comments captured from [original post](https://blog.wassupy.com/2012/12/google-analytics-fun-with-advanced.html) on Blogger

**albina N muro said on 2013-04-13**

Google+ circles - More by Eugen Oprea

Nov 6, 2012 – Google Analytics Advanced Segments are powerful filters that can help you segment data. Learn more about them in this article. [see more here ](http://www.jdmediasurge.com/google-analtyics-training/" rel="nofollow)


