---
date: '2013-02-21T18:03:00.000-05:00'
description: ''
published: true
slug: 2013-02-how-do-i-add-another-group-to-my
tags:
- MongoDB
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: How do I add another group to my MongoDB MMS monitor on 10gen?
---

<p>10gen has some seriously awesome (free) monitoring software: <a href="http://www.10gen.com/products/mongodb-monitoring-service">MMS</a>.</p> <p><img alt="image" border="0" height="536" src="http://lh6.ggpht.com/-UqP3dnfcr2Y/USaLnot120I/AAAAAAAAFjM/syPkCCKfaV4/image%25255B16%25255D.png" style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 3px auto; padding-left: 0px; padding-right: 0px; display: block; float: none; border-top: 0px; border-right: 0px; padding-top: 0px;" title="image" width="802" /></p> <p>You’re supposed to add your machines to a group, and use a different group for each logical grouping of machines. For instance, one group for one production cluster and another group for a different cluster. <strong>But how do you add a new group!?</strong></p> <p>I admit the obvious answer eluded me. You do it from the Admins page. Once there you’ll see a little “Add New Group” link:</p> <p><img alt="image" border="0" height="175" src="http://lh4.ggpht.com/-yoGU3DqvtYg/USaLosVn4EI/AAAAAAAAFjQ/bXiFJCfW5QU/image%25255B17%25255D.png" style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 3px auto; padding-left: 0px; padding-right: 0px; display: block; float: none; border-top: 0px; border-right: 0px; padding-top: 0px;" title="image" width="592" /></p> <p>Once you do that you can switch among your groups with the select list in the upper-left corner. </p>