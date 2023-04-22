---
date: '2013-02-21T19:11:00.000-05:00'
description: ''
published: true
slug: 2013-02-how-do-i-add-mongodb-replicasetnode
tags:
- Database
- MongoDB
- http://schemas.google.com/blogger/2008/kind#post
- Work
- legacy-blogger
time_to_read: 5
title: How do I add a MongoDB replicaset/node with auth/credentials to MMS monitor
  on 10gen?
---


Want to get in on that sweet, sweet [MMS](http://www.10gen.com/products/mongodb-monitoring-service) MongoDB monitoring action? 

![image%5B20%5D%5B3%5D.png](image%5B20%5D%5B3%5D.png)

Of course you do! But are your mongo instances setup to require authentication? Bummer—the instructions won’t work for you out of the box. Here’s what you’re missing.  <ol> <li>Go ahead and setup the agent as instructed</li> <li>Go into the MMS management site</li> <li>Add your host manually

![image_thumb%5B8%5D%5B3%5D.png](image_thumb%5B8%5D%5B3%5D.png)</li> <li>Enter the hostname, db username, and db password. I suggest creating a new user for this (it must be a user on the admin database!)

![image_thumb%5B9%5D%5B3%5D.png](image_thumb%5B9%5D%5B3%5D.png)</li></ol>

Now frantically check the hosts, agents, and pings tabs for updates. It might take a few minutes. Check the Agent Log tab for errors :).

Once you get the one host working, it will add the other hosts in the replicaset, too. You can then install the agent on those machines and add a password with the pencil icon to each new row directly.