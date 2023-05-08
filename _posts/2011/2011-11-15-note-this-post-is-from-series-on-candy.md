---
layout: post
date: '2011-11-15T11:38:00.001-05:00'
categories:
- candy-land-simulator
- nablopomo-2011
- code
- technology
title: 'A Candy Land Simulator: The Game Engine, Implemented'
---

**Note:** this post is from a series on Candy Land:

1. [Overview and Data Representations](candy-land-simulator-overview-and-data)
2. [The Game Engine](candy-land-simulator-game-engine)
3. The Game Engine, Implemented (you are here)

We’re back again. We still have our board and cards (these are old hat now, right?):

```js
var board = [
    { color: 'Red' },
    { color: 'Orange', bridgeTo: 59 }
    // ...
];

var cards = [
    'Red', 'Red', 'Red', 'Red', 'Red', 'Red', 'Red', 'Red'
    // ...
];
```

And we just added some players:

```js
var players = [
    { name: 'Michael', isLosingATurn: false, position: -1, isWinner: false, moves = 0 },
    { name: 'Thing 1', isLosingATurn: false, position: -1, isWinner: false, moves = 0 }
];
```

So let’s get down to implementing some of the game engine we spec'd out yesterday. First, here’s the test harness:

{% imagesize /assets/2011/test-harness.png:img %}

I decided to add an option of letting players stop the game as soon as one player wins (like normal people), or to play through until everyone “wins” like my kids play. This is the main function that we run when we click the button to start the game. It loads up that option from a checkbox, and the players:

```js
// for stats
var gamesPlayed = 0;
var totalMoves = 0;

// run this when the button is clicked
$('#run').click(function(){
    
    var options = { 
        // see if the option to run until everyone wins is checked
        doRunUntilEveryoneWins: $('#all-win').is(':checked')
    };

    // configure two players
    var players = [
        // ladies first
        { name: 'Thing 1', isLosingATurn: false, 
          position: -1, isWinner: false, moves: 0 },
        { name: 'Michael', isLosingATurn: false, 
          position: -1, isWinner: false, moves: 0 }
    ];

    // call "DoGame" to play an entire game, passing 
    // in the players array
    DoGame(options, players);
    
    // update stats
    gamesPlayed++;
    totalMoves += players[0].moves + players[1].moves;
    $('#average').text(Math.ceil(totalMoves/gamesPlayed));
    
    // append another row to the table
    $('#results').show()
        .find('table').append( 
            $('<tr/>').append( $('<td/>').text(players[0].moves) )
                      .append( $('<td/>').text(players[1].moves) )
                      .append( $('<td/>').text(players[0].moves 
                                               + players[1].moves) )
            );
});
```

As you’ll see, I’ve taken a few other liberties during the implementation that deviate slightly from the original design. That’s normal. 

So when we actually call “DoGame()”, this is called:

```js
function DoGame(options, players){
    // initialize the board
    var board = MakeBoard();

    // initialize the deck
    var cards = MakeDeck();

    // call "DoGameLoop" (pass in the board and deck) 
    // until it returns false, which indicates the game is over
    while(DoGameLoop(options, players, board, cards));
}
```

Which calls “DoGameLoop” repeatedly until it signals that the game is over:

```js
// return false when the game is over
function DoGameLoop(options, players, board, cards){
    
    // we will set this to true if someone is playing...
    var IsSomeoneStillPlaying = false; 
    
    // for each player: DoPlayerLoop
    for(var i = 0; i < players.length; ++i){
        var player = players[i];
        
        // skip this player if they've won already
        // or made 10000 moves (that would be too many)
        if(!player.isWinner && player.moves < 10000){
            
            // do the actual move
            DoPlayerLoop(options, player, board, cards);
            
            // keep track if this player has won
            IsSomeoneStillPlaying |= !player.isWinner;

            // see if we should stop when just one player wins (configurable)
            if(!options.doRunUntilEveryoneWins && player.isWinner){
                return false;
            }
        }  
    }
    
    // things went as planned, return true if some players are still playing
    return IsSomeoneStillPlaying;
}
```

That just calls “DoPlayerLoop” for each player:

```js
function DoPlayerLoop(options, player, board, cards){
    // if we are losing a turn, turn off the "isLosingATurn" 
    // property and we're done (exit now)
    if(player.isLosingATurn){
        player.isLosingATurn = false;
          return true;
    }
    
    // draw a card and increment the "moves" counter
    var drawnCard = DrawACard(cards);
    player.moves++;
    
    // we'll can play either 1 or 2 moves because we have doubles
    var currentSpace = DoMove(options, player, board, drawnCard);
    
    // if the player drew a double card, they move again  
    if(drawnCard.isDouble && !player.isWinner){
        DoMove(options, player, board, drawnCard ); // do it again!
    }
    
    if(player.isWinner){
        // woohoo
        return true;
    }
    
    // if the space we landed on is a bridge, follow the bridge
    if(currentSpace.bridgeTo){
        player.position = currentSpace.bridgeTo;
        currentSpace = board[player.position];
    }
          
    // if we are now on a lose-a-turn space, turn on the 
    // "isLosingATurn" property so we know 
    // to skip our turn the next time around
    if(currentSpace.loseTurn){
        player.isLosingATurn = true;
    }
}
```

The real workhorse in there is the call to DoMove, which actually advances the game token along the board:

```js
function DoMove(options, player, board, card){
    // we'll cycle through the board. 
    // if we have a regular color card (or double), we'll go 
    // until we hit the color, OR reach the end of the board
    var currentSpace;
    var iterations = 0;
    do{
        // advance one space
        player.position++;
    
        // if we hit the end of the board
        // we start over if we have a character card
        // or we win if we have a regular color card
        if(player.position == board.length){
            if(card.isCharacter){
                // if we have a character card and we've reached the 
                // end of the board, wrap around
                player.position = 0;
            }
            else{
                // if your move takes you to the last square or beyond, you win 
                // set the "isWinner" property to true and exit
                player.isWinner = true;
            }
        }
        currentSpace = board[player.position];

        // loop until we find the space we're looking for
        // or we win
        // or we iterate 10000 times (because something must be broken)
    }while(currentSpace 
           && currentSpace.color != card.color 
           && !player.isWinner && ++iterations < 10000);
    
    return currentSpace;
}
```
 
All this, including the source to the utility functions (e.g. DrawACard) is available [in the fiddle](http://jsfiddle.net/mharen/crgAX/35/). Here’s the working version:

<iframe width="100%" height="300" src="//jsfiddle.net/mharen/crgAX/35/embedded/" allowfullscreen="allowfullscreen" allowpaymentrequest frameborder="0"></iframe>

In the next post I’ll do some additional testing and verification. A brief, casual comparison to other papers online reveals that my results are reasonable. I’m not saying they are correct, but I’m at least in the ball park for finding the length of an average game (around 45-50 cards).