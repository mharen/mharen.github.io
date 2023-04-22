---
date: '2010-11-01T23:59:00.000-04:00'
description: ''
published: true
slug: 2010-11-arduino-day-1-unpacking-and-fun-with
tags:
- http://schemas.google.com/blogger/2008/kind#post
- 30 Days Of Arduino
- Arduino
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Arduino Day 1: Unpacking and Fun with LEDs'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

Today is my first day with the Arduino, and the first day I’ve touched a microcontroller in almost a decade. Be gentle.

Since I don’t really have anything except random LEDs, that’s what I’ll get started with. But first, let’s unpack the board:

![IMAG0651%5B8%5D.jpg](IMAG0651%5B8%5D.jpg)

Oooo a neat red box! What’s inside?

![IMAG0653%5B4%5D.jpg](IMAG0653%5B4%5D.jpg)

![IMAG0654%5B4%5D.jpg](IMAG0654%5B4%5D.jpg)

I don’t really care about Madagascar, but I did watch those movies and apparantly just helped to protect some forest there so…I guess what I’m trying to say is, “you’re welcome, Madagascar”. Actually, no, you’re not welcome, Madagascar, you suck. Whenever I play Risk, you just sit there off the coast of Africa demanding an unreasonable number of troops to protect and I’m sick of it. 

OK, back to the present. Here we are:

![IMAG0655%5B3%5D.jpg](IMAG0655%5B3%5D.jpg)

This thing didn’t come with any directions so let’s just plug it in and see what happens:  

![device%20ready%5B2%5D.png](device%20ready%5B2%5D.png)

![IMAG0659%5B8%5D.jpg](IMAG0659%5B8%5D.jpg)

Excellent (see the yellow light in the middle?), and we didn’t let the smoke out yet! This board will take power from USB (or a DC plug), which is awfully convenient since I always have USB handy.

Time for a quick program. I downloaded the [Arduino software](http://arduino.cc/en/Main/Software), unzipped it, and fired it up (no install). 

![image%5B2%5D.png](image%5B2%5D.png)

A blank window. Interesting. A friend had previously shown me this neat trick: go to File &gt; Examples &gt; Whatever:

![image%5B5%5D.png](image%5B5%5D.png)

Here are dozens of neat examples to start with. I chose Basics &gt; Fade to play around with the LEDs I had. The sample code just fades an LED on and off forever. After wiring up the board according to the [incredible directions](http://arduino.cc/en/Tutorial/Fade) on the site, it worked! Amazing.

That was cool to start with but I wanted to explore more. I added five more LEDs (six total), and played around with some different loops. Here’s what I ended up with (it’s dark so you can see the lights):  <div class="wlWriterEditableSmartContent" id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:d92f78f6-efc4-42af-ab09-ed4eb0405f94" style="padding-bottom: 0px; padding-left: 0px; width: 640px; padding-right: 0px; display: block; float: none; margin-left: auto; margin-right: auto; padding-top: 0px;">
<div id="2649b3fc-913c-4411-b0b6-e7a0873571f7" style="margin: 0px; padding: 0px; display: inline;">
<div>[![videoc251df61edef%5B6%5D.jpg](videoc251df61edef%5B6%5D.jpg)](http://www.youtube.com/watch?v=VbIfvKNeQZU" target="_new)</div></div></div>

It’s a much better experience in person—my camera’s frame rate isn’t quite high enough and it had trouble focusing. But trust me, it was awesome. What you see is the program cycling through a bunch of different patterns:  <ul>   <li>Runway - like an airstrip </li>    <li>Flicker Digital – randomly flash the LEDs on/off </li>    <li>Flicker Analog – randomly change the intensity of the LEDs </li>    <li>Flash – flash all the LEDs on/off at the same time </li> </ul>

Build:

![IMAG0661%5B7%5D.jpg](IMAG0661%5B7%5D.jpg)

Circuit (built with the amazing [Fritzing](http://fritzing.org/)):

![day%20one%20-%20bb%5B6%5D.png](day%20one%20-%20bb%5B6%5D.png)

Schematic (automatically built from the above image with the amazing [Fritzing](http://fritzing.org/)):

![day%20one%20-%20schema%5B7%5D.png](day%20one%20-%20schema%5B7%5D.png)

Code:
<blockquote>   <pre class="csharpcode"><span class="kwrd">int</span> Leds[] = {3, 5, 6, 9, 10, 11};
<span class="preproc">#define</span> LedCount (<span class="kwrd">sizeof</span>(Leds)/<span class="kwrd">sizeof</span>(<span class="kwrd">int</span>)) <span class="rem">//array size  </span>

<span class="kwrd">void</span> setup()  { 
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;LedCount; i++){
    pinMode(Leds[i], OUTPUT);
  }
} 

<span class="kwrd">void</span> loop()  { 
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;10; i++){
    DoRunway();
  }
  
  Reset();
  
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;10; i++){
    DoFlickerDigital();
  }
  
  Reset();

  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;10; i++){
    DoFlickerAnalog();
  }
  
  Reset();

  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;10; i++){
    DoFlash();
  }

  Reset();
}

<span class="kwrd">void</span> Reset(){
  SetAll(0);
  delay(1000);
  SetAll(255);
  delay(100);
  SetAll(0);
  delay(1000);
}

<span class="kwrd">void</span> SetAll(<span class="kwrd">int</span> <span class="kwrd">value</span>){
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;LedCount; i++){
    analogWrite(Leds[i], <span class="kwrd">value</span>);
  }  
}

<span class="kwrd">void</span> DoRunway(){
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;LedCount; i++){
    analogWrite(Leds[i], 255);    
    analogWrite(Leds[(i + 1) % LedCount], 0);
    delay(100);
  }   
}

<span class="kwrd">void</span> DoFlickerDigital(){
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;LedCount; i++){
    analogWrite(Leds[i], random(1+1)*255);    
    delay(100);
  } 
}

<span class="kwrd">void</span> DoFlickerAnalog(){
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;LedCount; i++){
    analogWrite(Leds[i], random(255+1));    
    delay(100);
  } 
}

<span class="kwrd">void</span> DoFlash(){
  <span class="kwrd">int</span> State = 0;
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i=0; i&lt;LedCount; i++){
    SetAll(State * 255);
    State = (State + 1) % 2;  
    delay(100);
  } 
}</pre>
</blockquote>


This isn’t meant to be an example of fantastic code, obviously. ;)


Tomorrow I’ll try to dig up an input device or something to make this a little more interesting.

---

## 2 comments captured from [original post](https://blog.wassupy.com/2010/11/arduino-day-1-unpacking-and-fun-with.html) on Blogger

**Michael Haren said on 2010-11-02**

Note: when I first posted this I forget to include the resistors in the circuit and schematic diagrams. They were in my build photo, but I only added them to the others just now (sorry!).

They're all 470ohm Rs, since I don't have anything smaller at the moment (220s would have been better).

Probably heading to Radio Shack later today if I can find one that's still open :/.

**Michael Haren said on 2010-11-02**

Thank you for your comment @Laura. It has inspired me to see to try and work in a rant each day. Today (day 2) is no exception.

