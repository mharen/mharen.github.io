---
date: '2012-12-03T21:45:00.001-05:00'
description: ''
published: true
slug: 2012-12-does-ios-report-usage-in-mebibytes-or
tags:
- Television
- http://schemas.google.com/blogger/2008/kind#post
- iOS
- Apple
- iPhone
- legacy-blogger
time_to_read: 5
title: Does iOS Report Usage in Mebibytes or Megabytes?
---

<p><strong>Quick answer: megabytes (1 × 10<sup>6</sup> bytes).</strong></p>
<p>With data caps being all the rage these days you might be wondering how you can check your data usage in iOS. It’s simple. Go to Settings &gt; General &gt; Usage &gt; Cellular Usage:</p>
<p><img alt="13" height="450" src="http://lh5.ggpht.com/-5GARYzc8OxA/UL1j1KVH4xI/AAAAAAAAFbQ/WYiYbd3TL8Y/13%25255B7%25255D.png" style="float: none; margin: 3px auto; display: block;" title="13" width="356" /></p>
<p>But since I’m a computer guy, I want to know: is this measured in base-2 bytes (e.g. <a href="http://en.wikipedia.org/wiki/Mebibyte">mebibytes</a>) or base-10 bytes (<a href="http://en.wikipedia.org/wiki/Megabyte">megabytes</a>)? </p>
<p>I couldn’t tell and the docs weren’t clear so I tested it. First I needed a test file. I took a video file and used 7zip to build a file that’s exactly 10 MB in size:</p>
<p><img alt="image" height="261" src="http://lh5.ggpht.com/-r5ZyASm9coc/UL1j1hhtUhI/AAAAAAAAFbY/IFfXDnOBp2Y/image2.png" style="float: none; margin: 3px auto; display: block;" title="image" width="371" /></p>
<p>I chose a video file to make sure compression on the network or in the app I use to test this wouldn’t affect my results (video is already compressed so it won’t benefit from additional compression). I zipped it because that’s an easy way to slice off 10 MB of it (and it also further insures that the result is <em>not</em> compressible).</p>
<p>And that blob of 10,485,760 bytes is truly 10 mebibytes (10 **×** 2<sup>20</sup>):</p>
<p><img alt="image" height="319" src="http://lh6.ggpht.com/-MpriLgyVKYg/UL1j2jlGqwI/AAAAAAAAFbg/i2utSa2WlD4/image5.png" style="float: none; margin: 3px auto; display: block;" title="image" width="522" /></p>
<p>To see what affect this has, I downloaded the file to my phone with Dropbox and checked the affect on my usage. If iOS uses the binary-based definition of a megabyte (2<sup>20</sup>), it should show “10.0 MB”. If it uses that other definition of a megabyte (10<sup>6</sup>), it should show “10.4 MB” (or “10.5 MB” if there’s any rounding). Let’s see:</p>  <p align="center"><img alt="2012-11-30 15.02.20" height="300" src="http://lh6.ggpht.com/-nRQ3aYOhPGQ/UL1j3Pz4Y8I/AAAAAAAAFbo/J09FaPDdbwo/2012-11-30-15.02.203.png" style="margin: 3px 0px; display: inline;" title="2012-11-30 15.02.20" width="200" /><img alt="2012-11-30 15.04.05" height="300" src="http://lh5.ggpht.com/-WXhC_vhT0IY/UL1j3wY8B3I/AAAAAAAAFbw/Ast7t1nILWQ/2012-11-30%25252015.04.05%25255B3%25255D.png" style="margin: 3px 0px; display: inline;" title="2012-11-30 15.04.05" width="200" /></p>
<p>This took a few minutes. And the result:</p>  <p align="center"><img alt="2012-11-30 15.04.43" height="450" src="http://lh3.ggpht.com/-UxohuoqoDAg/UL1j4tTn9uI/AAAAAAAAFb4/G9tPeTZ9d50/2012-11-30-15.04.43%25255B1%25255D.png" style="margin: 3px 0px; display: inline;" title="2012-11-30 15.04.43" width="300" /></p>        
<p>10.4 MB. Well there you have it: <strong>it uses the base-10 definition.</strong></p>