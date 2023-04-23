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

Last time we captured the board and the card deck into Javascript objects that look like this:  
```cs
var board = [
    { color: 'Red' },
    { color: 'Orange', bridgeTo: 59 }
    // ...
];

var cards = [
    'Red'   , 'Red'   , 'Red'   , 'Red'   , 'Red'   , 'Red'   , 'Red'   , 'Red'
    // ...
];
```



[![players%5B7%5D.jpg](players%5B7%5D.jpg)](http://claimyourjourney.com/2011/08/blog-7-running-and-candy-land/)


Now we need to simply draw cards and keep track of a player through the game. I guess we should come up with some simple way to track that. Players will have a name and a position on the board. We also need to know if the player is losing a turn because they stepped on a licorice space. This should do it:


```cs
var players = [
    { name: 'Michael', isLosingATurn: false, position: -1 },
    { name: 'Thing 1', isLosingATurn: false, position: -1 },
];
```



As we design the rest of the engine, we’ll add to that as necessary.


OK, now we need to create a game loop. A game loop basically covers all the actions that happen in one cycle of the game. Since Candy Land players don’t affect each other (except for a shared deck of cards), all the interesting stuff happens in the player loop, with alternating players.


Here’s a [first pass](http://jsfiddle.net/mharen/crgAX/6/) of what we need:


```cs
var players = [
    { name: 'Michael', isLosingATurn: false, position: -1, isWinner: false, moves: 0 },
    { name: 'Thing 1', isLosingATurn: false, position: -1, isWinner: false, moves: 0 }
];

// call "DoGame" to play an entire game, passing in the players array
          
function DoGame(players){
    // initialize the board
          
    // initialize the deck

    <span class="rem">// call "DoGameLoop" (pass in the board and deck) until it returns false, 

    // which indicates the game is over</span>
    
    // when the game is over print out summary stats (e.g move counts) and exit
}
          
function DoGameLoop(players, board, cards){
    // if all players have finished (yes, my kids insist that the game continues
    // until everyone finishes :/) exit, the game is over (return false)
    
    // for each player: DoPlayerLoop
    
    // things went as planned, return true
}

function DoPlayerLoop(player, board, cards){
    // if we are lose a turn, turn off the "isLosingATurn" property and we're done (exit now)
    
    // draw a card and increment the "moves" counter
    
    // find the next space to move to based on the card
    
    // if your move takes you to the last square or beyond, you win 
    // set the "isWinner" property to true and exit
    
    // if the space we landed on is a bridge, follow the bridge
    
    <span class="rem">// if we are now on a lose-a-turn space, turn 

    // on the "isLosingATurn" property so we know </span>
    // to skip our turn the next time around
}

function DrawACard(cards){
    // if there are no cards left in the deck they must have all been played so
    // reshuffle them! Boom, now there are cards in the deck
    
    // remove a card and return it
}

function MakeDeck(){
    // return a new, shuffled deck   
}

function MakBoard(){
    // return a new board
}
```



That should read pretty easily from top to bottom (you may have to use your imagination a little bit). We’ll implement some of these in the next post.