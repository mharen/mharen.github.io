---
layout: post
date: '2005-01-12T19:00:00.001-05:00'
categories:
- work
- technology
title: tech humor - sql craziness
---

I've been working at RoviSys for a little while now and one of my projects just went live. The release didn't go very smoothly from what I hear. Particularly, there was a lot of trouble with one of my sql queries. For those not familiar, a 'sql query' is like a command that looks things up and a lot of different books but does it very quickly. If you go to whitepages.com and google, etc. and search for someone, a 'query' is being executed to find the information you are looking for. In my case, I had a query that was supposed to give you a list of data for a dataview. This query was taking an obscene 30 seconds to execute. While that's not really very long in human years, it should be taking less than one second to execute. This delay causes all sorts of problems. 

Bryan, the sql-guy, took a look at the query and proceeded to craft this response:

<div style="background-color: #eee; border: 1px dotted #600;">Book of SQL 24:17,

*"Thou shalt not return many columns with an ORDER BY statement.  If thou dost return too many columns, time shall progress, seasons shall change, before thou dost see thy results.  Thou shalt consider rending apart a query of many columns, as the cloth is when sewn, into seperate queries.  And some had said: 'the Supplier data was not needed in the Dataview, and so should have been queried only when creating the edit pop-up.'  And those who said such a thing were considered wise."*

&nbsp;&nbsp;&nbsp;&nbsp; --B. DeBois

</div> 

He later confessed that he's not really sure what the problem with the query was but following the above guideline more strictly did indeed resolve the problem. I would argue that at one time, before the project specs changed, the supplier data was needed in the dataview...but he's right because it's not needed anymore. In either case, two queries would probably be better, anyway.