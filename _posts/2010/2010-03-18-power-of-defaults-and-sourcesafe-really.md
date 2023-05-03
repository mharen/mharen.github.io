---
layout: post
date: '2010-03-18T00:19:00.001-04:00'
categories:
- technology
title: 'The Power of Defaults, and: SourceSafe Really is That Bad'
---

Think about the last gadget you bought—a computer, car, GPS, phone—whatever. Chance are that it came with a million settings, each preconfigured to *something*. Most of us change the simple stuff to suit us (e.g. a ring tone or wallpaper), and ignore the rest.

It’s the default settings of all the non-trivial things that we ignore that can be so powerful, and often terrible. Consider Microsoft Visual Source Safe. Visual Source Safe was a version control system that shipped with Visual Basic 6, and possibly a rev or two after that. Since everyone already had it, it was the obvious thing to turn to when small VB shops moved up to version control. 

Great for VSS. Terrible for humans. 

The trouble was that VSS is a terrible product. **It is Microsoft’s worst product, ever** (they [don’t](http://en.wikipedia.org/wiki/Microsoft_Visual_SourceSafe#Microsoft_in-house_use) even use it themselves). Here’s why:

**It actively fails where it matters most.** Version control systems have one mandate above all others—protect your data. If you put code in there, it should be really, really safe. It’s in the product name for crying out loud. Unfortunately, VSS doesn’t do this. Some examples...

**It has virtually no mechanism for taking backups**. If your database exceeds 2gb, the standard UI won’t work. It’s actually much worse than that—it’ll claim it worked, but actually produce corrupted backup. That’s evil.

Then, if you actually get a valid backup, **you won’t be able to restore it **because the restore mechanism won’t take it. I’m not even kidding. Google it.

**It becomes corrupted far too easily.** Every 30 days, it’ll suggest that you run a consistency checker to detect and fix problems. Unfortunately, the documentation warns that the consistency checker, while important, can also corrupt your databases. Say whaaaa? There other maintenance utilities are equally dangerous.

**It is hostile to developers**, the only ones that actually care about it. It supports multiple checkouts and merging so poorly that no sane team would use anything but exclusive checkouts (of course no sane team would use this product...). It’s so ridiculously slow to “get latest” on a tree of trivial size (minutes, not seconds) that this becomes a dreaded activity.

If I had to guess, I’d say that a bunch of interns cranked this thing out as a brute force, fun summer project called “let’s make a POS VCS.” They had no intention of shipping an obviously malicious product, and are just as shocked (ashamed?) as the rest of us when it was [sold to Microsoft](http://en.wikipedia.org/wiki/Microsoft_Visual_SourceSafe#History).

If you’re on VSS right now, there are other options. I personally use [SVN](http://subversion.tigris.org/) exclusively. If you have a savvy group, you might consider [Mercurial](http://mercurial.selenic.com/), too (distributed VCSs are all the rage right now). Those are both free, by the way.

For more VSS hate, check out these [crazy ads](http://vssisdead.com/) (part of a [series](http://www.ericsink.com/entries/why_so_serious.html)) or this [PSA](http://www.codinghorror.com/blog/2006/08/source-control-anything-but-sourcesafe.html).

Why am I ranting on this? Because someone was foolish enough to build a [ginormous product](http://www.ge-ip.com/products/2820) on top of VSS and that’s causing me all kinds of pain right now.