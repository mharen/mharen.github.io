---
layout: post
date: '2011-11-02T23:22:00.001-04:00'
categories:
- hardware
- windows
- nablopomo-2011
- technology
title: Moving A Hard Drive with Windows 7 to a New Machine
---

I just got a shiny new laptop (yay, thanks, Work!). In the old days (with Windows XP), I’d start fresh and clean on the new machine, slowly moving my old files over. That process would take a couple of days and I’d be back to full strength within a week. 

I think Windows 7 is the first Windows OS that ages nicely enough that I don’t have to start from scratch every few years. So instead of spending 18 hours installing stuff, I physically moved my hard drive from my old machine to my new one. Here’s how:

[![transfer.png]({{ "/assets/2011/transfer.png" | relative_url }})](http://www.sevenforums.com/tutorials/135077-windows-7-installation-transfer-new-computer.html)

**Yes,** I really moved my drive from one machine to another *without reinstalling anything* (except drivers). And you can, too! **Don’t** listen to the naysayers (but do make backups just in case).

I followed “Method One” in [that guide](http://www.sevenforums.com/tutorials/135077-windows-7-installation-transfer-new-computer.html) which basically does the following:  

1. Backup your system (seriously!)
2. Prepare your drive to be moved (sysprep)
3. Move or duplicate your drive to your new machine
4. Boot up and do some configuration
5. Install all your drivers

The process took a couple of hours but was totally worth it when compared to starting from scratch. A few tips that might not be in the guide:     
* You will lose activations of Office, Windows, iTunes, and pretty much any tool that cares about your hardware. Plan accordingly     
* You will lose pretty much all Windows-specific settings like WIFI connections     
* Most user-specific stuff stays put (all your files, application settings, etc.), but oddly enough you lose your taskbar customizations. Take a screenshot of those if you are fond of them 
* Download the drivers for your new machine in advance. If you do nothing else, at least get the drivers for your network card. I luckily had the foresight to do this :)  


I’m happy to report that I’m typing this post on my awesomely fast new laptop and all the above actually worked better than I expected :). 

On a related note, I don’t understand why hardly anyone shares their WEI numbers. Here are my before/after numbers (Dell Latitude D520 vs. E6520) in case anyone is curious:

![d520 wei.png]({{ "/assets/2011/d520 wei.png" | relative_url }})

![e6520 wei.png]({{ "/assets/2011/e6520 wei.png" | relative_url }})

And side-by-side:

![side-by-side.png]({{ "/assets/2011/side-by-side.png" | relative_url }})

I’ll be getting a memory upgrade in a week or so (on order) but I don’t expect that to have much affect on these numbers. I will, however, finally reap some x64 benefits...