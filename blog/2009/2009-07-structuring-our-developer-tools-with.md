---
date: '2009-07-22T22:23:00.001-04:00'
description: ''
published: true
slug: 2009-07-structuring-our-developer-tools-with
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: Structuring Our Developer Tools with a Reverse Proxy
---

<p class="feed-note">Note to off-site viewers: this post has pictures. If you don’t see them, come to the site for a better view!</p>
<p>Running on some innate desire to improve our trade, a few of my coworkers and I are constantly trying out new developer tools. This has some upsides and downsides. The upside is that if a tool sticks, and brings something to the table, we’ve improved things. We can integrate it into our software development methodology to make everything better.</p>
<p>The downside is that by the nature of experimentation, some tools are duds and I sometimes feel like some half-wit software evangelist who promotes change for the sake of change. This is obviously not my intent. Let me be clear on that: my goal is to improve my trade. If something’s not working, I’m among the first to drop it.</p>
<p>Over the last few years, this has led to the collection of a few tools in particular that many of us at Rovisys use daily:</p>  <ul>   <li>Source control: Subversion or Vault (svn’s on the way in, Vault’s on the way out) </li>    <li>Issue tracker: Redmine </li>    <li>Continuous Integration: Hudson CI </li>    <li>Collaboration: Redmine’s Wiki and Microsoft OneNote </li> </ul>
<p>There are many, many other tools that we use but that’s the short list of software everyone on every project I run becomes fluent in. And that’s why we’re putting so much effort in the infrastructure behind them. Here’s where our server architecture was headed:</p>
<p>&#160;<img alt="image" border="0" height="109" src="http://lh4.ggpht.com/_IKD9WtY5kxU/SmfJneRfHVI/AAAAAAAAAak/gRy3KvcibeI/image%5B19%5D.png" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="200" /></p>
<p>That’s ok for now, but it’s short-sighted and could be improved. With the magic of virtualization and a reverse proxy, we will very soon have these tools available through a common address with improved reliability and scalability. This is where we’re headed now:</p>  <p align="center"><img alt="image" border="0" height="250" src="http://lh3.ggpht.com/_IKD9WtY5kxU/SmfJnjax-mI/AAAAAAAAAao/_HNmDMdP7w0/image%5B9%5D.png" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="481" /><font size="1">(those weird names are the server names; detect a theme?)</font></p>
<p></p>
<p></p>
<p>What we’ve done is create a centralized access point into our developer tools while at the same time isolating each tool on its own virtualized server. I consider this a huge improvement for many reasons. Each of those services really deserves its own dedicated server. Since we have a huge Hyper-V server it was pretty simple to build one server VM and clone it a for each service. </p>
<p>Aside from isolating the tools from each other (making upgrades and scalability easier, improving reliability, etc.), we’ve also given ourselves a nice, clean avenue to grow. The original architecture simply does not scale to additional services. That list can’t get much longer before the server has too much running on it to be fast, reliable, safe and manageable. With the new approach, adding a new service is easy: spin up a new server and tell the reverse-proxy server about it. </p>
<p>Another bonus: the new tool might not be new at all—it might already exist somewhere in the organization. Since users will access it through a common url (e.g. http://janice/hudson), the actual location or technology behind the tool doesn’t matter.</p>
<p>Here’s where we might be in a few months:</p>
<p><img alt="image" border="0" height="250" src="http://lh4.ggpht.com/_IKD9WtY5kxU/SmfJnwTdP9I/AAAAAAAAAas/THFGuO8FuWM/image%5B22%5D.png" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="671" /> </p>
<p>Here I’ve easily and correctly added in our Hudson server (which is already humming along nicely) and a customer project (which was improperly hidden alongside other tools since I had no way to do it properly). </p>
<p>Some other benefits: SSL is easy, too, since we take care of that at the reverse-proxy. All the individual services get the added security of SSL for free, without even knowing about it. Also, we can move the individual services onto different hardware if needed with very little effort and <em>zero impact on users.</em></p>
<p>Sure this is tough at first because the whole reverse-proxy thing I’m told is a pain to setup (yea for teamwork!) and splitting combined services onto isolated machines is a chore, but in the long run we’ve got something that’s sustainable and will make us all more productive. Or let’s hope and see…</p>