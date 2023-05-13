---
layout: post
date: '2012-12-03T21:45:00.001-05:00'
categories:
- television
- iOS
- iPhone
title: Does iOS Report Usage in Mebibytes or Megabytes?
---

**Quick answer: megabytes (1 × 10<sup>6</sup> bytes).**

With data caps being all the rage these days you might be wondering how you can check your data usage in iOS. It’s simple. Go to Settings > General > Usage > Cellular Usage.

But since I’m a computer guy, I want to know: is this measured in base-2 bytes (e.g. [mebibytes](http://en.wikipedia.org/wiki/Mebibyte)) or base-10 bytes ([megabytes](http://en.wikipedia.org/wiki/Megabyte))? 

I couldn’t tell and the docs weren’t clear so I tested it. First I needed a test file. I took a video file and used 7zip to build a file that’s exactly 10 MB in size.

I chose a video file to make sure compression on the network or in the app I use to test this wouldn’t affect my results (video is already compressed so it won’t benefit from additional compression). I zipped it because that’s an easy way to slice off 10 MB of it (and it also further insures that the result is *not* compressible).

And that blob of 10,485,760 bytes is truly 10 mebibytes (10 **×** 2<sup>20</sup>).

To see what affect this has, I downloaded the file to my phone with Dropbox and checked the affect on my usage. If iOS uses the binary-based definition of a megabyte (2<sup>20</sup>), it should show “10.0 MB”. If it uses that other definition of a megabyte (10<sup>6</sup>), it should show “10.4 MB” (or “10.5 MB” if there’s any rounding).

10.4 MB. Well there you have it: **it uses the base-10 definition.**