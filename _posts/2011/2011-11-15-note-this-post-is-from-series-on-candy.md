---
layout: post
date: '2011-11-15T11:38:00.001-05:00'
categories:
- candy land simulator
- nablopomo 2011
- code
- technology
title: 'A Candy Land Simulator: The Game Engine, Implemented'
---


*Note: this post is from a *[*series on Candy Land*](http://blog.wassupy.com/search/label/Candy%20Land%20Simulator)*.*

We’re back again. We still have our board and cards (these are old hat now, right?):  <pre class="csharpcode"><span class="kwrd">var</span> board = [
    { color: <span class="str">'Red'</span> },
    { color: <span class="str">'Orange'</span>, bridgeTo: 59 }
    <span class="rem">// ...</span>
];

<span class="kwrd">var</span> cards = [
    <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>   , <span class="str">'Red'</span>
    <span class="rem">// ...</span>
];</pre>


And we just added some players:

<pre class="csharpcode"><span class="kwrd">var</span> players = [
    { name: <span class="str">'Michael'</span>, isLosingATurn: <span class="kwrd">false</span>, position: -1, isWinner: <span class="kwrd">false</span>, moves = 0 },
    { name: <span class="str">'Thing 1'</span>, isLosingATurn: <span class="kwrd">false</span>, position: -1, isWinner: <span class="kwrd">false</span>, moves = 0 }
];</pre>


So let’s get down to implementing some of the game engine we spec'd out yesterday. First, here’s the test harness:


![image%5B3%5D.png](image%5B3%5D.png)


I decided to add an option of letting players stop the game as soon as one player wins (like normal people), or to play through until everyone “wins” like my kids play. This is the main function that we run when we click the button to start the game. It loads up that option from a checkbox, and the players:

<pre class="csharpcode"><span class="rem">// for stats</span>
<span class="kwrd">var</span> gamesPlayed = 0;
<span class="kwrd">var</span> totalMoves = 0;

<span class="rem">// run this when the button is clicked</span>
$(<span class="str">'#run'</span>).click(<span class="kwrd">function</span>(){
    
    <span class="kwrd">var</span> options = { 
        <span class="rem">// see if the option to run until everyone wins is checked</span>
        doRunUntilEveryoneWins: $(<span class="str">'#all-win'</span>).<span class="kwrd">is</span>(<span class="str">':checked'</span>)
    };

    <span class="rem">// configure two players</span>
    <span class="kwrd">var</span> players = [
        <span class="rem">// ladies first</span>
        { name: <span class="str">'Thing 1'</span>, isLosingATurn: <span class="kwrd">false</span>, 
          position: -1, isWinner: <span class="kwrd">false</span>, moves: 0 },
        { name: <span class="str">'Michael'</span>, isLosingATurn: <span class="kwrd">false</span>, 
          position: -1, isWinner: <span class="kwrd">false</span>, moves: 0 }
    ];

    <span class="rem">// call &quot;DoGame&quot; to play an entire game, passing </span>
    <span class="rem">// in the players array</span>
    DoGame(options, players);
    
    <span class="rem">// update stats</span>
    gamesPlayed++;
    totalMoves += players[0].moves + players[1].moves;
    $(<span class="str">'#average'</span>).text(Math.ceil(totalMoves/gamesPlayed));
    
    <span class="rem">// append another row to the table</span>
    $(<span class="str">'#results'</span>).show()
        .find(<span class="str">'table'</span>).append( 
            $(<span class="str">'&lt;tr/&gt;'</span>).append( $(<span class="str">'&lt;td/&gt;'</span>).text(players[0].moves) )
                      .append( $(<span class="str">'&lt;td/&gt;'</span>).text(players[1].moves) )
                      .append( $(<span class="str">'&lt;td/&gt;'</span>).text(players[0].moves 
                                               + players[1].moves) )
            );
});</pre>


As you’ll see, I’ve taken a few other liberties during the implementation that deviate slightly from the original design. That’s normal. 


So when we actually call “DoGame()”, this is called:

<pre class="csharpcode"><span class="kwrd">function</span> DoGame(options, players){
    <span class="rem">// initialize the board</span>
    <span class="kwrd">var</span> board = MakeBoard();

    <span class="rem">// initialize the deck</span>
    <span class="kwrd">var</span> cards = MakeDeck();

    <span class="rem">// call &quot;DoGameLoop&quot; (pass in the board and deck) </span>
    <span class="rem">// until it returns false, which indicates the game is over</span>
    <span class="kwrd">while</span>(DoGameLoop(options, players, board, cards));
}</pre>


Which calls “DoGameLoop” repeatedly until it signals that the game is over:

<pre class="csharpcode"><span class="rem">// return false when the game is over</span>
<span class="kwrd">function</span> DoGameLoop(options, players, board, cards){
    
    <span class="rem">// we will set this to true if someone is playing...</span>
    <span class="kwrd">var</span> IsSomeoneStillPlaying = <span class="kwrd">false</span>; 
    
    <span class="rem">// for each player: DoPlayerLoop</span>
    <span class="kwrd">for</span>(<span class="kwrd">var</span> i = 0; i &lt; players.length; ++i){
        <span class="kwrd">var</span> player = players[i];
        
        <span class="rem">// skip this player if they've won already</span>
        <span class="rem">// or made 10000 moves (that would be too many)</span>
        <span class="kwrd">if</span>(!player.isWinner &amp;&amp; player.moves &lt; 10000){
            
            <span class="rem">// do the actual move</span>
            DoPlayerLoop(options, player, board, cards);
            
            <span class="rem">// keep track if this player has won</span>
            IsSomeoneStillPlaying |= !player.isWinner;

            <span class="rem">// see if we should stop when just one player wins (configurable)</span>
            <span class="kwrd">if</span>(!options.doRunUntilEveryoneWins &amp;&amp; player.isWinner){
                <span class="kwrd">return</span> <span class="kwrd">false</span>;
            }
        }  
    }
    
    <span class="rem">// things went as planned, return true if some players are still playing</span>
    <span class="kwrd">return</span> IsSomeoneStillPlaying;
}</pre>


That just calls “DoPlayerLoop” for each player:

<pre class="csharpcode"><span class="kwrd">function</span> DoPlayerLoop(options, player, board, cards){
    <span class="rem">// if we are losing a turn, turn off the &quot;isLosingATurn&quot; </span>
    <span class="rem">// property and we're done (exit now)</span>
    <span class="kwrd">if</span>(player.isLosingATurn){
        player.isLosingATurn = <span class="kwrd">false</span>;
          <span class="kwrd">return</span> <span class="kwrd">true</span>;
    }
    
    <span class="rem">// draw a card and increment the &quot;moves&quot; counter</span>
    <span class="kwrd">var</span> drawnCard = DrawACard(cards);
    player.moves++;
    
    <span class="rem">// we'll can play either 1 or 2 moves because we have doubles</span>
    <span class="kwrd">var</span> currentSpace = DoMove(options, player, board, drawnCard);
    
    <span class="rem">// if the player drew a double card, they move again  </span>
    <span class="kwrd">if</span>(drawnCard.isDouble &amp;&amp; !player.isWinner){
        DoMove(options, player, board, drawnCard ); <span class="rem">// do it again!</span>
    }
    
    <span class="kwrd">if</span>(player.isWinner){
        <span class="rem">// woohoo</span>
        <span class="kwrd">return</span> <span class="kwrd">true</span>;
    }
    
    <span class="rem">// if the space we landed on is a bridge, follow the bridge</span>
    <span class="kwrd">if</span>(currentSpace.bridgeTo){
        player.position = currentSpace.bridgeTo;
        currentSpace = board[player.position];
    }
          
    <span class="rem">// if we are now on a lose-a-turn space, turn on the </span>
    <span class="rem">// &quot;isLosingATurn&quot; property so we know </span>
    <span class="rem">// to skip our turn the next time around</span>
    <span class="kwrd">if</span>(currentSpace.loseTurn){
        player.isLosingATurn = <span class="kwrd">true</span>;
    }
}</pre>


The real workhorse in there is the call to DoMove, which actually advances the game token along the board:

<pre class="csharpcode">function DoMove(options, player, board, card){
    <span class="rem">// we'll cycle through the board. </span>
    <span class="rem">// if we have a regular color card (or double), we'll go </span>
    <span class="rem">// until we hit the color, OR reach the end of the board</span>
    var currentSpace;
    var iterations = 0;
    <span class="kwrd">do</span>{
        <span class="rem">// advance one space</span>
        player.position++;
    
        <span class="rem">// if we hit the end of the board</span>
        <span class="rem">// we start over if we have a character card</span>
        <span class="rem">// or we win if we have a regular color card</span>
        <span class="kwrd">if</span>(player.position == board.length){
            <span class="kwrd">if</span>(card.isCharacter){
                <span class="rem">// if we have a character card and we've reached the </span>
                <span class="rem">// end of the board, wrap around</span>
                player.position = 0;
            }
            <span class="kwrd">else</span>{
                <span class="rem">// if your move takes you to the last square or beyond, you win </span>
                <span class="rem">// set the &quot;isWinner&quot; property to true and exit</span>
                player.isWinner = <span class="kwrd">true</span>;
            }
        }
        currentSpace = board[player.position];

        <span class="rem">// loop until we find the space we're looking for</span>
        <span class="rem">// or we win</span>
        <span class="rem">// or we iterate 10000 times (because something must be broken)</span>
    }<span class="kwrd">while</span>(currentSpace 
           &amp;&amp; currentSpace.color != card.color 
           &amp;&amp; !player.isWinner &amp;&amp; ++iterations &lt; 10000);
    
    <span class="kwrd">return</span> currentSpace;
}</pre>


All this, including the source to the utility functions (e.g. DrawACard) is available [in the fiddle](http://jsfiddle.net/mharen/crgAX/35/). Here’s the working version:





In the next post I’ll do some additional testing and verification. A brief, casual comparison to other papers online reveals that my results are reasonable. I’m not saying they are correct, but I’m at least in the ball park for finding the length of an average game (around 45-50 cards).