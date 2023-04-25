---
layout: post
date: '2011-11-10T23:00:00.001-05:00'
categories:
- candy land simulator
- nablopomo 2011
- code
- technology
title: 'A Candy Land Simulator: Overview and Data Representations'
---

**Note:** this post is from a series on Candy Land:

1. Overview and Data Representations (you are here)
2. [The Game Engine](candy-land-simulator-game-engine)
3. [The Game Engine, Implemented](note-this-post-is-from-series-on-candy)


As I was playing Candy Land with Thing 1, it occurred to me how much I dislike the game. As I blindly turned card after card I wondered what the typical number of moves looks like. And then I wondered what the distribution looks like. Really my brain just wanted to know how long it would be suffering, and how confident it should be about that answer.

I guess the driving force behind these questions is my insatiable desire to finish this game so I can banish it to the bookshelf for another night and redirect the kiddos to other, less torturous activities.

![candy-land.jpg](/assets/2011/candy-land.jpg)

This is not a novel thing to wonder. In fact, apparently it’s pretty straight forward to [approximate mathematically](http://www.math.niu.edu/~rusin/uses-math/games/candyland/) with a Markov chain. I’m not interested (or knowledgeable) in any of that, though. Instead, I want to simply build a test apparatus that yields the same kinds of answers from generated experimental data instead of fancy mathematics.

But that’s [been done](http://forthplace.com/candyland-simulator/), too. I already had this idea festering as I enjoyed a friendly match of the worst game ever invented so I’m going to do it anyway. Come along for the ride—here we go!

My primary goal is to figure out the average number of moves required to end a game of Candy Land between my daughter and me, experimentally. Along the way, we’ll do these too:  

* Create a simulator that can run through a whole game of Candy Land unattended
* Produce some output with different variables (e.g. number of players)
* Make some fancy tables and charts

We might pile some more on as we go, of course. Throughout the whole process, I will try to make everything accessible to novice or aspiring programmers. This might mean I’m far more verbose and explicit about things than I normally would be; experienced programmers will just have to play along.

We’ll use Javascript as much as possible. Let’s get started.

First, we need to represent the game elements. We’ll start with something crude and then adjust it as needed. I transcribed the board into a [Google Doc](https://docs.google.com/spreadsheet/ccc?key=0AveyCDgGdW3edElxUnUtQS1rdUpaaWtaTFpZRnZNYVE&hl=en_US#gid=0) (you can steal that if you like) and from that we’ll extract some JSON (that’s in the spreadsheet, too).

If JSON (Javascript object notation) is unfamiliar to you, check [it out](http://www.json.org/). It’s pretty important.

The board looks like this in JSON:  
```js
var board = [
    // ...
    { color: 'Purple' },
    { color: 'Yellow', bridgeTo: 45 },
    { color: 'Blue' },
    // ...
    { color: 'Green' },
    { color: 'Red', loseTurn: true },
    { color: 'Purple' },
    { color: 'Yellow' }
    // ...
];
```
 
Here’s the [full board](http://jsfiddle.net/mharen/crgAX/3/). Basically we have an array of hashes. Each hash represents a square on the board and has the following properties:

* color (or character), required
* loseTurn, only present if true
* bridgeTo, if present this indicates where the bridge leads to

Next we need the deck of cards:

```js
var cards = [
    'Red'   , 'Red'   , 'Red'   , 'Red'   , 'Red'   , 'Red'   , 'Red'   , 'Red'   ,
    'Purple', 'Purple', 'Purple', 'Purple', 'Purple', 'Purple', 'Purple', 'Purple',
    'Yellow', 'Yellow', 'Yellow', 'Yellow', 'Yellow', 'Yellow', 'Yellow', 'Yellow',
    'Blue'  , 'Blue'  , 'Blue'  , 'Blue'  , 'Blue'  , 'Blue'  , 'Blue'  , 'Blue'  ,
    'Orange', 'Orange', 'Orange', 'Orange', 'Orange', 'Orange', 'Orange', 'Orange',
    'Green' , 'Green' , 'Green' , 'Green' , 'Green' , 'Green' , 'Green' , 'Green' ,
    
    '2Red', '2Blue', '2Purple', '2Orange', '2Yellow', '2Green',
    '2Red', '2Blue', '2Purple', '2Orange', '2Yellow', '2Green' ,
    
    'Gingerbread Man', 'Candy Cane', 'Gum Drop', 'Peanut', 'Lolly Pop', 'Ice Cream Cone'
];
```
 
With those in place, we can now do simple things like counting spaces:

```js
alert(board.length);
```
 
Or counting cards:


```js
alert(cards.length);
```
 
Or peeking at a [random](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Math/random) card from the deck:

```js
var cardCount = cards.length;
var randomIndex = Math.floor(Math.random() * cardCount);
var randomCard = cards[randomIndex];
alert(randomCard);
```
 
I haven’t decided how to simulate shuffling yet (shuffle first, or draw randomly)—we’ll talk about that and do it tomorrow.

You can run what we have so far by hitting the little “play” triangle in this fiddle:

<iframe style="width: 100%; height: 300px" src="https://jsfiddle.net/mharen/crgAX/5/embedded/js,result" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Now that we have our structures in place, we should start thinking about how we’re going to use the cards to navigate the board. I’ll start on that tomorrow, too... :)