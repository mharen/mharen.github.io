---
layout: post
date: '2010-10-24T22:35:00.001-04:00'
categories:
- windows
- technology
title: Some Thoughts on Antivirus and Why I Now Use It
---

In my experience, antivirus software has been a near-total waste of time and resources for most people, especially in IT. I have two major issues with it:

1. It doesn’t work well
2. It spreads FUD

When I’ve seen it detect malware, it often couldn’t do anything about it, and most of the time it’s just nagging users with false positives or completely inappropriately technical messages. 

[![network]({{ "/assets/2010/network-6.png" | relative_url }} "Viruses so far have been really disappointing on the 'disable the internet' front, and time is running out. When Linux/Mac win in a decade or so the game will be over.")](https://xkcd.com/350/)

Although, it used to be very important. There once was a time where our poor Windows machines were basically teeming cesspools of digital disease with virtually no defenses. These things needed help. It’s laughable to recall that Windows XP pre SP2 and [recent versions](http://news.cnet.com/8301-10784_3-9807471-7.html) of OS X didn’t even have a firewall enabled by default.

You’d be in better shape if you had a hardware router since it probably acted as a firewall, too, but those without and most dialup users would be very vulnerable while online.

But today, we have automatic updates, multiple firewalls, and better security all around. With the infrastructure improvements, the attack surface for most people narrowed considerably. That is, your computer could contract a virus through the following means:  

1. Physical access (e.g. infected USB stick)  
2. Network access  
3. Web browser  
4. Downloading crap off the Internet  
5. Opening random email attachments

Vector one, physical access, is pretty easy to neutralize by refusing to share thumb drives. 

Vector two, network access, is pretty well handled by using the built in firewall that is enabled by default on most systems. This itself has done wonders to stunt the spread of viruses on large corporate networks.

Vector three, the web browser, is mostly mitigated by using a decent browser (i.e. not Internet Explorer 6 or 7).

Vectors 4 and 5 are the big ones. These directly involve humans and as such are hard to control. If you download junk from random websites, you’re just asking for it. Instead, you should download only things that don’t seem scammy (e.g. not computer speedup tools, illegally sourced software, or money making schemes) from sites that you trust. Similarly, if someone sends you something suspicious (e.g. “chek out dis pic.scr”), hit delete! If a colleague sends you something out of the blue, ask for confirmation that they actually sent you something before opening it to make sure *they *sent it.

So that’s how I operated without antivirus software for the last 10 years or so. I used a firewall, a decent browser, and I didn’t open random crap. I didn’t use antivirus. I didn’t get viruses (I checked occasionally).

Then I saw [this PSA](http://twitter.com/#!/codinghorror/status/27956379656):

![]({{ "/assets/2010/antivirus-2.png" | relative_url }})

It seems that drive-by attacks are occurring with no user error necessary *in up-to-date Google Chrome*, via a vulnerable Java plugin. I checked *my laptop *with Microsoft’s free, [well-rated](http://www.techsupportalert.com/best-free-anti-virus-software.htm#Quick_Selection_Guide) virus scanner [Security Essentials](http://www.microsoft.com/security_essentials/) and found that **I was infected. **I became infected via my browser (really a plugin, but that’s splitting hairs) and that left me a little shaken. Fortunately, the scanner politely cleaned up the infection without making a big fuss, which is both more effective and less braggy than I remember of other scanners.

![]({{ "/assets/2010/antivirus-3.jpg" | relative_url }})

I also followed the advice of the above tweet (disabled the rarely used Java plugin), and now I run the free virus scanner regularly. This is really a change in direction for me, and not a turn I’ve taken lightly. And while AV tools will rarely protect us from emerging threats, they *do *detect thousands of old viruses pretty reliably. The ease of use of Security Essentials and it’s non-FUDiness certainly helped me change my mind.

In conclusion, I am now updating my antivirus position by recommending that all Windows users (not just casual users as I previously recommended) run a free antivirus program like the Microsoft option I mentioned above.

---

### 1 comment

**Unknown said on 2010-10-24**

Sophos claims 0-day on threats.  When I went dual core is when I finally started running full time A.V.  I've been hit by "drive-bys" as you put it a few times in the last year on both firefox and chrome.  I used to slum around the internet pre-2000 and never had an issue.  These days even legit sites get hit.  I've experimented with running in-line virus detection on my router, but it struggles with streaming media, which is my biggest use.
