---
date: '2010-11-14T23:56:00.001-05:00'
description: ''
published: true
slug: 2010-11-arduino-day-14-simple-conductivity
tags:
- http://schemas.google.com/blogger/2008/kind#post
- 30 Days Of Arduino
- Arduino
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Arduino Day 14: Simple Conductivity Sensor'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> This post is part of <a href="http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino">a series</a> on my adventures with Arduino</div>
<p>In keeping with the traffic light theme of the past few days, I built a ridiculously simple conductivity sensor with an analog input. Place something between the two leads to determine if it is highly conductive, somewhat conductive, or barely or not at all conductive. Like this:</p>  <p align="center"></p>
<p>Yes, that’s Thing 1’s leftovers from lunch (or maybe Thing 2…). Her sandwich bread is somewhat conductive (yellow), but the ham inside is very conductive (green), as is the apple sauce.</p>
<p>Why is the applesauce dark red? Good Question. It’s homemade, and the best we can figure, the apples just turned brown as they normally do when cut.</p>  <h4>Build</h4>
<p>The build is identical to the previous few days with a simple analog input added the same way as the CdS cell in <a href="../2010/2010-11-arduino-day-6-analog-inputs.html" target="_blank">another build</a> (I used a 10kΩ resistor instead of 470Ω, though).</p>
<p>![IMAG0782%5B3%5D.jpg](IMAG0782%5B3%5D.jpg)</p>  <h4>Code</h4>
<blockquote>   <pre class="csharpcode"><span class="kwrd">const</span> <span class="kwrd">int</span> BuzzPin = 5;
<span class="kwrd">const</span> <span class="kwrd">int</span> BuzzDuration = 50; 
<span class="kwrd">const</span> <span class="kwrd">int</span> Tones[] = { 1000, 2000, 3000 };
<span class="kwrd">const</span> <span class="kwrd">int</span> LedPins[] = { 9, 10, 11 };
<span class="kwrd">const</span> <span class="kwrd">int</span> SignalPin = 0;

<span class="kwrd">void</span> setup() {
  pinMode(LedPins[0], OUTPUT);    
  pinMode(LedPins[1], OUTPUT);    
  pinMode(LedPins[2], OUTPUT);    
  pinMode(BuzzPin, OUTPUT);
}

<span class="rem">// keep track of which LED is lit</span>
<span class="kwrd">int</span> ActiveLed = -1;

<span class="kwrd">void</span> loop() {
  <span class="rem">// grab the singal from the analog input</span>
  <span class="kwrd">int</span> Val = analogRead(SignalPin);
  <span class="kwrd">int</span> Led;

  <span class="rem">// red (no signal)</span>
  <span class="kwrd">if</span>(Val &lt; 100){
    Led = 2;
  }
  
  <span class="rem">// yellow (some signal)</span>
  <span class="kwrd">else</span> <span class="kwrd">if</span>(Val &lt; 500){
    Led = 1; 
  }
  
  <span class="rem">// green (lotsa signal)</span>
  <span class="kwrd">else</span>{
    Led = 0;
  }

  <span class="rem">// if a different LED should be lit, change it</span>
  <span class="kwrd">if</span>(Led != ActiveLed){
    <span class="rem">// turn off the currently lit LED</span>
    digitalWrite(LedPins[ActiveLed], LOW);

    <span class="rem">// light the new one</span>
    digitalWrite(LedPins[Led], HIGH);
    Ding(Led);
 
    <span class="rem">// remember me</span>
    ActiveLed = Led;
  }
  delay(50);
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
}</pre>
</blockquote>

<h4>Next Steps</h4>

<p>I’ve got a lot of travel this week so doing projects will be very challenging…but we’ll see!</p>