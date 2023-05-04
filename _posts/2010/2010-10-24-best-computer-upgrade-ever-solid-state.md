---
layout: post
date: '2010-10-24T00:37:00.001-04:00'
categories: technology
title: 'The Best Computer Upgrade Ever: Solid State Disk'
---

Last Fall I upgraded my laptop’s hard drive to an Intel X25-M G2 solid state hard drive. Now about a year later, it is the single best upgrade I have ever made.

At the time I had the choice between a brand new laptop or an SSD (SSDs were much more expensive at the time) and I definitely made the right decision. In fact, if I was offered a new laptop *today*, I wouldn’t take it unless I could take my SSD with me.

Why is this thing so awesome? It has no moving parts like it’s rotating platter, savage ancestors of days old. As a result, it’s ridiculously fast. Here is my simple benchmark (check Google for dozens of much more rigorous, helpful benchmarks). 

This is a random read of various file sizes before the SSD upgrade:

![]({{ "/assets/2010/before-1-5.png" | relative_url }})

Getting about 50 IOPS, 20ms, and awful MB/s. And after the SSD upgrade:

![]({{ "/assets/2010/ssd-rand-3.png" | relative_url }})

These are on the very same system. The before shot was made an hour before I cloned it onto the new SSD. Here’s a simple summary between the two:

| | More Ops | Less Time | More MB/s |
|-|----------|-----------|-----------|
| 512b | 17228% | -99% | 17125% |
| 4kb | 12556% | -99% | 12482% |
| 64kb | 3149% | -97% | 3126% |
| 1mb | 457% | -82% | 449% |
| random | 660% | -86% | 638% |

Yes, that’s a 17 thousand percent improvement in reading 512b blocks with a corresponding 99% reduction in access time. Even in the SSD’s worst case of large files, which traditional disks tend to do well with, the improvements are 400%-500%.

Just for kicks, I repeated the test again today (1 year later) and got similar (if just slightly degraded) results:

![]({{ "/assets/2010/ssd-4.png" | relative_url }})

**In summary, I went from crappy {iops, mb/s, ms} to *zomg!* {iops, mb/s, ms}.**

Interested? The good news for you is that these puppies are faster and even more affordable today. Shop around and check the latest benchmarks to see what models are the best (this info changes so often that I’m not linking to anything specific).

If you want a *much cheaper* shot in the arm, a memory upgrade for those with less than 2gb already is a sure fire way to boost performance (we’re talking less than $30-50).