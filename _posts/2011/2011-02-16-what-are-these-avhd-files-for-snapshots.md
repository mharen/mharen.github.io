---
layout: post
date: '2011-02-16T19:27:00.001-05:00'
categories: technology
title: 'Hyper-V: What are these *.avhd files for? Snapshots? But I have no snapshots!'
---


(**Note:** [TL;DR](http://www.urbandictionary.com/define.php?term=tl;dr) is at the [bottom](#tldr) in bold.)

Virtual machines are crazy awesome. One of my favorite features is that you can snapshot a VM at any point and then later roll back the machine to its exact state at that point. The way this is implemented in Hyper-V is with a differencing disk. That is, the VM uses the normal virtual hard drive that you’re probably familiar with—a giant VHD file which represents the VMs disk—and adds another disk on top of that to record any changes to it without affecting the original VHD directly. 

My machine has one VHD and two AVHDs from snapshots:

![files[2].png](/assets/2011/files[2].png)

Think of this like layers of transparencies—[remember those](http://en.wikipedia.org/wiki/Transparency_(projection)), kids? The first plastic sheet represents the base VHD. When you take a snapshot, it’s like laying a clean sheet overtop of the existing sheet—all your changes are recorded on the new sheet. In Hyper-V, these extra sheets are AVHDs. Additional snapshots do the same thing—more sheets, more differencing disk AVHDs. To rollback to a given snapshot, you just peel off a sheet. Are hopefully more (but possibly less) clearly: 

![mockup[4].png](/assets/2011/mockup[4].png)</a>

<a name="tldr">All that background should help explain why you will find ever-increasing AVHD files on your system if you play around with snapshots.</a> **But why might you find AVHDs if you no longer have any snapshots?**</a>  

**![no-snaps[2].png](/assets/2011/no-snaps[2].png)**  

Consider what you’re asking Hyper-V to do when you remove a snapshot (as opposed to rolling back to it). Since all the changes since the snapshot are literally in a separate file, it must merge the AVHD into the VHD.   

**![shutdown[2].png](/assets/2011/shutdown[2].png)And here’s the rub: Hyper-V will only do a merge when the machine is *shutdown or turned off ***(pausing it isn’t enough). This explains why I found a couple of AVHDs from months ago even though I didn’t have any snapshots—the machine simply hasn’t been completely shutdown in…years (reboots don’t count—Hyper-V won’t merge unless the VM is really off).  

If your AVHD is big, this will take a long, long time. Fortunately, cleaning up the AVHD files should improve the VM’s disk performance and save the host machine some disk space (50% in my case).   ![merging[2].png](/assets/2011/merging[2].png)

---

### 1 comment

**Math Zombie said on 2011-02-16**

surprisingly with the advance of technology, transparencies and projectors are still very prevalent.

