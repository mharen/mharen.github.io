---
layout: post
date: '2009-08-11T22:59:00.001-04:00'
categories:
- windows
- technology
title: First Look at Windows 7
---

When Windows 7 hit MSDN late last week, I took the plunge...and I’m loving it.

![]({{ "/assets/2009/windows-1.png" | relative_url }}) 

I’m not one to participate in the religious wars that operating systems seem to cultivate—I have three machines, each perfectly suited to its task: a Windows machine, a Mac, and a Linux box. I’d say I’m pretty well rounded. Interestingly, I have almost zero experience with Vista. I’ve used Server 2008 a bit and liked it but for many reasons was stuck on XP until just recently.

I don’t really believe the anti-hype that Vista is awful just like I don’t think MS is evil or Google is taking over the world (...or are they?). Instead, I think MS is just a popular company to hate, which is something Google has been extremely careful to avoid so far.

Anyway, back to Windows 7. It’s awesome. Compared to XP, it is elegant, quick and intuitive. They might have gone overboard just a bit with the transparency or dialog animation but I am thrilled. So much so that I think I worried Sarah a little when I raved about how much I liked it upon installation.

First some good things. The defaults seem to be much better this time around. I have found myself changing very little in the control panel. On my modest 1.6ghz dual-core laptop, it’s very snappy. The new Explorer is very nice to work with and actually provides helpful information as you go in the form of action buttons directly underneath the address bar:

![]({{ "/assets/2009/windows-2.png" | relative_url }}) 

Some of my apps are incompatible with either W7 or X64 but Microsoft has me covered with [Windows 7 XP Mode](http://www.microsoft.com/windows/virtual-pc/get-started.aspx). XP Mode is basically an entire install of XP virtualized to run within your current Windows 7 session. They do some nice tricks to make things blend in with W7 but it’s really just an app running in a VM. I used this for the Cisco VPN Client (which doesn’t support x64) and a weird corporate app. Once you install them inside the XP VM, they show up on your Windows 7 Start menu like so:

![]({{ "/assets/2009/windows-3.png" | relative_url }}) 

And then when you launch the app, it looks like a normal XP program (overtop a regular Windows 7 program for comparison):

![]({{ "/assets/2009/windows-4.png" | relative_url }})

It’s a little slow and perhaps overkill for some small incompatibilities but it is extremely effective and was a major selling point for me.

It’s not all shine, though. I have a few gripes—some big, some small. First, I regret going to x64. I thought at the time that x64 would allow me to use all of my 4gb of memory. This appears to be false as my computer’s hardware [seems to be limited](http://superuser.com/questions/20299/why-cant-windows-7-x64-use-all-installed-memory) to 3.25gb, regardless of OS. I get all the hassle of x64 with only minor benefits. Very lame. 

Next, my touchpad scroll area doesn’t work. I screwed around with all the Vista x64 drivers I could find but haven’t had any luck getting it to work. Driver issues like this were old hat back in Windows 98/XP days so I guess I should consider myself thrilled that I didn’t have to install a single driver to get sound, video, wireless, etc. So, no scrolling from the touch pad from an OS that’s not officially been launched yet? Not a big deal, it’s just annoying. 

Third, some development tools require some extra effort or have reduced functionality. For example, Visual Studio 2005 reminds me each time it runs that it’ll run better if I run it as an administrator. Further, VS2008 informed me that it’s not too keen on [Edit&Continue](http://social.msdn.microsoft.com/Forums/en-US/vside2008/thread/fa7b70cc-af72-4449-b44c-5ae1eb0a64bd) since I’m running x64. 

Finally, I wish there had been a reasonable in-place upgrade option from Windows XP. Back in high school, we used to format our machines every month or two—that’s what was required to keep Windows 98 running with all the crap we were putting it through. XP was pretty solid, though, when used primarily for work stuff so I haven’t done a clean format in *years*. But to get to Windows 7, I would have had to first go to Vista. Doing two major upgrades seemed worse than doing one clean format. The format/install was painless and I imaged my system first which made me confident I wouldn’t lose anything. Still, reinstalling every damn piece of software and copying over settings to obscure locations is tiresome.

Far and away, I’m loving Windows 7 and don’t regret the move at all. I just might do x86 if I had a do-over (though I might yet reap the benefits of x64 when I get a laptop upgrade in a year or two).