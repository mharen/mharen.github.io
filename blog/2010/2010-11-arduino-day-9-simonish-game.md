---
date: '2010-11-09T23:38:00.001-05:00'
description: ''
published: true
slug: 2010-11-arduino-day-9-simonish-game
tags:
- http://schemas.google.com/blogger/2008/kind#post
- 30 Days Of Arduino
- Arduino
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Arduino Day 9: Simon(ish) Game'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> This post is part of <a href="http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino">a series</a> on my adventures with Arduino</div>
<p>I built another game on top of <a href="http://blog.wassupy.com/2010/11/arduino-day-8-reaction-game.html" target="_blank">yesterday’s circuit</a>. I think you’ll probably recognize it:</p>  <p align="center"></p>
<p>The first time Wife tried this (she pretends to be interested, which I’m pretty sure is love) she shocked me by playing for six minutes straight, successfully knocking out a 27 bit sequence. Random chance would put that at 1 in 134217728 (0.0000007%)…it’s probably legit.</p>
<p><img align="right" alt="image" height="103" src="http://lh6.ggpht.com/_IKD9WtY5kxU/TNojCDIT8wI/AAAAAAAABPQ/y7-UJRCekVc/image%5B3%5D.png" style="margin: 0px; display: inline; float: right;" title="image" width="300" />Speaking of 007, did anyone see those last two Bond movies? Daniel Craig is way, way more badass than Pierce Brosnan. Nothing personal, P, but Daniel Craig could go on a hunger strike, float around on the international space station for 6 months (where he will lose considerable muscle and bone mass), return to relax peacefully among nature (squirrels and birds and whatnot), and still break your hand (and possibly arm) with his face when you sucker punch him in it. And only then would he go get something to eat like a taco or burger or something.</p>
<p>I know the above to be true when compared to Roger Moore, also, because I saw his “performance” in Moonraker and it was lame. I admit that I haven’t recently seen any of the other Bonds. </p>  <h4>Build</h4>
<p><img alt="DSC_0012" height="406" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TNoh028DSSI/AAAAAAAABPA/iHvikrfWUtw/DSC_0012%5B3%5D.jpg" style="margin: 0px auto; display: block; float: none;" title="DSC_0012" width="700" /><img alt="DSC_0013" height="391" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TNoh1reMXrI/AAAAAAAABPE/aGzt_itnn5Q/DSC_0013%5B3%5D.jpg" style="margin: 0px auto; display: block; float: none;" title="DSC_0013" width="700" /></p>
<p>Special thanks to Wife’s awesome camera for giving me all that sweet, delicious bokeh you see above. <small>Apparently I’m required by law to list this info, too: 116mm 1/50 f/4.8 ISO200</small>.</p>  <h4>Circuit</h4>
<p><img alt="Sketch_bb" height="322" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TNoh2TYbSkI/AAAAAAAABPI/Oz-zLoARA48/Sketch_bb%5B6%5D.png" style="margin: 0px auto; display: block; float: none;" title="Sketch_bb" width="495" /></p>  <h4>Schematic</h4>
<p><img alt="Sketch_schem" height="525" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TNoh29tFD7I/AAAAAAAABPM/0f-biC2vSE4/Sketch_schem%5B7%5D.png" style="margin: 0px auto; display: block; float: none;" title="Sketch_schem" width="700" /></p>  <h4>Code</h4>
<p>This program follows a typical “game loop” approach where the game is in one of a few states waiting for something to happen at any given time. The only thing close to a trick is how I maintain a sequence of tones. Rather than compute and store a known sequence, I just use the built in random number generator. Since I can seed the generator with whatever I want, I can replay the same sequence over and over again.</p>
<p>It worked out very nicely, actually, and all I have to do to start a new game is reseed the generator to a random value.</p>
<blockquote>   <pre class="csharpcode"><span class="kwrd">const</span> <span class="kwrd">int</span> BuzzPin = 5;
<span class="kwrd">const</span> <span class="kwrd">int</span> BuzzDuration = 100; 

<span class="kwrd">int</span> ButtonPins[] = { 3, 7 };
<span class="kwrd">int</span> Tones[] = { 2000, 3000, 1000 };
<span class="kwrd">int</span> LedPins[] = { 4, 6, 5 };

<span class="kwrd">void</span> setup() {
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i &lt; 3; i++){
    pinMode(LedPins[i], OUTPUT);    
    Ding(i);  <span class="rem">// boot test</span>
  }
}

