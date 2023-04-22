---
date: '2012-11-16T23:59:00.001-05:00'
description: ''
published: true
slug: 2012-11-how-to-convert-battery-powered-led
tags:
- http://schemas.google.com/blogger/2008/kind#post
- NaBloPoMo 2012
- Technology
- legacy-blogger
time_to_read: 5
title: How to Convert Battery-Powered LED Christmas Lights to USB
---


I wanted to spruce up my laptop for the season. I couldn’t find any reasonably priced USB-powered lights, but I did stumble upon some spiffy battery powered LED Christmas lights for $3 at Walmart. They included a 3-AA battery pack which means they use about 4.5v. USB is about 5v so that’s probably close enough for a direct substitute.

Here’s how I did it. Before ripping things apart, I jumped my USB-powered breadboard into the unit to make sure it’d work. 

![2012-11-16%25252021.50.00%25255B4%25255D.jpg](2012-11-16%25252021.50.00%25255B4%25255D.jpg)

It does. Alright, let’s pop this thing open:

![2012-11-16%25252021.52.28%25255B10%25255D.jpg](2012-11-16%25252021.52.28%25255B10%25255D.jpg)

It looks like the battery compartment takes up almost all the space. That’s good for us. The switch supports blinking and fading so I’m going to keep it. I also checked it’s output voltage and discovered that it’s stepped down to about 3v:

![2012-11-16%25252021.58.29%25255B7%25255D.jpg](2012-11-16%25252021.58.29%25255B7%25255D.jpg)

So instead of doing any circuit work, I’ll just keep the circuit it came with. Now I just need to tie it into the USB port. I hacked up an old USB cable:

&#160;

![2012-11-16%25252022.03.57%25255B7%25255D.jpg](2012-11-16%25252022.03.57%25255B7%25255D.jpg)

This would be a good time to look up common color codes or whatever to identify the power lines. Nah, let’s just guess. Red and black? Matches my multi-tester…

![2012-11-16%25252022.05.41%25255B7%25255D.jpg](2012-11-16%25252022.05.41%25255B7%25255D.jpg)

Yup. 5 volts. OK, let’s unsolder the the battery pack leads from the board:

![2012-11-16%25252022.11.11%25255B7%25255D.jpg](2012-11-16%25252022.11.11%25255B7%25255D.jpg)

They’re labeled B- and B+. Handy.

It turns out I lopped the USB cable too short so I added some jumper wires between the plug and the board (don’t judge my ugly soldering…):

![2012-11-16%25252022.15.59%25255B12%25255D.jpg](2012-11-16%25252022.15.59%25255B12%25255D.jpg)

Don’t forget to add the shrink tubing before this next part. (Not pictured: I wrapped both wires in a larger tube, all the way up to the stress relief nub on the plug, too.)

![2012-11-16%25252022.26.58%25255B19%25255D.jpg](2012-11-16%25252022.26.58%25255B19%25255D.jpg)

Solder the leads to the board and trim:  

![2012-11-16%25252022.20.13%25255B12%25255D.jpg](2012-11-16%25252022.20.13%25255B12%25255D.jpg)

Test them out and then figure out some way to attach them to your laptop:

![2012-11-16%25252023.21.06%25255B3%25255D.jpg](2012-11-16%25252023.21.06%25255B3%25255D.jpg)

![2012-11-16%25252023.21.27%25255B3%25255D.jpg](2012-11-16%25252023.21.27%25255B3%25255D.jpg)

I used some removable sticky-tack for the board (sorry for the poor photo), and tape everywhere else:

![2012-11-16%25252023.21.14%25255B3%25255D.jpg](2012-11-16%25252023.21.14%25255B3%25255D.jpg)

I recommend something other than tape. It looks awful.

**UPDATE (17-Nov-12)!** I couldn’t stand how terrible the tape looked so I tried something a little different today:

![2012-11-17%25252011.42.26%25255B3%25255D.jpg](2012-11-17%25252011.42.26%25255B3%25255D.jpg)

That’s just a bunch of Duplo blocks with the lights wound around their nubs. I dabbed a little super glue on the end wraps to help hold the wires on. The entire block is held on with that blue sticky tack mounting putty. Time will tell if it will stay in place…

Merry Christmas :)