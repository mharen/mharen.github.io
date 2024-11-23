---
layout: post
date: '2012-12-03T22:41:00.001-05:00'
categories:
- iOS
- technology
- iPhone
title: How Much Of that Sweet, Sweet Data Does Pandora Use on Your Phone?
---

**Answer: about 30 MiB/hour.**

I’ve been looking to upgrade to one of those shiny 4g phones. In doing so I’ll lose my unlimited data plan. Is that a problem? Maybe.

Verizon has a [pretty neat calculator](http://www.verizonwireless.com/b2c/splash/datacalculatorPopup.jsp) (I was surprised!) that gives you a rough idea of how much data you might you. The gist is that anything other than video/audio requires very little data.

That is: lots of email, browsing, and navigation requires well under a gigabyte a month. They helpfully indicate what numbers they’re using for these figures:

| Activity                                     | Data      |
|----------------------------------------------|-----------|
| Email (text only)                            | 10 KB     |
| Web Access (internet and Intranet)           | 400 KB    |
| Audio Streaming                              | 60 MB/hr  |
| Audio Track Download (3 1/2 min at 192 kbps) | 7 MB      |
| 3G Video Streaming                           | 250 MB/hr |
| 3G Verizon Video & NFL Mobile Streaming      | 125 MB/hr |
| 4G Video Streaming                           | 350 MB/hr |
| Digital Photo download/upload (Hi-Res)       | 3 MB      |
| Navigation Turn by Turn Directions           | 5 MB/hr   |

So adding 2 hours of streaming a day blows up the data big time:

Ouch. Let’s hope you don’t want to watch a 30 minute video every day...

**But are these numbers accurate?** They are estimates, certainly, so I can only compare against my usage, which isn’t really fair, but it’s all I have.

I watch Hulu and listen to Pandora over the cellular network so let’s check those. I’m using my phone’s metering to record this. Here’s Pandora at `t = { 5m, 10m, 11m }`. (Of course letting this run for an hour would be better.). I didn’t use the phone for anything else during this test.  

That is:  

* +3.5 MB after 5 minutes
* +2.5 MB after 5 more minutes
* +3.1 MB after 6 more minutes

Or, an average of 0.57 MB per minute. That’s about 34 MB per hour—just over half of what the Verizon calculator suggests. That’s good news! If this number is remotely correct, streaming Pandora for two hours a day will actually consume about 2 GB per month, not 3.5+ GB. 

(Note: the Verizon site uses normal [mebibytes](http://en.wikipedia.org/wiki/Mebibyte) but [iOS doesn’t](../../2012/12/does-ios-report-usage-in-mebibytes-or.html). The effect of this difference is not insignificant here.)

How does this align with what Pandora’s [documentation](http://help.pandora.com/customer/portal/articles/90985-audio-quality) claims?

> Pandora on the Web plays 64k AAC+ for free listeners and 192k for Pandora One subscribers. All in-home devices play 128k audio, and **mobile devices receive a variety of different rates depending on the capability of the device and the network they are on, but never more than 64k AAC+**. 

OK, so let’s get that 64k stream into the units we like: MB/minute. (I’m assuming that “64k” means 64 kilobits per minute.)

So 0.47 MiB/minute. Nice. If I convert my above figures into MiB from MB, I get 0.54 MiB/minute. That’s still more than Pandora claims, but we’re in the ballpark so I’ll take their word for it<sup>1</sup> (maybe I got some emails in the background during those 15 minutes...).

So, Pandora mobile uses just under half a megabyte per minute, or ~28 MiB per hour. **The Verizon data estimator over estimates Pandora usage by over 100%**. To their credit, they indicated what figures they used, and certainly other sites or services may stream music at a higher bitrate. But if you just use Pandora, this is good news.

<sup>1</sup>Huh. Now that I’ve simply confirmed Pandora’s claimed usage this whole experiement seems a bit ridiculous...

---

### 2 comments

**Charlotte Pritchard said on 2014-03-01**

Thank you for writing this article. I had not been using Pandora for fear it would consume my data, now I feel free to use it.

**Stan Voynick said on 2014-11-28**

Pretty sure that you meant your parenthetical:  

(I’m assuming that “64k” means 64 kilobits per minute.)

... to read "64 kilobytes per second"

Minor point, though, because the rest of your post, including the calculations, uses the correct units.

Comments closed
{: .comments-closed }