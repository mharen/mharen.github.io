---
layout: post
date: '2011-11-12T12:04:00.001-05:00'
categories:
- candy land simulator
- nablopomo 2011
- code
- technology
title: 'A Candy Land Simulator: The Game Engine'
---


*Note: this post is from a *[*series on Candy Land*](http://blog.wassupy.com/search/label/Candy%20Land%20Simulator)*.*

Last time we captured the board and the card deck into Javascript objects that look like this:  <pre class="csharpcode"><span class="kwrd">var</span> board = [
    { color: <span class="str">'Red'</span> },
    { color: <span class="str">'Orange'</span>, bridgeTo: 59 }
    <span class="rem">// ...</span>
];

<span class="kwrd">var</span> cards = [
    <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>
    <span class="rem">// ...</span>
];</pre>


[![players%5B7%5D.jpg](players%5B7%5D.jpg)](http://claimyourjourney.com/2011/08/blog-7-running-and-candy-land/)


Now we need to simply draw cards and keep track of a player through the game. I guess we should come up with some simple way to track that. Players will have a name and a position on the board. We also need to know if the player is losing a turn because they stepped on a licorice space. This should do it:

<pre class="csharpcode"><span class="kwrd">var</span> players = [
    { name: <span class="str">'Michael'</span>, isLosingATurn: <span class="kwrd">false</span>, position: -1 },
    { name: <span class="str">'Thing 1'</span>, isLosingATurn: <span class="kwrd">false</span>, position: -1 },
];</pre>


As we design the rest of the engine, we’ll add to that as necessary.


OK, now we need to create a game loop. A game loop basically covers all the actions that happen in one cycle of the game. Since Candy Land players don’t affect each other (except for a shared deck of cards), all the interesting stuff happens in the player loop, with alternating players.


Here’s a [first pass](http://jsfiddle.net/mharen/crgAX/6/) of what we need:

<pre class="csharpcode"><span class="kwrd">var</span> players = [
    { name: <span class="str">'Michael'</span>, isLosingATurn: <span class="kwrd">false</span>, position: -1, isWinner: <span class="kwrd">false</span>, moves: 0 },
    { name: <span class="str">'Thing 1'</span>, isLosingATurn: <span class="kwrd">false</span>, position: -1, isWinner: <span class="kwrd">false</span>, moves: 0 }
];

<span class="rem">// call &quot;DoGame&quot; to play an entire game, passing in the players array</span>
          
<span class="kwrd">function</span> DoGame(players){
    <span class="rem">// initialize the board</span>
          
    <span class="rem">// initialize the deck</span>

    <span class="rem">// call &quot;DoGameLoop&quot; (pass in the board and deck) until it returns false, 

    // which indicates the game is over</span>
    
    <span class="rem">// when the game is over print out summary stats (e.g move counts) and exit</span>
}
          
<span class="kwrd">function</span> DoGameLoop(players, board, cards){
    <span class="rem">// if all players have finished (yes, my kids insist that the game continues</span>
    <span class="rem">// until everyone finishes :/) exit, the game is over (return false)</span>
    
    <span class="rem">// for each player: DoPlayerLoop</span>
    
    <span class="rem">// things went as planned, return true</span>
}

<span class="kwrd">function</span> DoPlayerLoop(player, board, cards){
    <span class="rem">// if we are lose a turn, turn off the &quot;isLosingATurn&quot; property and we're done (exit now)</span>
    
    <span class="rem">// draw a card and increment the &quot;moves&quot; counter</span>
    
    <span class="rem">// find the next space to move to based on the card</span>
    
    <span class="rem">// if your move takes you to the last square or beyond, you win </span>
    <span class="rem">// set the &quot;isWinner&quot; property to true and exit</span>
    
    <span class="rem">// if the space we landed on is a bridge, follow the bridge</span>
    
    <span class="rem">// if we are now on a lose-a-turn space, turn 

    // on the &quot;isLosingATurn&quot; property so we know </span>
    <span class="rem">// to skip our turn the next time around</span>
}

<span class="kwrd">function</span> DrawACard(cards){
    <span class="rem">// if there are no cards left in the deck they must have all been played so</span>
    <span class="rem">// reshuffle them! Boom, now there are cards in the deck</span>
    
    <span class="rem">// remove a card and return it</span>
}

<span class="kwrd">function</span> MakeDeck(){
    <span class="rem">// return a new, shuffled deck   </span>
}

<span class="kwrd">function</span> MakBoard(){
    <span class="rem">// return a new board</span>
}</pre>


That should read pretty easily from top to bottom (you may have to use your imagination a little bit). We’ll implement some of these in the next post.