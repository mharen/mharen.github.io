---
layout: post
date: '2010-11-03T23:59:00.000-04:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: 'Arduino Day 3: Psychedelic Fun With a Tri-Color LED'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

I picked up a tri-color RGB super-bright LED yesterday and had some fun playing around with it. The first thing I did was scour the Internet to figure out how to wire this thing up. It was surprisingly difficult to find a decent pin out and wiring guide. 

What threw me was that the LED doesn’t exactly get wired to ground. Instead, you wire the long pin to +5v and the short pins to digital outputs. Weird. I would guess it has something to do with a potential difference between the digital output [+0v,+5v] and the +5v supply. That is, pushing 100% on the digital output would cause a difference of 0v, and no light. 

If it wasn’t so late I’d go test this theory. Maybe tomorrow. If anyone can help me understand this, please do! 

Anyway, it works:  <div class="wlWriterEditableSmartContent" id="scid:5737277B-5D6D-4f48-ABFC-DD9C333F4C5D:9cfb83d2-86dd-4511-ac53-3c439f52af6a" style="padding-bottom: 0px; padding-left: 0px; width: 640px; padding-right: 0px; display: block; float: none; margin-left: auto; margin-right: auto; padding-top: 0px;">
<div id="acb20350-5e34-403a-874f-d196e1d817c8" style="margin: 0px; padding: 0px; display: inline;">
<div>[![video977fd9eb4c17%5B2%5D.jpg](video977fd9eb4c17%5B2%5D.jpg)](http://www.youtube.com/watch?v=jlUODWHTe8A" target="_new)</div></div></div>  <h4>Build</h4>

Today’s build was super easy once I wrapped my head around how this thing’s wired. The DIP switch isn’t needed—I was just playing around with one color at a time before I made the video.

![ANd9GcTYyj15MzFtgQ9H9cedX1F2NB3ODuRq15FicCAeoJ2.jpg](ANd9GcTYyj15MzFtgQ9H9cedX1F2NB3ODuRq15FicCAeoJ2.jpg)Speaking of super easy, has anyone played this game “Candyland”? It’s a bunch of crap. That game is like sooooo easy. It has one problem, though: you have to play it with three year olds who cheat. Oh, and it’s so boring. To pass the time, I try to imagine what it would be like to navigate that crazy candy world in real life. As I stack the deck with doubles, I picture Bruce Willis or pre-crazy Tom Cruise climbing up the side of a giant sugar crystal volcano or something. With some luck, Thing 1 “accidentally” lands on that go-to-the-end square and the torment is over.

On a brighter note, Thing 1 has almost grasped Go Fish, which is pretty magical to see unfold. For now. In a couple weeks…I don't know. It’s become clear to me why we were moved onto playing more sophisticated games as early as possible.

Oh yeah, the build:

![IMAG0680%5B7%5D.jpg](IMAG0680%5B7%5D.jpg)  <h4>Circuit</h4>

![day%20three%20-%20bb%5B9%5D.png](day%20three%20-%20bb%5B9%5D.png)  <h4>Schematic</h4>

![Day%203%20-%20schematic%5B6%5D.png](Day%203%20-%20schematic%5B6%5D.png)  <h4>Code</h4>

Today’s code is very straight forward. It basically just increases the intensity of each color a random amount (0-5 of 255) every 25ms. Once the color exceeds 255, I flip it to –255 so it can start counting to zero. I only write the absolute value to the pin so the effect is an intensity value that ramps up and down.

I was real nice this time and included comments, even though I usually hate comments (duplication at best, lies at worst).
<blockquote>   
```cs
int RPin = 9;
int BPin = 10;
int GPin = 11;

int Pins[] = { RPin, BPin, GPin };
int Vals[3];

#define PinsCount (sizeof(Pins) / sizeof(int))

void setup() {
  // put your setup code here, to run once:
  for(int i = 0; i < PinsCount; i++){
    // initialize output to random intensity
    pinMode(Pins[i], OUTPUT); 
    Vals[i] = 0;
  }
  
}

void loop() {
  // put your main code here, to run repeatedly: 
  for(int i = 0; i < PinsCount; i++){
    // add/subtract a random amount of intensity, wrapping around if necessary
    Vals[i] = (Vals[i] + random(6));
    
    // start counting toward zero, because the above item always adds
    if(Vals[i] > 255){ Vals[i] = -255; }
    
    // send the abs value since it could be [-255,255]
    analogWrite(Pins[i], abs(Vals[i]));
  }
  
  delay(25);
}
```

</blockquote>

<h4>Next Steps</h4>


This could turn into a neat toy if I just wire the LED to three potentiometers. Then kids could mix colors themselves. Hmmm…


I’ll put that on hold, though as I think I’ll be moving on to a new component. Maybe a buzzer?

---

### 3 comments

**Unknown said on 2010-11-04**

http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1159806494/3

Comment in the arduino forums that may explain RGB led some.

**Michael Haren said on 2010-11-04**

That's helpful, thanks. I guess I was right (rare!)

**Math Zombie said on 2010-11-04**

I hate candy land. It is so frustrating. It's like chutes and ladders. You have no control over anything and then you get the gumdrop or peanut or whatever and have to go back to the beginning. I used to stack the deck at the day care to make kids finish quickly. It is good to get them to practice counting and colors though.

