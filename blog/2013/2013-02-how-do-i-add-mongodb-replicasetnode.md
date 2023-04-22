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

<p>Want to get in on that sweet, sweet <a href="http://www.10gen.com/products/mongodb-monitoring-service">MMS</a> MongoDB monitoring action? </p> <p><img alt="image[20]" border="0" height="269" src="http://lh4.ggpht.com/-CvPPkM1wb4I/USaNtNMpbkI/AAAAAAAAFkE/vjFbfFMOyoo/image%25255B20%25255D%25255B3%25255D.png" style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 3px auto; padding-left: 0px; padding-right: 0px; display: block; float: none; border-top: 0px; border-right: 0px; padding-top: 0px;" title="image[20]" width="403" /></p> <p>Of course you do! But are your mongo instances setup to require authentication? Bummer—the instructions won’t work for you out of the box. Here’s what you’re missing. </p> <ol> <li>Go ahead and setup the agent as instructed</li> <li>Go into the MMS management site</li> <li>Add your host manually

<img alt="image_thumb[8]" border="0" height="105" src="http://lh3.ggpht.com/-U2VyjXaH18Y/USaNuSoLmKI/AAAAAAAAFkI/nY4lsG9_Rc0/image_thumb%25255B8%25255D%25255B3%25255D.png" style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px;" title="image_thumb[8]" width="672" /><br /></li> <li>Enter the hostname, db username, and db password. I suggest creating a new user for this (it must be a user on the admin database!)

<img alt="image_thumb[9]" border="0" height="402" src="http://lh4.ggpht.com/-kK_tSRiweBc/USaNu7_65tI/AAAAAAAAFkM/9HgqLFoPOt8/image_thumb%25255B9%25255D%25255B3%25255D.png" style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px;" title="image_thumb[9]" width="509" /></li></ol> <p>Now frantically check the hosts, agents, and pings tabs for updates. It might take a few minutes. Check the Agent Log tab for errors :).</p> <p>Once you get the one host working, it will add the other hosts in the replicaset, too. You can then install the agent on those machines and add a password with the pencil icon to each new row directly.</p>