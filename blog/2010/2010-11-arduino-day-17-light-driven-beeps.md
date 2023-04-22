---
date: '2010-11-17T22:02:00.001-05:00'
description: ''
published: true
slug: 2010-11-arduino-day-17-light-driven-beeps
tags:
- http://schemas.google.com/blogger/2008/kind#post
- 30 Days Of Arduino
- Arduino
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Arduino Day 17: Light Driven Beeps'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> This post is part of <a href="http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino">a series</a> on my adventures with Arduino</div>
<p>Today’s build was a fun one for Thing 1. It’s basically just two CdS light sensors tied to a set of LEDs and a buzzer. If you cover either of the sensors (or both), a different tone plays and an LED lights. Like so:</p>  <p align="center"></p>  <h4>Build</h4>
<p><a href="http://lh6.ggpht.com/_IKD9WtY5kxU/TOSXMOHtVAI/AAAAAAAABQQ/oaz_6XPw-jo/s1600-h/IMAG0809%5B5%5D.jpg"><img alt="IMAG0809" height="420" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TOSXM47BKYI/AAAAAAAABQU/9oJtomQnt-Q/IMAG0809_thumb%5B4%5D.jpg" style="margin: 0px auto; display: block; float: none;" title="IMAG0809" width="700" /></a><a href="http://lh4.ggpht.com/_IKD9WtY5kxU/TOSXNTA-S3I/AAAAAAAABQY/NSfRGY5dXBw/s1600-h/IMAG0806%5B4%5D.jpg"><img alt="IMAG0806" height="419" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TOSXOHRad2I/AAAAAAAABQc/HXnSApTTvyw/IMAG0806_thumb%5B1%5D.jpg" style="margin: 0px auto; display: block; float: none;" title="IMAG0806" width="700" /></a><a href="http://lh5.ggpht.com/_IKD9WtY5kxU/TOSXOrAiJDI/AAAAAAAABQg/nnWJ8_Txxo0/s1600-h/IMAG0800%5B7%5D.jpg"><img alt="IMAG0800" height="419" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TOSXPU178cI/AAAAAAAABQk/m4YNyfTu9yQ/IMAG0800_thumb%5B2%5D.jpg" style="margin: 3px auto; display: block; float: none;" title="IMAG0800" width="700" /></a></p>
<p><a href="http://lh4.ggpht.com/_IKD9WtY5kxU/TOSXP2SUtQI/AAAAAAAABQo/spDqQZ5GTzY/s1600-h/IMAG0803%5B5%5D.jpg"><img alt="IMAG0803" height="419" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TOSXQZ73c6I/AAAAAAAABQs/mKgHAnuMpPI/IMAG0803_thumb.jpg" style="margin: 0px auto; display: block; float: none;" title="IMAG0803" width="700" /></a></p>  <h4>Code</h4>
<p>There’s nothing too fancy going on here. The only real trick (if you can call it that) is to read in the ambient analog values at startup so you can compare against them later. This is much more effective than hard-coding a threshold.</p>
<blockquote>   <pre class="csharpcode"><span class="kwrd">const</span> <span class="kwrd">int</span> BuzzPin = 5;
<span class="kwrd">const</span> <span class="kwrd">int</span> BuzzDuration = 50; 
<span class="kwrd">const</span> <span class="kwrd">int</span> Tones[] = { 800, 1000, 1200 };
<span class="kwrd">const</span> <span class="kwrd">int</span> LedPins[] = { 9, 10, 11 };
<span class="kwrd">const</span> <span class="kwrd">int</span> CdsPins[] = { 0, 1 };
<span class="kwrd">int</span> ActiveLed = -1;
<span class="kwrd">int</span> CdsSquelch[2];

<span class="kwrd">void</span> setup() {
  Serial.begin(9600);

  pinMode(LedPins[0], OUTPUT);    
  pinMode(LedPins[1], OUTPUT);    
  pinMode(LedPins[2], OUTPUT);    
  pinMode(BuzzPin, OUTPUT);

  <span class="rem">// read in the ambient light value to be used as a threshold</span>
  <span class="rem">// this is helpful since the amount of ambient light changes all the time</span>
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i &lt; 2; i++){
    CdsSquelch[i] = analogRead(CdsPins[i]);
  }  
}

<span class="kwrd">void</span> loop() {
  boolean CdsReads[2];
  <span class="kwrd">int</span> Led;
  
  <span class="rem">// convert the CdS values into a boolean</span>
  <span class="rem">// - true if the light detected is less than 90% of ambient</span>
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i &lt; 2; i++){
    CdsReads[i] = analogRead(CdsPins[i]) &lt; CdsSquelch[i] * .9;
  }

  <span class="rem">// if both cells are covered...</span>
  <span class="kwrd">if</span>(CdsReads[0] &amp;&amp; CdsReads[1]){
    Led = 1; 
  }  
  <span class="rem">// if one cell is covered</span>
  <span class="kwrd">else</span> <span class="kwrd">if</span>(CdsReads[0]){
    Led = 0; 
  }
  <span class="rem">// if the other cell is covered</span>
  <span class="kwrd">else</span> <span class="kwrd">if</span>(CdsReads[1]){
    Led = 2; 
  }
  <span class="rem">// if neither cell is covered</span>
  <span class="kwrd">else</span>{
    Led = -1; 
  }
  
  <span class="rem">// if something is covered, beep and blink</span>
  <span class="kwrd">if</span>(Led != -1){
    Ding(Led); 
    digitalWrite(LedPins[Led], HIGH);
  }
  
  <span class="rem">// turn off the previously lit LED if necessary</span>
  <span class="kwrd">if</span>(Led != ActiveLed){
    digitalWrite(LedPins[ActiveLed], LOW);
    ActiveLed = Led;
  }
}

<span class="kwrd">void</span> Ding(<span class="kwrd">int</span> light){
  <span class="rem">// e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low</span>
  <span class="rem">// to create 50% duty cycle</span>
  <span class="rem">// http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692</span>
  <span class="kwrd">int</span> Osc = 1000000 / Tones[light] / 4; <span class="rem">// in microseconds</span>
  
  <span class="rem">// compute the number of iterations needed to hold</span>
  <span class="rem">// the nfote the desired duration</span>
  <span class="kwrd">int</span> Iterations = Tones[light] * ((<span class="kwrd">float</span>)200 / 1000);
  
  <span class="rem">// play tone</span>
  <span class="kwrd">for</span> (<span class="kwrd">long</span> i = 0; i &lt; Iterations; i++ )
  {
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
}</pre></blockquote>