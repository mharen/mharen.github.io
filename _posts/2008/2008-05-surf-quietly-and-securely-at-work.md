---
date: '2008-05-19T09:35:00.000-04:00'
description: ''
published: true
slug: 2008-05-surf-quietly-and-securely-at-work
categories:
- Technology
time_to_read: 5
title: Surf Quietly and Securely at Work
---

The internet is vital for my job. I search technical articles all the time and when my company's network filter blocks a site I am trying to get to, I get frustrated. I'm not abusing the network (usually), I'm just trying to do my job.

This is what I did to get around it.

I have a Linux box running at home (which happens to run this website). Here's how this works from a high level:

<ol>

	<li>Setup a server at home to accept SSH connections (like secure telnet)</li>

	<li>I setup a proxy on my home server to accept connections only from local addresses (not from the internet)</li>

	<li>I configure my laptop to connect to my home computer over SSH (a secure connection)</li>

	<li>I configure my laptop's browser to use a localhost proxy on some random, high port (like 31234)</li>

	<li>I bridge my laptop and my home network via an SSH tunnel so that connections to 127.0.0.1:31234 on my laptop are handled by my home server at 127.0.0.1:31234 (the proxy)</li>

</ol>


![ssh-tunnel.png](ssh-tunnel.png)That's a lot of information, I know. Each of these steps is pretty easy if handled one at a time. Here's how it's done. This was performed with a [Gentoo-Linux](http://www.gentoo.org/main/en/about.xml) machine at home acting as the server and proxy and a Windows XP machine at work acting as a client.

**Setup a server at home to accept SSH connections**

This is outside the scope of this doc. If you have a Linux machine, you probably have SSH running, too. In fact, I have never seen a Linux install without SSH setup out of the box.

**Setup the network router at home to port-forward the SSH connections from the internet**

Once you are able to connect to your Linux machine from inside your network, you will need to open up a port on your router/firewall so you can access it from outside your network. This is vendor specific so you're on your own there.



**I setup a proxy on my home server to accept connections only from local addresses (not from the internet)**

I used TinyProxy as my proxy software because it is lightweight and easy to configure. Since I'm running Gentoo, this is as easy as:

<ul>

	<li>emerge -vat tinyproxy</li>

</ul>

The configuration file is pretty self explanatory so dig in and read the man pages. Don't forget to add it to the start up services with rc-update!

**Configure browser to use local port for proxy**

This part's a piece of cake so long as you keep the referencing straight. Since SSH will be bridging a "localhost" port on my laptop to a "localhost" port on my server, it's all just localhost. I *do not *configure the proxy with any server-specific addresses.



 ![proxy.png](proxy.png)**Configure SSH client's tunnel **

Now that the server and client are configured, all we need to do is bridge them together. Inside Putty, create a tunnel like so:



![putty-cfg.png](putty-cfg.png)**Benefits, Issues and Alternatives **

This works well but won't be a walk in the park to configure if you're new to networking or Linux--I skipped a lot of steps. There are also some speed issues as this is routing in/out of my home broadband connection which isn't very fast and in the cases of others, might be firewalled at the ISP level.

There are many other options out there including the use of an existing proxy or using simpler page retrieval techniques. For example, a friend did something similar by creating a webpage that would serve back whatever url you included in the query string.

Perhaps the easiest in-a-pinch technique is to VNC to the server and run a browser from there.

When evaluating alternatives, don't overlook the benefit of the SSH tunnel, though. This provided a secure connection over the web to my house and enabled me to move bits without punching new holes into my firewall at home or exposing my traffic to inspection at the office.

One final note: if you are looking to do something particularly nefarious or sensitive, this isn't by any means a solution you should consider. This solves a small set of simple problems. If you have more than casual needs for security or anonymity you better ask someone who knows what they're talking about.