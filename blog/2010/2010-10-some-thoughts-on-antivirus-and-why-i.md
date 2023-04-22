---
date: '2010-10-24T22:35:00.001-04:00'
description: ''
published: true
slug: 2010-10-some-thoughts-on-antivirus-and-why-i
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Windows
- Technology
- legacy-blogger
time_to_read: 5
title: Some Thoughts on Antivirus and Why I Now Use It
---

<p>In my experience, antivirus software has been a near-total waste of time and resources for most people, especially in IT. I have two major issues with it:</p>  <ol>   <li>It doesn’t work well </li>    <li>It spreads FUD </li> </ol>
<p>When I’ve seen it detect malware, it often couldn’t do anything about it, and most of the time it’s just nagging users with false positives or completely inappropriately technical messages. </p>
<p><a href="http://xkcd.com/350/">![Mac win in a decade or so the game will be over.](Mac win in a decade or so the game will be over.)</a></p>
<p>Although, it used to be very important. There once was a time where our poor Windows machines were basically teeming cesspools of digital disease with virtually no defenses. These things needed help. It’s laughable to recall that Windows XP pre SP2 and <a href="http://news.cnet.com/8301-10784_3-9807471-7.html">recent versions</a> of OS X didn’t even have a firewall enabled by default.</p>
<p>You’d be in better shape if you had a hardware router since it probably acted as a firewall, too, but those without and most dialup users would be very vulnerable while online.</p>
<p>But today, we have automatic updates, multiple firewalls, and better security all around. With the infrastructure improvements, the attack surface for most people narrowed considerably. That is, your computer could contract a virus through the following means:</p>  <ol>   <li>Physical access (e.g. infected USB stick)</li>    <li>Network access</li>    <li>Web browser</li>    <li>Downloading crap off the Internet</li>    <li>Opening random email attachments</li> </ol>
<p>Vector one, physical access, is pretty easy to neutralize by refusing to share thumb drives. </p>
<p>Vector two, network access, is pretty well handled by using the built in firewall that is enabled by default on most systems. This itself has done wonders to stunt the spread of viruses on large corporate networks.</p>
<p>Vector three, the web browser, is mostly mitigated by using a decent browser (i.e. not Internet Explorer 6 or 7).</p>
<p>Vectors 4 and 5 are the big ones. These directly involve humans and as such are hard to control. If you download junk from random websites, you’re just asking for it. Instead, you should download only things that don’t seem scammy (e.g. not computer speedup tools, illegally sourced software, or money making schemes) from sites that you trust. Similarly, if someone sends you something suspicious (e.g. “chek out dis pic.scr”), hit delete! If a colleague sends you something out of the blue, ask for confirmation that they actually sent you something before opening it to make sure <em>they </em>sent it.</p>
<p>So that’s how I operated without antivirus software for the last 10 years or so. I used a firewall, a decent browser, and I didn’t open random crap. I didn’t use antivirus. I didn’t get viruses (I checked occasionally).</p>
<p>Then I saw <a href="http://twitter.com/#!/codinghorror/status/27956379656">this PSA</a>:</p>
<p>![image%5B2%5D.png](image%5B2%5D.png)</p>
<p>It seems that drive-by attacks are occurring with no user error necessary <em>in up-to-date Google Chrome</em>, via a vulnerable Java plugin. I checked <em>my laptop </em>with Microsoft’s free, <a href="http://www.techsupportalert.com/best-free-anti-virus-software.htm#Quick_Selection_Guide">well-rated</a> virus scanner <a href="http://www.microsoft.com/security_essentials/">Security Essentials</a> and found that <strong>I was infected. </strong>I became infected via my browser (really a plugin, but that’s splitting hairs) and that left me a little shaken. Fortunately, the scanner politely cleaned up the infection without making a big fuss, which is both more effective and less braggy than I remember of other scanners.</p>
<p>![virus%5B2%5D.jpg](virus%5B2%5D.jpg)I also followed the advice of the above tweet (disabled the rarely used Java plugin), and now I run the free virus scanner regularly. This is really a change in direction for me, and not a turn I’ve taken lightly. And while AV tools will rarely protect us from emerging threats, they <em>do </em>detect thousands of old viruses pretty reliably. The ease of use of Security Essentials and it’s non-FUDiness certainly helped me change my mind.</p>
<p>In conclusion, I am now updating my antivirus position by recommending that all Windows users (not just casual users as I previously recommended) run a free antivirus program like the Microsoft option I mentioned above.</p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2010/10/some-thoughts-on-antivirus-and-why-i.html) on Blogger

**Unknown said on 2010-10-24**

Sophos claims 0-day on threats.  When I went dual core is when I finally started running full time A.V.  I've been hit by &quot;drive-bys&quot; as you put it a few times in the last year on both firefox and chrome.  I used to slum around the internet pre-2000 and never had an issue.  These days even legit sites get hit.  I've experimented with running in-line virus detection on my router, but it struggles with streaming media, which is my biggest use.

