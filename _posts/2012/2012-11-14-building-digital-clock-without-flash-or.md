---
layout: post
date: '2012-11-14T22:56:00.001-05:00'
categories:
- nablopomo-2012
- code
- technology
title: Building a Digital Clock without Flash or Images
---

As a continuation of yesterday’s post wherein I built an [analog clock without flash or images](../../2012/11/building-analog-clock-without-flash-or.html), I am going to do something *much easier* today: build a digital clock. This will be another component to the game I’m building for Thing1.

Again, here’s where we’re headed:

![goal.png](/assets/2012/goal.png)

Let’s start with the basic layout again—just a section with an HTML5 <time> element within it:

<iframe style="height: 200px; width: 100%" src="https://jsfiddle.net/rxghU/1/embedded/result,html,css" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Next let’s make it a little bigger, and blocky:

<iframe style="height: 200px; width: 100%" src="https://jsfiddle.net/rxghU/2/embedded/result,html,css" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

And add some background gradient for extra, unnecessary internet points:

<iframe style="height: 200px; width: 100%" src="https://jsfiddle.net/rxghU/3/embedded/result,html,css" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

That’s pretty much it. But, that was too easy. Let’s maybe change the text color of the minutes to match the analog clock (bluish). That will require a little JS to break up the tag’s contents:

<iframe style="height: 200px; width: 100%" src="https://jsfiddle.net/rxghU/4/embedded/result,js,html,css" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Let’s not worry about it being totally hideous right now, emkay?