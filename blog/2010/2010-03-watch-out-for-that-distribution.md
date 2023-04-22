---
date: '2010-03-11T11:38:00.001-05:00'
description: ''
published: true
slug: 2010-03-watch-out-for-that-distribution
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: Watch out for that Distribution Database
---

<p>I received some pretty <a href="http://twitter.com/mharen/status/10326855258">serious alerts this morning</a> about our database server running low on disk space and quickly discovered something amiss:</p>
<p>![image%5B2%5D.png](image%5B2%5D.png) </p>
<p>That’s a tad higher than usual…just 100x bigger than it should be (yikes)! Allow me to illustrate how I imagine the last few months going for this gargantuan file:</p>
<p>![db-growth%5B5%5D.png](db-growth%5B5%5D.png) </p>
<p>The problem turned out to be that several of the replication SQL jobs were disabled (since…months ago). The pertinent job is probably this one, the distribution clean up job:</p>
<p>![image%5B5%5D.png](image%5B5%5D.png) </p>
<p>It’s supposed to run every 10 minutes to tidy things up in the distribution database. I guess not running for <em>three months </em>could lead to some problems (eek!). There’s really no excuse for this—it’s embarrassing. I’m not the DBA for this system but I should have noticed; a lot of people should have noticed.</p>
<p>Since this task was disabled (not failing), it didn’t show up in our usual alert stream. I’m not sure how we solve that problem other than create an alert that detects disabled jobs. Or better yet, we could create alerts that fire whenever the job hasn’t run in the last <em>n</em> minutes—something like that. </p>
<p>Of course adding more sensitive alerts to the sizes of certain files or the free space of certain drives will help, too.</p>
<p>So I guess the lesson here is to run regular checkups on your critical infrastructure and leverage monitoring services if you can to make the checkups easier and more effective.</p>