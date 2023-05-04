---
layout: post
date: '2009-07-22T22:23:00.001-04:00'
categories:
- work
- technology
title: Structuring Our Developer Tools with a Reverse Proxy
---

Note to off-site viewers: this post has pictures. If you don’t see them, come to the site for a better view!

Running on some innate desire to improve our trade, a few of my coworkers and I are constantly trying out new developer tools. This has some upsides and downsides. The upside is that if a tool sticks, and brings something to the table, we’ve improved things. We can integrate it into our software development methodology to make everything better.

The downside is that by the nature of experimentation, some tools are duds and I sometimes feel like some half-wit software evangelist who promotes change for the sake of change. This is obviously not my intent. Let me be clear on that: my goal is to improve my trade. If something’s not working, I’m among the first to drop it.

Over the last few years, this has led to the collection of a few tools in particular that many of us at Rovisys use daily: 

* Source control: Subversion or Vault (svn’s on the way in, Vault’s on the way out) 
* Issue tracker: Redmine 
* Continuous Integration: Hudson CI 
* Collaboration: Redmine’s Wiki and Microsoft OneNote  

There are many, many other tools that we use but that’s the short list of software everyone on every project I run becomes fluent in. And that’s why we’re putting so much effort in the infrastructure behind them. Here’s where our server architecture was headed:

![]({{ "/assets/2009/structure-1.png" | relative_url }})

That’s ok for now, but it’s short-sighted and could be improved. With the magic of virtualization and a reverse proxy, we will very soon have these tools available through a common address with improved reliability and scalability. This is where we’re headed now:  

![]({{ "/assets/2009/structure-2.png" | relative_url }})

(those weird names are the server names; detect a theme?)

What we’ve done is create a centralized access point into our developer tools while at the same time isolating each tool on its own virtualized server. I consider this a huge improvement for many reasons. Each of those services really deserves its own dedicated server. Since we have a huge Hyper-V server it was pretty simple to build one server VM and clone it a for each service. 

Aside from isolating the tools from each other (making upgrades and scalability easier, improving reliability, etc.), we’ve also given ourselves a nice, clean avenue to grow. The original architecture simply does not scale to additional services. That list can’t get much longer before the server has too much running on it to be fast, reliable, safe and manageable. With the new approach, adding a new service is easy: spin up a new server and tell the reverse-proxy server about it. 

Another bonus: the new tool might not be new at all—it might already exist somewhere in the organization. Since users will access it through a common url (e.g. http://janice/hudson), the actual location or technology behind the tool doesn’t matter.

Here’s where we might be in a few months:

![]({{ "/assets/2009/structure-3.png" | relative_url }}) 

Here I’ve easily and correctly added in our Hudson server (which is already humming along nicely) and a customer project (which was improperly hidden alongside other tools since I had no way to do it properly). 

Some other benefits: SSL is easy, too, since we take care of that at the reverse-proxy. All the individual services get the added security of SSL for free, without even knowing about it. Also, we can move the individual services onto different hardware if needed with very little effort and *zero impact on users.*

Sure this is tough at first because the whole reverse-proxy thing I’m told is a pain to setup (yea for teamwork!) and splitting combined services onto isolated machines is a chore, but in the long run we’ve got something that’s sustainable and will make us all more productive. Or let’s hope and see...