---
layout: post
date: '2012-11-16T23:59:00.001-05:00'
categories:
- nablopomo-2012
- technology
title: How to Convert Battery-Powered LED Christmas Lights to USB
---

I wanted to spruce up my laptop for the season. I couldn’t find any reasonably priced USB-powered lights, but I did stumble upon some spiffy battery powered LED Christmas lights for $3 at Walmart. They included a 3-AA battery pack which means they use about 4.5v. USB is about 5v so that’s probably close enough for a direct substitute.

Here’s how I did it. Before ripping things apart, I jumped my USB-powered breadboard into the unit to make sure it’d work. 

![](/assets/2012/2012-11-16_21.50.00.jpg)

It does. Alright, let’s pop this thing open:

![](/assets/2012/2012-11-16_21.52.28.jpg)

It looks like the battery compartment takes up almost all the space. That’s good for us. The switch supports blinking and fading so I’m going to keep it. I also checked it’s output voltage and discovered that it’s stepped down to about 3v:

![](/assets/2012/2012-11-16_21.58.29.jpg)

So instead of doing any circuit work, I’ll just keep the circuit it came with. Now I just need to tie it into the USB port. I hacked up an old USB cable:

![](/assets/2012/2012-11-16_22.03.57.jpg)

This would be a good time to look up common color codes or whatever to identify the power lines. Nah, let’s just guess. Red and black? Matches my multi-tester...

![](/assets/2012/2012-11-16_22.05.41.jpg)

Yup. 5 volts. OK, let’s unsolder the the battery pack leads from the board:

![](/assets/2012/2012-11-16_22.11.11.jpg)

They’re labeled B- and B+. Handy.

It turns out I lopped the USB cable too short so I added some jumper wires between the plug and the board (don’t judge my ugly soldering...):

![](/assets/2012/2012-11-16_22.15.59.jpg)

Don’t forget to add the shrink tubing before this next part. (Not pictured: I wrapped both wires in a larger tube, all the way up to the stress relief nub on the plug, too.)

![](/assets/2012/2012-11-16_22.26.58.jpg)

Solder the leads to the board and trim:  

![](/assets/2012/2012-11-16_22.20.13.jpg)

Test them out and then figure out some way to attach them to your laptop:

![](/assets/2012/2012-11-16_23.21.06.jpg)

![](/assets/2012/2012-11-16_23.21.27.jpg)

I used some removable sticky-tack for the board (sorry for the poor photo), and tape everywhere else:

![](/assets/2012/2012-11-16_23.21.14.jpg)

I recommend something other than tape. It looks awful.

**UPDATE (17-Nov-12)!** I couldn’t stand how terrible the tape looked so I tried something a little different today:

![](/assets/2012/2012-11-17_11.42.26.jpg)

That’s just a bunch of Duplo blocks with the lights wound around their nubs. I dabbed a little super glue on the end wraps to help hold the wires on. The entire block is held on with that blue sticky tack mounting putty. Time will tell if it will stay in place...

Merry Christmas :)