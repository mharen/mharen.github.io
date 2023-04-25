---
layout: post
date: '2012-11-13T23:31:00.001-05:00'
categories:
- nablopomo 2012
- code
- technology
title: Building an Analog Clock without Flash or Images
---


Thing1 is learning to tell time on analog and digital clocks. Her uncle was kind enough to send over a link to an [online game](http://www.oswego.org/ocsd-web/games/StopTheClock/sthec1.html) that helps reinforce what she’s learning. 

![lots of clocks](/assets/2012/goal.png)

It is pretty neat! Unfortunately, though, it’s implemented in Flash so we can’t use it on our iOS devices. Let’s fix that by turning it into a regular web page. We might end up using some of the fancier HTML/CSS/JS things as we go.

The first thing we’ll need is an analog clock so we’ll build that today. I’m going to do it the hard way by insisting that no images be used. Just for fun.

*(Note: very little of this is likely to work in anything except Chrome. Sorry.)*

Let’s start by defining where the clocks should go with some very basic layout:

<iframe style="height: 200px; width: 100%" src="https://jsfiddle.net/Q3hjZ/1/embedded/result,html,css/" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Now we need some elements to hold the times. Let’s use that fancy new <time> tag:

<iframe style="height: 200px; width: 100%" src="https://jsfiddle.net/Q3hjZ/2/embedded/result,html,css/" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Now let’s restyle them into clock faces by making some circles and hiding the text:

<iframe style="height: 300px; width: 100%" src="https://jsfiddle.net/Q3hjZ/3/embedded/result,html,css/" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

How about some tick marks? We’ll use a little Javascript to help us add the 60 ticks, but we’ll style them with CSS:

<iframe style="height: 300px; width: 100%" src="https://jsfiddle.net/Q3hjZ/4/embedded/result,html,css,js" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

And some numerals:

<iframe style="height: 300px; width: 100%" src="https://jsfiddle.net/Q3hjZ/5/embedded/result,html,css,js" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Next, let's add the hour and minute hands:

<iframe style="height: 300px; width: 100%" src="https://jsfiddle.net/Q3hjZ/6/embedded/result,html,css,js" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Looking good. Now let's cap those off with a pin in the middle:

<iframe style="height: 300px; width: 100%" src="https://jsfiddle.net/Q3hjZ/7/embedded/result,html,css,js" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

It's nice, but a little flat. Let's use some spiffy gradients to the face and pin:

<iframe style="height: 300px; width: 100%" src="https://jsfiddle.net/Q3hjZ/8/embedded/result,html,css,js" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

How about some box-shadow on the hands for more depth?

<iframe style="height: 300px; width: 100%" src="https://jsfiddle.net/Q3hjZ/9/embedded/result,html,css,js" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Err. Ew. That doesn't work because the effect is applied before the rotation. That leads to each shadow going in a different direction...not very natural. Luckily, someone [figured out](http://stackoverflow.com/a/8833172/29) a better way by factoring in the rotation angle. Much better:

<iframe style="height: 300px; width: 100%" src="https://jsfiddle.net/Q3hjZ/10/embedded/result,html,css,js" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Next time I’ll build a digital clock widget...but don’t get your hopes up—it will be simpler.

NB: I [tweeted](https://twitter.com/mharen/status/268426088076697600) a version of this clock before writing the post and my pal [Xander](http://xdumaine.com/) wired up the clock’s state to a view model with [Knockout](http://knockoutjs.com/) and animated it. [Spiffy](http://jsfiddle.net/frCyn/4/).

---

### 1 comment

**Sarah said on 2012-11-14**

This is great!  Looking forward to seeing it in action!

