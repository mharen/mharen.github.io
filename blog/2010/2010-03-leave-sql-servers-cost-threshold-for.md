---
date: '2010-03-02T13:36:00.001-05:00'
description: ''
published: true
slug: 2010-03-leave-sql-servers-cost-threshold-for
tags:
- http://schemas.google.com/blogger/2008/kind#post
- legacy-blogger
time_to_read: 5
title: "Leave SQL Server\u2019s Cost Threshold for Parallelism Alone"
---

<p>I’ve been told that these programming posts are not interesting or funny. For those that have no interest in programming, I offer the following joke:</p>
<blockquote> 
<p>“I like fruit baskets because it gives you the ability to mail someone a piece of fruit without appearing insane. Like, if someone just mailed you an apple you’d be like ‘Huh? What the hell is this?’, but if it’s in a fruit basket you’re like ‘This is <em>nice!</em>.’” –<a href="http://www.demetrimartin.com/">Demetri Martin</a> (<a href="http://captainpinhead.wordpress.com/2006/10/01/demetri-martin-quotes/">via</a>)</p>
</blockquote>
<p>Now would be a good time for you to stop reading.</p>  <hr />
<p><a href="http://www.urbandictionary.com/define.php?term=sad+panda">![125981194793.png](125981194793.png)</a>A while back I was performance-testing a new SQL Server cluster. This machine was years-better than the system it was replacing and the perf-test was showing it. Everything I threw at it was flying—this thing was screaming fast.</p>
<p>Then we started load testing. This was basically an integration test where we turned on everything at once and <a href="http://en.wikipedia.org/wiki/Up_to_eleven">cranked it to 11</a>. Only we didn’t get to 11 because our server fell over at 2, making me a sad panda. The server started throwing strange and never-before-seen (by me) errors about problems with memory, threads, timeouts, etc. It looked like this:</p>
<p>![image%5B5%5D.png](image%5B5%5D.png) </p>
<p>We had barely loaded the machine with concurrency and it was freaking out. It’d run in spurts of blazing glory, then fail to a grinding halt. After a lot of personal freaking out (we had a very, very tight schedule measured in minutes), I discovered the culprit: parallelism. </p>
<p>Normally you would think parallelism would be a good thing—many cores make light work (this machine had 16!). Unfortunately that’s just not so in all cases. <strong>The overhead to split a query into parallel chunks, execute the chunks, and join the results together is significant.</strong> It turns out it’s extremely significant for simple queries and increases the complexity/load required to execute them dramatically.</p>
<p>Fortunately, SQL Server knows all this and has a setting for it:</p>
<p>![image%5B2%5D.png](image%5B2%5D.png) </p>
<p>The <a href="http://msdn.microsoft.com/en-us/library/aa196716(SQL.80).aspx">cost threshold for parallelism</a>. This value is in seconds. When SQL Server estimates a query will take longer than x seconds to be executed, the query is executed in <em>parallel</em>; otherwise <em>serial</em>.</p>
<p><strong>Do not set this to a very low value like my DBA apparently did. </strong></p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2010/03/leave-sql-servers-cost-threshold-for.html) on Blogger

**Unknown said on 2013-12-16**

Okay, I'm know this is an old post, but since I found it today somebody else might find it later.  

5 is the default for this setting, so your DBA didn't set it. That's really the issue.  That's a dated setting and it should be raised.  It is a setting you need to test as well.  I've seen recommendations that say start at 20 and adjust and some that say start at 50.  It really depends on the server use.  Datawarehouse/reporting queries should use parallelism, while OLTP queries really shouldn't.  Here's a blog post about it http://www.sqlskills.com/blogs/jonathan/tuning-cost-threshold-for-parallelism-from-the-plan-cache/.

MaxDOP should also be set to something other than 0 which is the default. http://support.microsoft.com/kb/2806535



