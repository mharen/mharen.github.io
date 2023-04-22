---
date: '2012-11-14T22:56:00.001-05:00'
description: ''
published: true
slug: 2012-11-building-digital-clock-without-flash-or
tags:
- http://schemas.google.com/blogger/2008/kind#post
- NaBloPoMo 2012
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Building a Digital Clock without Flash or Images
---

<p>As a continuation of yesterday’s post wherein I built an <a href="../2012/2012-11-building-analog-clock-without-flash-or.html">analog clock without flash or images</a>, I am going to do something <em>much easier</em> today: build a digital clock. This will be another component to the game I’m building for Thing1.</p>
<p>Again, here’s where we’re headed:</p>
<p><img alt="goal" height="446" src="http://lh4.ggpht.com/-qi_PaSUetaw/UKRn0Nu3ZxI/AAAAAAAAFRk/7CeHcMhdFOU/goal%25255B2%25255D.png" style="float: none; margin: 3px auto; display: block;" title="goal" width="647" /></p>
<p>Let’s start with the basic layout again—just a section with an HTML5 &lt;time&gt; element within it:</p>
<p></p>
<p>Next let’s make it a little bigger, and blocky:</p>
<p></p>
<p>And add some background gradient for extra, unnecessary internet points:</p>
<p></p>
<p>That’s pretty much it. But, that was too easy. Let’s maybe change the text color of the minutes to match the analog clock (bluish). That will require a little JS to break up the tag’s contents:</p>
<p></p>
<p>Let’s not worry about it being totally hideous right now, emkay?</p>