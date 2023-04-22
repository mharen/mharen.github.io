---
date: '2011-03-05T22:43:00.001-05:00'
description: ''
published: true
slug: 2011-03-code-isnt-always-best-tool
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- Project Noodle
- legacy-blogger
time_to_read: 5
title: "Code Isn\u2019t Always the Best Tool"
---


One of my favorite, routine questions I ask in interviews comes from Steve Yegge’s post on [phone screening](http://sites.google.com/site/steveyegge2/five-essential-phone-screen-questions):
<blockquote> 

<strong>Many C/C++/Java candidates, even some with 10+ years of experience, would happily spend a week writing a 2,500-line program to do something you could do in 30 seconds with a simple Unix command.</strong>  

…Last year my team had to remove all the phone numbers from 50,000 Amazon web page templates, since many of the numbers were no longer in service, and we also wanted to route all customer contacts through a single page.  

Let's say you're on my team, and we have to identify the pages having probable U.S. phone numbers in them. To simplify the problem slightly, assume we have 50,000 HTML files in a Unix directory tree, under a directory called &quot;/website&quot;. We have 2 days to get a list of file paths to the editorial staff. You need to give me a list of the .html files in this directory tree that appear to contain phone numbers in the following two formats: (xxx) xxx-xxxx and xxx-xxx-xxxx.  

How would you solve this problem? Keep in mind our team is on a short (2-day) timeline.
</blockquote>

As Steve goes on to explain, the wrong answer to this question is to write a bunch of code. Instead, you should leverage other tools. For example, the following tools are on the laptop I type this from right now and are capable of solving this problem in *seconds*: Grep, Visual Studio, Notepad++, and Eclipse. Tools like these are on all development machines and you’d be expected to be familiar with them.

As a software engineer, I have an awesome toolbox loaded up with great technology to help me build neat stuff. However, as in the case above, my favorite tool (code) isn’t always appropriate.  

I offer my own [Project Noodle](http://blog.wassupy.com/search/label/Project%20Noodle) as another example. Project Noodle was my software idea to track candidates through the interview process. My goal was to improve recruiting through analysis of better-captured data. After reviewing my project ideas with the actual people who would use this system, they were all very excited. They showed me how they track things now and what data they are looking to track in the future.   

![DK_Hammer%5B2%5D.png](DK_Hammer%5B2%5D.png)It eventually became evident to me that the perfect tool already exists in Microsoft Excel. It turned out that the people I was designing a tool for were already using it very effectively. I could certainly improve things a bit and make the process a little smoother and prettier, but it simply isn’t worth it when a suitable tool is already in place.  

<strong>I think choosing *not *to write a program in cases like this is obvious to non-programmers, but not for us software people. For us it’s a difficult realization.</strong> In the case of Project Noodle, I’ve invested considerable effort designing it already, but I must admit that it’s not the best solution for the problem. Luckily, I came to this awareness early in the process, saving me countless hours of wasted effort.  

Sometimes our favorite tool isn’t the best tool.  

I offer just one counterexample: educational coding. It’s absolutely ok to develop something that otherwise shouldn’t be written if the purpose in doing so is self-development.  

(This should not be used as an argument against building new software—there’s a delicate balance between using off-the-shelf products and [rolling your own](../2011/2011-02-case-for-rolling-it-all-yourself.html).)