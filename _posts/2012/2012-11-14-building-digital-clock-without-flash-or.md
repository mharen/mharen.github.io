---
layout: post
date: '2012-11-14T22:56:00.001-05:00'
categories:
- nablopomo 2012
- code
- technology
title: Building a Digital Clock without Flash or Images
---

As a continuation of yesterday’s post wherein I built an [analog clock without flash or images](../../2012/11/building-analog-clock-without-flash-or.html), I am going to do something *much easier* today: build a digital clock. This will be another component to the game I’m building for Thing1.

Again, here’s where we’re headed:

{% imagesize /assets/2012/goal.png:img %}

Let’s start with the basic layout again—just a section with an HTML5 <time> element within it:

<iframe class="full-embed fixed-short" src="https://jsfiddle.net/rxghU/1/embedded/result,html,css" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Next let’s make it a little bigger, and blocky:

<iframe class="full-embed fixed-short" src="https://jsfiddle.net/rxghU/2/embedded/result,html,css" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

And add some background gradient for extra, unnecessary internet points:

<iframe class="full-embed fixed-short" src="https://jsfiddle.net/rxghU/3/embedded/result,html,css" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

That’s pretty much it. But, that was too easy. Let’s maybe change the text color of the minutes to match the analog clock (bluish). That will require a little JS to break up the tag’s contents:

<iframe class="full-embed fixed-short" src="https://jsfiddle.net/rxghU/4/embedded/result,js,html,css" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Let’s not worry about it being totally hideous right now, emkay?