<span class="rem">// our main loop will look at the game state to </span>
<span class="rem">// figure out what to do</span>
<span class="kwrd">enum</span> GameState {
  InsertCoin, <span class="rem">// waiting for player to start game</span>
  Teach,      <span class="rem">// buzzing a random sequence, increasing by one element each time</span>
  Test,       <span class="rem">// checking user-entered sequence</span>
  Boo         <span class="rem">// you've lost</span>
};

<span class="rem">// start in the finished state because that sets up some things for us</span>
GameState State = InsertCoin;

<span class="rem">// pick a seed value for the random number generator</span>
<span class="rem">// we'll reuse this each time the sequence is played so we get the same sequence</span>
<span class="kwrd">int</span> Seed;

<span class="rem">// keeps track of how many tones there are in the sequence</span>
<span class="kwrd">int</span> Taps;

<span class="kwrd">void</span> loop() {
  <span class="kwrd">switch</span>(State){
    <span class="kwrd">case</span> InsertCoin:
      <span class="rem">// light up both sides to suggest the user tap one to start</span>
      digitalWrite(LedPins[0], HIGH); 
      digitalWrite(LedPins[1], HIGH); 
      
      GetPress();

      <span class="rem">// let's go!</span>
      Taps = 0;
      Seed = analogRead(0); <span class="rem">// pick a new sequence seed</span>

      digitalWrite(LedPins[0], LOW); 
      digitalWrite(LedPins[1], LOW); 

      State = Teach;
      delay(1000);
      
      <span class="kwrd">break</span>;
    
    <span class="kwrd">case</span> Teach:
      <span class="rem">// add one to the sequence and play what we have so far</span>
      Taps++;

      randomSeed(Seed);
      <span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i &lt; Taps; i++){
        Ding(random(0,2));
        delay(100);
      }

      State = Test;
      <span class="kwrd">break</span>;
      
    <span class="kwrd">case</span> Test:
      randomSeed(Seed);
      <span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i &lt; Taps; i++){
        <span class="kwrd">int</span> Tap = GetPress();
        <span class="kwrd">int</span> ExpectedTap = random(0,2);
        <span class="kwrd">if</span>(Tap != ExpectedTap){
          <span class="rem">// you fail</span>
          State = Boo; 
          <span class="kwrd">return</span>;
        }
      }      
      
      <span class="rem">// if we make it through the entire test, good job!</span>
      <span class="rem">// add another note</span>
      State = Teach;
      delay(1000);
      <span class="kwrd">break</span>;
      
    <span class="kwrd">case</span> Boo:
      <span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i&lt;5; i++){
        Ding(2);
      }
  
      State = InsertCoin;
      delay(1000);
      <span class="kwrd">break</span>;
  }
}

<span class="rem">// this function blocks until a button is pressed</span>
<span class="kwrd">int</span> GetPress(){
  <span class="kwrd">int</span> P1; <span class="kwrd">int</span> P2;
  
  <span class="kwrd">do</span> {
    P1 = digitalRead(P1ButtonPin);
    P2 = digitalRead(P2ButtonPin);

  } <span class="kwrd">while</span>(!(P1 || P2));
  
  <span class="kwrd">int</span> Key = P1? 0 : 1;
  Ding(Key);

  <span class="kwrd">return</span> Key;  
}

<span class="kwrd">void</span> Ding(<span class="kwrd">int</span> light){
  <span class="rem">// e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low</span>
  <span class="rem">// to create 50% duty cycle</span>
  <span class="rem">// http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692</span>
  <span class="kwrd">int</span> Osc = 1000000 / Tones[light] / 2; <span class="rem">// in microseconds</span>
  
  <span class="rem">// compute the number of iterations needed to hold</span>
  <span class="rem">// the nfote the desired duration</span>
  <span class="kwrd">int</span> Iterations = Tones[light] * ((<span class="kwrd">float</span>)200 / 1000);
  
  <span class="rem">// light on</span>
  digitalWrite(LedPins[light], HIGH);
  
  <span class="rem">// play tone</span>
  <span class="kwrd">for</span> (<span class="kwrd">long</span> i = 0; i &lt; Iterations; i++ )
  {
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
  
  <span class="rem">// light off</span>
  digitalWrite(LedPins[light], LOW);
}</pre>
</blockquote>

<h4>Next Steps</h4>

<p>I’ll try to knock out another simple game tomorrow, and hopefully by Thursday I’ll have another component or two to play with. If not, I might be cracking open some household electronics for parts…</p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2010/11/arduino-day-9-simonish-game.html) on Blogger

**Sarah said on 2010-11-09**

Like. :)  I am very impressed that you used the term &quot;bokeh&quot; properly in a sentence!  And I think it is hilarious that you posted the stats of your photo :P

