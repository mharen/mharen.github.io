---
layout: post
date: '2006-09-27T09:30:00.000-04:00'
categories:
- random updates
title: The average blah has a bajillion times more bacteria than the average toilet seat
---

I have heard this phrase [over](http://www.realtechnews.com/posts/2933) and [over](http://www.lifehack.org/articles/lifehack/average-desk-harbors-400-times-more-bacteria-than-average-toilet-seat.html) and [over](http://www.theregister.co.uk/2004/08/13/toilet_filthy/) and [over](http://www.wellnessjunction.com/athome/disease_prevention/gerba.htm) again. [Mythbusters](http://en.wikipedia.org/wiki/MythBusters_%28season_1%29#Toothbrush_Surprise) even did a show slightly related to this.

Now we have a [mouse](http://www.lewispr.com/us/wire/index.php?news_id=1915) designed to tackle this "problem". Work with me here...if you clean your bathroom regularly (or even occasionally!), but rarely clean your desk, which do you expect to be cleaner?

* **Here's an idea: clean your desk.**

This just in: recently washed stuff is cleaner than unwashed stuff! Holy crap!

Just to take this to an obscene extreme, I took the liberty of creating a headline generator. Fill in the blanks and click "Surprise Me".

A number: <input type="text" value="538" title="a number" id="toiletNumber" size="4">
and an object: 
<input type="text" value="banana" title="object" id="toiletObject" size="6">
and 
<input type="button" onclick="document.getElementById('toiletHeadline').innerHTML='Did you know that the average ' + document.getElementById('toiletObject').value + ' has ' + document.getElementById('toiletNumber').value + ' times more bacteria than the average toilet seat?!'" value="Surprise Me">

<h3 id="toiletHeadline">Did you know that the average apple has 538 times more bacteria than the average toilet seat?!</h3>