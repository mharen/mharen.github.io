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

<p>I wanted to spruce up my laptop for the season. I couldn’t find any reasonably priced USB-powered lights, but I did stumble upon some spiffy battery powered LED Christmas lights for $3 at Walmart. They included a 3-AA battery pack which means they use about 4.5v. USB is about 5v so that’s probably close enough for a direct substitute.</p>
<p>Here’s how I did it. Before ripping things apart, I jumped my USB-powered breadboard into the unit to make sure it’d work. </p>
<p><img alt="2012-11-16 21.50.00" height="525" src="http://lh3.ggpht.com/-PUWtZ_G9k2s/UKcZdlq9eOI/AAAAAAAAFR4/iex8hO0-pRw/2012-11-16%25252021.50.00%25255B4%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 21.50.00" width="700" /></p>
<p>It does. Alright, let’s pop this thing open:</p>
<p><img alt="2012-11-16 21.52.28" height="485" src="http://lh4.ggpht.com/-lY1VKrjoDFE/UKcZfD-UCnI/AAAAAAAAFSA/CE12iTT8lQ4/2012-11-16%25252021.52.28%25255B10%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 21.52.28" width="700" /></p>
<p>It looks like the battery compartment takes up almost all the space. That’s good for us. The switch supports blinking and fading so I’m going to keep it. I also checked it’s output voltage and discovered that it’s stepped down to about 3v:</p>
<p><img alt="2012-11-16 21.58.29" height="698" src="http://lh3.ggpht.com/-HCddfoQ_4s0/UKcZf4cwGYI/AAAAAAAAFSI/BF2VNlNVIj0/2012-11-16%25252021.58.29%25255B7%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 21.58.29" width="700" /></p>
<p>So instead of doing any circuit work, I’ll just keep the circuit it came with. Now I just need to tie it into the USB port. I hacked up an old USB cable:</p>
<p>&#160;</p>
<p><img alt="2012-11-16 22.03.57" height="700" src="http://lh6.ggpht.com/-eP0xO8Oa11k/UKcZhZVRqvI/AAAAAAAAFSQ/KMLFA9g_lVY/2012-11-16%25252022.03.57%25255B7%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 22.03.57" width="495" /></p>
<p>This would be a good time to look up common color codes or whatever to identify the power lines. Nah, let’s just guess. Red and black? Matches my multi-tester…</p>
<p><img alt="2012-11-16 22.05.41" height="700" src="http://lh5.ggpht.com/-pIZde1i3Hbk/UKcZirSH2eI/AAAAAAAAFSY/EhhBNH92Lkc/2012-11-16%25252022.05.41%25255B7%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 22.05.41" width="486" /></p>
<p>Yup. 5 volts. OK, let’s unsolder the the battery pack leads from the board:</p>
<p><img alt="2012-11-16 22.11.11" height="409" src="http://lh6.ggpht.com/-F8v5VDu2eUI/UKcZjQe5tYI/AAAAAAAAFSg/6RUV739smCQ/2012-11-16%25252022.11.11%25255B7%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 22.11.11" width="700" /></p>
<p>They’re labeled B- and B+. Handy.</p>
<p>It turns out I lopped the USB cable too short so I added some jumper wires between the plug and the board (don’t judge my ugly soldering…):</p>
<p><img alt="2012-11-16 22.15.59" height="353" src="http://lh6.ggpht.com/-DwVBhE3mGkQ/UKcZkfI9rzI/AAAAAAAAFSo/6SMVo0J20xA/2012-11-16%25252022.15.59%25255B12%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 22.15.59" width="700" /></p>
<p>Don’t forget to add the shrink tubing before this next part. (Not pictured: I wrapped both wires in a larger tube, all the way up to the stress relief nub on the plug, too.)</p>
<p><img alt="2012-11-16 22.26.58" height="483" src="http://lh3.ggpht.com/-dD_e0pSvXH0/UKcZlA0XAYI/AAAAAAAAFSw/6OsGuZSkqhU/2012-11-16%25252022.26.58%25255B19%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 22.26.58" width="700" /></p>
<p>Solder the leads to the board and trim:</p>  <p align="center"><img alt="2012-11-16 22.19.56" height="300" src="http://lh5.ggpht.com/-PtcjMO516lA/UKcZmMH9CGI/AAAAAAAAFS4/SkP1aJ-Cmv4/2012-11-16%25252022.19.56%25255B10%25255D.jpg" style="margin: 3px 0px; display: inline;" title="2012-11-16 22.19.56" width="300" /><img alt="2012-11-16 22.20.13" height="300" src="http://lh6.ggpht.com/-cbvy2n6aeqo/UKcZnphgeNI/AAAAAAAAFTA/53h2uHHJSPc/2012-11-16%25252022.20.13%25255B12%25255D.jpg" style="margin: 3px 0px; display: inline;" title="2012-11-16 22.20.13" width="300" /></p>
<p>Test them out and then figure out some way to attach them to your laptop:</p>
<p><img alt="2012-11-16 23.21.06" height="525" src="http://lh6.ggpht.com/-sxZpdQ5zuXI/UKcZpWa9FfI/AAAAAAAAFTI/Rd8N8ptSqrk/2012-11-16%25252023.21.06%25255B3%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 23.21.06" width="700" /></p>
<p><img alt="2012-11-16 23.21.27" height="525" src="http://lh3.ggpht.com/-DPNqQ0uSYtA/UKcZrTfCSSI/AAAAAAAAFTQ/FHKxLIxDR4s/2012-11-16%25252023.21.27%25255B3%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 23.21.27" width="700" /></p>
<p>I used some removable sticky-tack for the board (sorry for the poor photo), and tape everywhere else:</p>
<p><img alt="2012-11-16 23.21.14" height="525" src="http://lh4.ggpht.com/-fru5yWd6m2E/UKcZtS_DJeI/AAAAAAAAFTY/gMjPQmaU28U/2012-11-16%25252023.21.14%25255B3%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-16 23.21.14" width="700" /></p>
<p>I recommend something other than tape. It looks awful.</p>
<p><strong>UPDATE (17-Nov-12)!</strong> I couldn’t stand how terrible the tape looked so I tried something a little different today:</p>
<p><img alt="2012-11-17 11.43.15" height="525" src="http://lh5.ggpht.com/-LEKrGnSxpbM/UKf6xjE7THI/AAAAAAAAFTw/OeN3wEmStQA/2012-11-17%25252011.43.15%25255B3%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-17 11.43.15" width="700" /><img alt="2012-11-17 11.42.43" height="525" src="http://lh5.ggpht.com/-EmqKq3LRdQY/UKf6y0_WcJI/AAAAAAAAFT4/vrM5pN1w3nI/2012-11-17%25252011.42.43%25255B3%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-17 11.42.43" width="700" /><img alt="2012-11-17 11.42.26" height="525" src="http://lh4.ggpht.com/-oOAMIDnHWO0/UKf60V77QuI/AAAAAAAAFUA/031veDFcObQ/2012-11-17%25252011.42.26%25255B3%25255D.jpg" style="float: none; margin: 3px auto; display: block;" title="2012-11-17 11.42.26" width="700" /></p>
<p>That’s just a bunch of Duplo blocks with the lights wound around their nubs. I dabbed a little super glue on the end wraps to help hold the wires on. The entire block is held on with that blue sticky tack mounting putty. Time will tell if it will stay in place…</p>
<p>Merry Christmas :)</p>