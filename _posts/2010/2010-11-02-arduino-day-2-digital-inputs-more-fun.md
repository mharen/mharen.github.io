---
layout: post
date: '2010-11-02T17:34:00.001-04:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: 'Arduino Day 2: Digital Inputs (More Fun With LEDs)'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

I’m still familiarizing myself with everything Arduino so this next project is a simple modification to my [day-1 LED project](../2010/2010-11-arduino-day-1-unpacking-and-fun-with.html). I’ve added some dip switches to control which pattern will appear on the LEDs. Here’s the result:  <div class="wlWriterEditableSmartContent" id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:2ed362dc-459a-49ec-9778-b92c1de822e0" style="padding-bottom: 0px; padding-left: 0px; width: 640px; padding-right: 0px; display: block; float: none; margin-left: auto; clear: both; margin-right: auto; padding-top: 0px;">
<div id="dc2e06b9-c0bb-4d0d-af51-271a66a5afda" style="margin: 0px; padding: 0px; display: inline;">
<div>[![video24e262f99644%5B73%5D.jpg](video24e262f99644%5B73%5D.jpg)](http://www.youtube.com/watch?v=sQcut-JRXqY" target="_new)</div></div></div>

It’s really pretty simple. For switches 0 and 1, I have the hot line coming through an LED, through the switch, and then split between a resistor to ground and a digital input on the board. I’m not certain I have this right, but it works and my board hasn’t melted so it’s good enough for me.

In code I watch the two switch inputs and do a basic binary check to turn these two bits into four options (off/off, off/on, on/off, on/on). On…off…that reminds me of the [Karate Kid](http://www.imdb.com/title/tt0087538/). 

![image%5B2%5D.png](image%5B2%5D.png)In the Karate Kid, this old guy befriends a teenager after beating a bunch of bullies senseless. Through couldn’t-work-in-a-million-years training, Mr. Miyagi (the old guy) eventually leads the annoying kid (Daniel-san) to victory at the local Karate championship, and thereby winning the heart of Captain-Bully-Bag-Of-Many-Douches’s ex-girlfriend. 

A few things: first of all, this story is complete crap. You can’t defeat a bunch of black belts using your wax-on/wax-off skills (on/off—that’s what got me onto this rant). Second of all, Miyagi should be arrested for his shenanigans. Third, I loved this movie more than life itself when I was two years old; give me a break, family. Actually, you should be ashamed of yourselves, family—I was two—what’s your excuse? I watched this movie again a few weeks ago and it was awful.

Ah memories! Back to the project:

Build:

![IMAG0665%5B4%5D.jpg](IMAG0665%5B4%5D.jpg)

![IMAG0668%5B11%5D.jpg](IMAG0668%5B11%5D.jpg)

<span class="Apple-style-span" style="line-height: 18px; font-family: 'Trebuchet MS', trebuchet, sans-serif; font-size: 13px;">Circuit (built with the amazing<span class="Apple-converted-space">&#160;[Fritzing](http://fritzing.org/" style="color: rgb(30,96,225); text-decoration: none;)):</span></span>

![day%20two%20-%20bb%5B6%5D.png](day%20two%20-%20bb%5B6%5D.png)

<span class="Apple-style-span" style="line-height: 18px; font-family: 'Trebuchet MS', trebuchet, sans-serif; font-size: 13px;">Schematic (automatically built from the above image with the amazing<span class="Apple-converted-space">&#160;[Fritzing](http://fritzing.org/" style="color: rgb(30,96,225); text-decoration: none;)):</span></span>

<span class="Apple-style-span" style="line-height: 18px; font-family: 'Trebuchet MS', trebuchet, sans-serif; font-size: 13px;">![day%20two%20-%20schema%5B7%5D.png](day%20two%20-%20schema%5B7%5D.png)</span>

<span class="Apple-style-span" style="line-height: 18px; font-family: 'Trebuchet MS', trebuchet, sans-serif; font-size: 13px;">Code:</span>
<blockquote>   
```cs
int SwitchPin0 = 2;
int SwitchPin1 = 4;
int Leds[] = {3, 5, 6, 9, 10, 11};
#define LedCount (sizeof(Leds)/sizeof(int)) //array size  

void setup()  { 
  for(int i=0; i<LedCount; i++){
    pinMode(Leds[i], OUTPUT);
  }
  
  pinMode(SwitchPin0, INPUT);
  pinMode(SwitchPin1, INPUT);
} 

void loop()  { 
  
  int SwitchValue0 = digitalRead(SwitchPin0);
  int SwitchValue1 = digitalRead(SwitchPin1);
  
  if(SwitchValue0 == LOW &amp;&amp; SwitchValue1 == LOW){
    DoFlash();
  }
  else if(SwitchValue0 == LOW &amp;&amp; SwitchValue1 == HIGH){
    DoRunway();
  }
  else if(SwitchValue0 == HIGH &amp;&amp; SwitchValue1 == LOW){
    DoFlickerDigital();
  }
  else {
    DoFlickerAnalog();
  }
}

void SetAll(int value){
  for(int i=0; i<LedCount; i++){
    analogWrite(Leds[i], value);
  }  
}

void DoRunway(){
  for(int i=0; i<LedCount; i++){
    analogWrite(Leds[i], 255);    
    analogWrite(Leds[(i + 1) % LedCount], 0);
    delay(100);
  }   
}

void DoFlickerDigital(){
  for(int i=0; i<LedCount; i++){
    analogWrite(Leds[i], random(1+1)*255);    
    delay(100);
  } 
}

void DoFlickerAnalog(){
  for(int i=0; i<LedCount; i++){
    analogWrite(Leds[i], random(255+1));    
    delay(100);
  } 
}

void DoFlash(){
  int State = 0;
  for(int i=0; i<LedCount; i++){
    SetAll(State * 255);
    State = (State + 1) % 2;  
    delay(100);
  } 
}
```

</blockquote>


Next plans


I went out to Radio Shack to pick up a few things and apparently they only sell phones and batteries now? Even though the salesman assured me they don’t have anything like an “LED” or a “resistor”, I found a dusty cabinet in the back with some nice stuff. I picked up a 5kΩ potentiometer, a bunch of random LEDs, a couple push buttons, some 220Ω resistors, and a piezo buzzer. 


I was hoping to get a smaller breadboard and a pack of ready-to-use wires since what I have are a bit brittle, but no dice. I was actually a little surprised that they didn’t have a whole Arduino/microcontroller section. This stuff is really, really popular among geeks and it seems to me that “The Shack” (as I’m supposed to call it now) is missing out on an opportunity to become relevant again.


Oh well. I got enough to keep me going a few more days so see you tomorrow!

---

## 4 comments captured from [original post](https://blog.wassupy.com/2010/11/arduino-day-2-digital-inputs-more-fun.html) on Blogger

**Math Zombie said on 2010-11-02**

But MOOOOOOOOOOOmmmm, maybe he won't win this time, let's watch it again.

**Sarah said on 2010-11-02**

Chris and Pat, I enjoy your comments :)

**Michael Haren said on 2011-10-10**

Renan,

Are you sounding the note with the Arduino or with your guitar?

If it's with the Arduino, are you having trouble sounding notes or lighting LEDs or simply doing both at the same time?

If it's with the guitar, what type of sensor are you using to get the sound input into the arduino?

**Renan Abud said on 2011-10-25**

Thanks for the reply. I'm trying to make sounds and blink leds at the same time.

see the video please: http://www.youtube.com/watch?v=XL0XsPI8iOg

its a twelve lights metronom like a clock. When the led 12 blinks I want a tone of the arduino's library for example. Each led have his respective note. Do you have an idea how can I make it? Like when the led12 is on tone y on

