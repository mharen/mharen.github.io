---
date: '2011-11-10T23:00:00.001-05:00'
description: ''
published: true
slug: 2011-11-candy-land-simulator-overview-and-data
tags:
- Candy Land Simulator
- http://schemas.google.com/blogger/2008/kind#post
- NaBloPoMo 2011
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'A Candy Land Simulator: Overview and Data Representations'
---


*Note: this post is from a *[*series on Candy Land*](http://blog.wassupy.com/search/label/Candy%20Land%20Simulator)*.*

As I was playing Candy Land with Thing 1, it occurred to me how much I dislike the game. As I blindly turned card after card I wondered what the typical number of moves looks like. And then I wondered what the distribution looks like. Really my brain just wanted to know how long it would be suffering, and how confident it should be about that answer.

I guess the driving force behind these questions is my insatiable desire to finish this game so I can banish it to the bookshelf for another night and redirect the kiddos to other, less torturous activities.

![51epeuM6E7L.jpg](51epeuM6E7L.jpg)

This is not a novel thing to wonder. In fact, apparently it’s pretty straight forward to [approximate mathematically](http://www.math.niu.edu/~rusin/uses-math/games/candyland/) with a Markov chain. I’m not interested (or knowledgeable) in any of that, though. Instead, I want to simply build a test apparatus that yields the same kinds of answers from generated experimental data instead of fancy mathematics.

But that’s [been done](http://forthplace.com/candyland-simulator/), too. I already had this idea festering as I enjoyed a friendly match of the worst game ever invented so I’m going to do it anyway. Come along for the ride—here we go!

My primary goal is to figure out the average number of moves required to end a game of Candy Land between my daughter and me, experimentally. Along the way, we’ll do these too:  <ul>   <li>Create a simulator that can run through a whole game of Candy Land unattended </li>    <li>Produce some output with different variables (e.g. number of players) </li>    <li>Make some fancy tables and charts </li> </ul>

We might pile some more on as we go, of course. Throughout the whole process, I will try to make everything accessible to novice or aspiring programmers. This might mean I’m far more verbose and explicit about things than I normally would be; experienced programmers will just have to play along.

We’ll use Javascript as much as possible. Let’s get started.

First, we need to represent the game elements. We’ll start with something crude and then adjust it as needed. I transcribed the board into a [Google Doc](https://docs.google.com/spreadsheet/ccc?key=0AveyCDgGdW3edElxUnUtQS1rdUpaaWtaTFpZRnZNYVE&amp;hl=en_US#gid=0) (you can steal that if you like) and from that we’ll extract some JSON (that’s in the spreadsheet, too).

If JSON (Javascript object notation) is unfamiliar to you, check [it out](http://www.json.org/). It’s pretty important.

The board looks like this in JSON:  <pre class="csharpcode"><span class="kwrd">var</span> board = [
    <span class="rem">// ...</span>
    { color: <span class="str">'Purple'</span> },
    { color: <span class="str">'Yellow'</span>, bridgeTo: 45 },
    { color: <span class="str">'Blue'</span> },
    <span class="rem">// ...</span>
    { color: <span class="str">'Green'</span> },
    { color: <span class="str">'Red'</span>, loseTurn: <span class="kwrd">true</span> },
    { color: <span class="str">'Purple'</span> },
    { color: <span class="str">'Yellow'</span> }
    <span class="rem">// ...</span>
];</pre>


Here’s the [full board](http://jsfiddle.net/mharen/crgAX/3/). Basically we have an array of hashes. Each hash represents a square on the board and has the following properties:

<ul>
  <li>color (or character), required </li>

  <li>loseTurn, only present if true </li>

  <li>bridgeTo, if present this indicates where the bridge leads to </li>
</ul>


Next we need the deck of cards:

<pre class="csharpcode"><span class="kwrd">var</span> cards = [
    <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   ,
    <span class="str">'Purple'</span>, <span class="str">'Purple'</span>, <span class="str">'Purple'</span>, <span class="str">'Purple'</span>, <span class="str">'Purple'</span>, <span class="str">'Purple'</span>, <span class="str">'Purple'</span>, <span class="str">'Purple'</span>,
    <span class="str">'Yellow'</span>, <span class="str">'Yellow'</span>, <span class="str">'Yellow'</span>, <span class="str">'Yellow'</span>, <span class="str">'Yellow'</span>, <span class="str">'Yellow'</span>, <span class="str">'Yellow'</span>, <span class="str">'Yellow'</span>,
    <span class="str">'Blue'</span>  , <span class="str">'Blue'</span>  , <span class="str">'Blue'</span>  , <span class="str">'Blue'</span>  , <span class="str">'Blue'</span>  , <span class="str">'Blue'</span>  , <span class="str">'Blue'</span>  , <span class="str">'Blue'</span>  ,
    <span class="str">'Orange'</span>, <span class="str">'Orange'</span>, <span class="str">'Orange'</span>, <span class="str">'Orange'</span>, <span class="str">'Orange'</span>, <span class="str">'Orange'</span>, <span class="str">'Orange'</span>, <span class="str">'Orange'</span>,
    <span class="str">'Green'</span> , <span class="str">'Green'</span> , <span class="str">'Green'</span> , <span class="str">'Green'</span> , <span class="str">'Green'</span> , <span class="str">'Green'</span> , <span class="str">'Green'</span> , <span class="str">'Green'</span> ,
    
    <span class="str">'2Red'</span>, <span class="str">'2Blue'</span>, <span class="str">'2Purple'</span>, <span class="str">'2Orange'</span>, <span class="str">'2Yellow'</span>, <span class="str">'2Green'</span>,
    <span class="str">'2Red'</span>, <span class="str">'2Blue'</span>, <span class="str">'2Purple'</span>, <span class="str">'2Orange'</span>, <span class="str">'2Yellow'</span>, <span class="str">'2Green'</span> ,
    
    <span class="str">'Gingerbread Man'</span>, <span class="str">'Candy Cane'</span>, <span class="str">'Gum Drop'</span>, <span class="str">'Peanut'</span>, <span class="str">'Lolly Pop'</span>, <span class="str">'Ice Cream Cone'</span>
];</pre>


With those in place, we can now do simple things like counting spaces:

<pre class="csharpcode">alert(board.length);</pre>


Or counting cards:

<pre class="csharpcode">alert(cards.length);</pre>


Or peeking at a [random](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Math/random) card from the deck:

<pre class="csharpcode"><span class="kwrd">var</span> cardCount = cards.length;
<span class="kwrd">var</span> randomIndex = Math.floor(Math.random() * cardCount);
<span class="kwrd">var</span> randomCard = cards[randomIndex];
alert(randomCard);</pre>


I haven’t decided how to simulate shuffling yet (shuffle first, or draw randomly)—we’ll talk about that and do it tomorrow.


You can run what we have so far by hitting the little “play” triangle in this fiddle:





Now that we have our structures in place, we should start thinking about how we’re going to use the cards to navigate the board. I’ll start on that tomorrow, too… :)