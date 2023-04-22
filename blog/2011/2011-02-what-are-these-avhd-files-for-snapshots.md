---
date: '2011-02-16T19:27:00.001-05:00'
description: ''
published: true
slug: 2011-02-what-are-these-avhd-files-for-snapshots
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Technology
- legacy-blogger
time_to_read: 5
title: 'Hyper-V: What are these *.avhd files for? Snapshots? But I have no snapshots!'
---

<p>(<strong>Note:</strong> <a href="http://www.urbandictionary.com/define.php?term=tl;dr">TL;DR</a> is at the <a href="#tldr">bottom</a> in bold.)</p>
<p>Virtual machines are crazy awesome. One of my favorite features is that you can snapshot a VM at any point and then later roll back the machine to its exact state at that point. The way this is implemented in Hyper-V is with a differencing disk. That is, the VM uses the normal virtual hard drive that you’re probably familiar with—a giant VHD file which represents the VMs disk—and adds another disk on top of that to record any changes to it without affecting the original VHD directly. </p>
<p>My machine has one VHD and two AVHDs from snapshots:</p>
<p><img alt="files" height="165" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TVxrTMGS6oI/AAAAAAAABbw/Jg1h9UZ6Yr8/files%5B2%5D.png" style="margin: 3px; display: inline;" title="files" width="720" /></p>
<p>Think of this like layers of transparencies—<a href="http://en.wikipedia.org/wiki/Transparency_(projection)">remember those</a>, kids? The first plastic sheet represents the base VHD. When you take a snapshot, it’s like laying a clean sheet overtop of the existing sheet—all your changes are recorded on the new sheet. In Hyper-V, these extra sheets are AVHDs. Additional snapshots do the same thing—more sheets, more differencing disk AVHDs. To rollback to a given snapshot, you just peel off a sheet. Are hopefully more (but possibly less) clearly: </p>
<p><a href="http://lh4.ggpht.com/_IKD9WtY5kxU/TVxrTTaStBI/AAAAAAAABb0/gSnPHgzZdLo/s1600-h/mockup%5B4%5D.png"><img alt="mockup" height="450" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TVxrUaxBoJI/AAAAAAAABb4/Lm6qR6QZ9Zg/mockup_thumb.png" style="margin: 3px auto; display: block; float: none;" title="mockup" width="431" /></a></p>
<p><a name="tldr">All that background should help explain why you will find ever-increasing AVHD files on your system if you play around with snapshots. <strong>But why might you find AVHDs if you no longer have any snapshots?</strong></a>  
<p><strong><img alt="no-snaps" height="65" src="http://lh4.ggpht.com/_IKD9WtY5kxU/TVxrUlo9JHI/AAAAAAAABb8/xDWaTNO5I1Q/no-snaps%5B2%5D.png" style="margin: 3px auto; display: block; float: none;" title="no-snaps" width="573" /></strong></p>  
<p>Consider what you’re asking Hyper-V to do when you remove a snapshot (as opposed to rolling back to it). Since all the changes since the snapshot are literally in a separate file, it must merge the AVHD into the VHD. </p>  
<p><strong><img align="right" alt="shutdown" height="21" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TVxrU6Lp6PI/AAAAAAAABcA/iWzCNFOs9zM/shutdown%5B2%5D.png" style="margin: 3px; display: inline; float: right;" title="shutdown" width="98" />And here’s the rub: Hyper-V will only do a merge when the machine is <em>shutdown or turned off </em></strong>(pausing it isn’t enough). This explains why I found a couple of AVHDs from months ago even though I didn’t have any snapshots—the machine simply hasn’t been completely shutdown in…years (reboots don’t count—Hyper-V won’t merge unless the VM is really off).</p>  
<p>If your AVHD is big, this will take a long, long time. Fortunately, cleaning up the AVHD files should improve the VM’s disk performance and save the host machine some disk space (50% in my case).</p>   <img alt="merging" height="228" src="http://lh4.ggpht.com/_IKD9WtY5kxU/TVxrVY1uZ1I/AAAAAAAABcE/QNG2ncjVR3o/merging%5B2%5D.png" style="margin: 3px auto; display: block; float: none;" title="merging" width="478" />

---

## 1 comments captured from [original post](https://blog.wassupy.com/2011/02/what-are-these-avhd-files-for-snapshots.html) on Blogger

**Math Zombie said on 2011-02-16**

surprisingly with the advance of technology, transparencies and projectors are still very prevalent.

