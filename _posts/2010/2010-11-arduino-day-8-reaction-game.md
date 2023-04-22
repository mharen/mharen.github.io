---
layout: post
date: '2010-11-08T23:30:00.001-05:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: "Arduino Day 8: \u201CReaction\u201D Game"
---

<div style="border-top: #888 1px solid; border-right: #888 1px solid; border-bottom: #888 1px solid; float: right; padding-bottom: 5px; padding-top: 5px; padding-left: 5px; margin: 0px auto; border-left: #888 1px solid; padding-right: 5px; width: 200px; background-color: #eee;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

Today’s build combines a lot of the skills I’ve learned so far. It’s a simple game you’ve probably played before. It works like this for two players (though any number is possible): <ol> <li>Each player gets a clicker  <li>When the buzzer sounds and the center light illuminates, hit our clicker as fast as you can  <li>The first player to click wins </li></ol>

Here’s the finished project: 



I don’t have anything to rant about today so I’ll instead direct you to this rather entertaining interview with [David Sedaris](http://www.thedailyshow.com/watch/thu-november-4-2010/david-sedaris" target="_blank). If you don’t know who that is, you probably won’t find it funny. In that case, [this](http://www.collegehumor.com/videos/playlist:prankwar" target="_blank) type of humor probably more your style.  <h4>Build</h4>

![Sketch_schem%5B7%5D.png](Sketch_schem%5B7%5D.png) <h4>Code</h4><pre class="csharpcode"><span class="kwrd">const</span> <span class="kwrd">int</span> ToneHz = 2000;
<span class="kwrd">const</span> <span class="kwrd">int</span> P1ButtonPin = 3;
<span class="kwrd">const</span> <span class="kwrd">int</span> P1LedPin = 4;
<span class="kwrd">const</span> <span class="kwrd">int</span> BuzzPin = 5;
<span class="kwrd">const</span> <span class="kwrd">int</span> P2LedPin = 6;
<span class="kwrd">const</span> <span class="kwrd">int</span> P2ButtonPin = 7;
<span class="kwrd">const</span> <span class="kwrd">int</span> BuzzDuration = 100; 

<span class="kwrd">void</span> setup() {
  pinMode(P1LedPin, OUTPUT);
  pinMode(BuzzPin, OUTPUT);
  pinMode(P2LedPin, OUTPUT);
  
  <span class="rem">// boot test</span>
  digitalWrite(P1LedPin, HIGH);
  delay(200);
  digitalWrite(P1LedPin, LOW);
  digitalWrite(P2LedPin, HIGH);
  delay(200);
  digitalWrite(P2LedPin, LOW);
  Buzz(ToneHz, BuzzDuration * 2);
}

<span class="rem">// our main loop will look at the game state to </span>
<span class="rem">// figure out what to do. when the state's not changing,</span>
<span class="rem">// things like buzzing or reading input will occur</span>
<span class="rem">// repeatedly, very fast</span>

<span class="kwrd">enum</span> GameState {
 InsertCoin, <span class="rem">// waiting for player to start game</span>
 Pounce,     <span class="rem">// about to buzz (sleeping random amount)</span>
 Bzzzzz,     <span class="rem">// buzzing (waiting for button)</span>
 Woohoo      <span class="rem">// player 1 or 2 pressed first</span>
};

<span class="rem">// randomly start with p1 or p2</span>
<span class="kwrd">int</span> Victor = random(1,3);

<span class="rem">// start in the finished state because that sets up some things for us</span>
GameState State = Woohoo;

<span class="kwrd">void</span> loop() {
  <span class="rem">// these pins get reference a lot so just figure it out at the beginning</span>
  <span class="kwrd">int</span> LastWinnerLedPin = Victor == 1? P1LedPin : P2LedPin;
  <span class="kwrd">int</span> LastWinnerButtonPin = Victor == 1? P1ButtonPin : P2ButtonPin;

  <span class="kwrd">int</span> P1; <span class="kwrd">int</span> P2;
  <span class="kwrd">switch</span>(State){
    <span class="kwrd">case</span> InsertCoin:
      <span class="kwrd">if</span>(digitalRead(LastWinnerButtonPin)){
        <span class="rem">// let's go!</span>
        digitalWrite(LastWinnerLedPin, LOW); 
        State = Pounce;
      }
      <span class="kwrd">break</span>;
    
    <span class="kwrd">case</span> Pounce:
      State = Bzzzzz;
      
      <span class="rem">// don't buzz for 1-7 seconds (the suspense is intense)</span>
      delay(random(1000,7000));
      <span class="kwrd">break</span>;
      
    <span class="kwrd">case</span> Bzzzzz:
      Buzz(ToneHz, BuzzDuration / 5);
      
      P1 = digitalRead(P1ButtonPin);
      P2 = digitalRead(P2ButtonPin);
      
      <span class="kwrd">if</span>(P1 || P2){
        <span class="rem">// note the victor and move on to the next state</span>
        <span class="rem">// I suppose this gives a teeny advantage to player 1 since it gets checked first</span>
        Victor = P1? 1 : 2;
        State = Woohoo;
      }
      <span class="kwrd">break</span>;
      
    <span class="kwrd">case</span> Woohoo:
      <span class="rem">// light up the victor</span>
      digitalWrite(LastWinnerLedPin, HIGH);
      
      <span class="rem">// pseudo debouce</span>
      delay(500);
      
      <span class="rem">// signal a victory</span>
      BlinkAFewTimes(LastWinnerLedPin);
      
      <span class="rem">// go back to idle</span>
      State = InsertCoin;
      <span class="kwrd">break</span>;
  }
  
}

<span class="kwrd">void</span> Buzz(<span class="kwrd">int</span> frequencyHz, <span class="kwrd">int</span> durationMillis){
  <span class="rem">// e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low</span>
  <span class="rem">// to create 50% duty cycle</span>
  <span class="rem">// http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692</span>
  <span class="kwrd">int</span> Osc = 1000000 / frequencyHz / 2; <span class="rem">// in microseconds</span>
  
  <span class="rem">// compute the number of iterations needed to hold</span>
  <span class="rem">// the nfote the desired duration</span>
  <span class="kwrd">int</span> Iterations = frequencyHz * ((<span class="kwrd">float</span>)durationMillis / 1000);
  
  <span class="kwrd">for</span> (<span class="kwrd">long</span> i = 0; i &lt; Iterations; i++ )
  {
      <span class="rem">// beep!</span>
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
}

<span class="kwrd">void</span> BlinkAFewTimes(<span class="kwrd">int</span> pin){
  BlinkOnce(pin);
  BlinkOnce(pin);
}

<span class="kwrd">void</span> BlinkOnce(<span class="kwrd">int</span> pin){
  digitalWrite(pin, LOW); 
  delay(50);
  digitalWrite(pin, HIGH); 
  delay(50);  
}</pre>
<h4>Next Steps</h4>

While this project could certainly be improved (e.g. holding down your button insures victory when instead you should lose for pressing it early), I’m satisfied with it.

I might try to build a Simon game tomorrow. Special thanks to [@corsae](http://twitter.com/#!/corsae/status/1655470213300224) for a nice list of project ideas.

---

## 2 comments captured from [original post](https://blog.wassupy.com/2010/11/arduino-day-8-reaction-game.html) on Blogger

**Sarah said on 2010-11-08**

Very nice :)  Thank you for letting me win on that last turn ;)

**Math Zombie said on 2010-11-09**

The music in your video is kind of ominous.

