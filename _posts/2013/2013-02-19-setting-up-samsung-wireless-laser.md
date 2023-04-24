---
layout: post
date: '2013-02-19T21:20:00.001-05:00'
categories: technology
title: Setting up a Samsung Wireless Laser Printer with a Phone or Tablet (i.e. Without a Computer)
---

We have finally ditched our money pit inkjet printer in favor of a slightly more economical laser printer. We opted for a very cheap, but capable Samsung ML-2165W. It's monochrome, fast, and supports wireless connectivity. 

If you want builtin duplex or color be prepared to drop some extra coin.

Our goal was cheap, fast printing and laser printers seem to do the trick there with a much lower $/page cost than inkjet.

But enough about that. How do you get the damn thing setup? The instructions tell you to pop the CD into your computer and go to town. What if you don't have a CD-ROM drive? Or a computer? Luckily you can do it with just a web browser, though it's admittedly not the simplest process. Here's how I did it with my iPhone/iPad:

First, setup the printer and turn it on. Don't hook up the USB cable to anything.

Next, go get the Samsung print app for your phone or tablet. Do this before the next step because you need to be online to do it.

The printer will broadcast a WiFi network for ad-hoc printing. Connect to that with your phone or tablet--it'll be something like "PortThru". Just look for an open network with a good signal that looks like it was named by a corporation.

Once you're connected to the printer open the print app. We don't actually want to print anything yet (though you could!). Go through the motions like you *are* going to print something though, because we want to know the printer's IP address. This will show up when you go to select the printer.

Note the IP address and head over to your web browser. Enter the IP address in the address bar to get to the printer's management console.

Login with user "admin", password "sec00000". If that doesn't work, do a Google search for "default password <your printer model>" and try that.

Once you're logged in, go to the settings page and do the wireless setup. This will let you choose your WiFi network from a list. When complete, your printer (or at least its network) will reboot. Give it a minute.

Your phone or tablet will probably automatically reconnect to your usual WiFi network.

Launch that printer app again and go to print something else. This should allow you to choose your printer again, but this time with a normal network address (10.0.*.*, 192.168.*.*, etc.). This means that the printer is now on the network and available to everyone. Good job!

Now go kill some trees! 

![blogger-image-855070614.jpg](/assets/2013/blogger-image-855070614.jpg)

![blogger-image-519166345.jpg](/assets/2013/blogger-image-519166345.jpg)

---

### 1 comment

**Sarah said on 2013-02-19**

So only just now do I realize that you set this up without a computer.  Good work, babe! :)

I'm pretty sure I used about half of a ream of paper tonight ~ because I <3 the earth.

