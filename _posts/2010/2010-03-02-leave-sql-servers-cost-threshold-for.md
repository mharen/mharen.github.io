---
layout: post
date: '2010-03-02T13:36:00.001-05:00'
categories:
title: "Leave SQL Server's Cost Threshold for Parallelism Alone"
---

I’ve been told that these programming posts are not interesting or funny. For those that have no interest in programming, I offer the following joke:

> I like fruit baskets because it gives you the ability to mail someone a piece of fruit without appearing insane. Like, if someone just mailed you an apple you’d be like ‘Huh? What the hell is this?’, but if it’s in a fruit basket you’re like ‘This is *nice!*.’
> 
> – [Demetri Martin](http://www.demetrimartin.com/) ([via](http://captainpinhead.wordpress.com/2006/10/01/demetri-martin-quotes/))

Now would be a good time for you to stop reading.  

***


A while back I was performance-testing a new SQL Server cluster. This machine was years-better than the system it was replacing and the perf-test was showing it. Everything I threw at it was flying—this thing was screaming fast.

Then we started load testing. This was basically an integration test where we turned on everything at once and [cranked it to 11](http://en.wikipedia.org/wiki/Up_to_eleven). Only we didn’t get to 11 because our server fell over at 2, making me a sad panda. The server started throwing strange and never-before-seen (by me) errors about problems with memory, threads, timeouts, etc. It looked like this:

![]({{ "/assets/2010/parallelism-5.png" | relative_url }}) 

We had barely loaded the machine with concurrency and it was freaking out. It’d run in spurts of blazing glory, then fail to a grinding halt. After a lot of personal freaking out (we had a very, very tight schedule measured in minutes), I discovered the culprit: parallelism. 

Normally you would think parallelism would be a good thing—many cores make light work (this machine had 16!). Unfortunately that’s just not so in all cases. **The overhead to split a query into parallel chunks, execute the chunks, and join the results together is significant.** It turns out it’s extremely significant for simple queries and increases the complexity/load required to execute them dramatically.

Fortunately, SQL Server knows all this and has a setting for it:

![]({{ "/assets/2010/parallelism-2.png" | relative_url }}) 

The [cost threshold for parallelism](http://msdn.microsoft.com/en-us/library/aa196716(SQL.80).aspx). This value is in seconds. When SQL Server estimates a query will take longer than x seconds to be executed, the query is executed in *parallel*; otherwise *serial*.

**Do not set this to a very low value like my DBA apparently did.**

---

### 1 comment

**Unknown said on 2013-12-16**

Okay, I'm know this is an old post, but since I found it today somebody else might find it later.  

5 is the default for this setting, so your DBA didn't set it. That's really the issue.  That's a dated setting and it should be raised.  It is a setting you need to test as well.  I've seen recommendations that say start at 20 and adjust and some that say start at 50.  It really depends on the server use.  Datawarehouse/reporting queries should use parallelism, while OLTP queries really shouldn't.  Here's a blog post about it http://www.sqlskills.com/blogs/jonathan/tuning-cost-threshold-for-parallelism-from-the-plan-cache/.

MaxDOP should also be set to something other than 0 which is the default. http://support.microsoft.com/kb/2806535



