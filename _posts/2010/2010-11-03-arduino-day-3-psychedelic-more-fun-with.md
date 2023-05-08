---
layout: post
date: '2010-11-03T23:59:00.000-04:00'
categories:
- 30-days-of-arduino
- arduino
- code
- technology
title: 'Arduino Day 3: Psychedelic Fun With a Tri-Color LED'
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

I picked up a tri-color RGB super-bright LED yesterday and had some fun playing around with it. The first thing I did was scour the Internet to figure out how to wire this thing up. It was surprisingly difficult to find a decent pin out and wiring guide. 

What threw me was that the LED doesn’t exactly get wired to ground. Instead, you wire the long pin to +5v and the short pins to digital outputs. Weird. I would guess it has something to do with a potential difference between the digital output [+0v,+5v] and the +5v supply. That is, pushing 100% on the digital output would cause a difference of 0v, and no light. 

If it wasn’t so late I’d go test this theory. Maybe tomorrow. If anyone can help me understand this, please do! 

Anyway, it works:  

<iframe width="560" height="315" src="https://www.youtube.com/embed/jlUODWHTe8A" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

#### Build

Today’s build was super easy once I wrapped my head around how this thing’s wired. The DIP switch isn’t needed—I was just playing around with one color at a time before I made the video.

![](/assets/2010/day-3-candy-land.jpg)

Speaking of super easy, has anyone played this game “Candyland”? It’s a bunch of crap. That game is like sooooo easy. It has one problem, though: you have to play it with three year olds who cheat. Oh, and it’s so boring. To pass the time, I try to imagine what it would be like to navigate that crazy candy world in real life. As I stack the deck with doubles, I picture Bruce Willis or pre-crazy Tom Cruise climbing up the side of a giant sugar crystal volcano or something. With some luck, Thing 1 “accidentally” lands on that go-to-the-end square and the torment is over.

On a brighter note, Thing 1 has almost grasped Go Fish, which is pretty magical to see unfold. For now. In a couple weeks...I don't know. It’s become clear to me why we were moved onto playing more sophisticated games as early as possible.

Oh yeah, the build:

![](/assets/2010/day-3-IMAG0680.jpg) 

#### Circuit

![](/assets/2010/day_three_-_bb.png) 

#### Schematic

![](/assets/2010/Day_3_-_schematic.png) 

#### Code

Today’s code is very straight forward. It basically just increases the intensity of each color a random amount (0-5 of 255) every 25ms. Once the color exceeds 255, I flip it to –255 so it can start counting to zero. I only write the absolute value to the pin so the effect is an intensity value that ramps up and down.

I was real nice this time and included comments, even though I usually hate comments (duplication at best, lies at worst).

```c
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

#### Next Steps

This could turn into a neat toy if I just wire the LED to three potentiometers. Then kids could mix colors themselves. Hmmm...

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
