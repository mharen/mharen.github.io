---
layout: post
date: '2010-11-01T23:59:00.000-04:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: 'Arduino Day 1: Unpacking and Fun with LEDs'
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

Today is my first day with the Arduino, and the first day I’ve touched a microcontroller in almost a decade. Be gentle.

Since I don’t really have anything except random LEDs, that’s what I’ll get started with. But first, let’s unpack the board:

{% imagesize /assets/2010/IMAG0651.jpg:img %}

Oooo a neat red box! What’s inside?

{% imagesize /assets/2010/IMAG0653.jpg:img %}

{% imagesize /assets/2010/IMAG0654.jpg:img %}

I don’t really care about Madagascar, but I did watch those movies and apparantly just helped to protect some forest there so...I guess what I’m trying to say is, “you’re welcome, Madagascar”. Actually, no, you’re not welcome, Madagascar, you suck. Whenever I play Risk, you just sit there off the coast of Africa demanding an unreasonable number of troops to protect and I’m sick of it. 

OK, back to the present. Here we are:

{% imagesize /assets/2010/IMAG0655.jpg:img %}

This thing didn’t come with any directions so let’s just plug it in and see what happens:  

{% imagesize /assets/2010/installing_drivers.png:img %}
{% imagesize /assets/2010/device_ready.png:img %}

{% imagesize /assets/2010/IMAG0659.jpg:img %}

Excellent (see the yellow light in the middle?), and we didn’t let the smoke out yet! This board will take power from USB (or a DC plug), which is awfully convenient since I always have USB handy.

Time for a quick program. I downloaded the [Arduino software](http://arduino.cc/en/Main/Software), unzipped it, and fired it up (no install). 

{% imagesize /assets/2010/day-2-1.png:img %}

A blank window. Interesting. A friend had previously shown me this neat trick: go to File > Examples > Whatever:

{% imagesize /assets/2010/day-2-2.png:img %}

Here are dozens of neat examples to start with. I chose Basics > Fade to play around with the LEDs I had. The sample code just fades an LED on and off forever. After wiring up the board according to the [incredible directions](http://arduino.cc/en/Tutorial/Fade) on the site, it worked! Amazing.

That was cool to start with but I wanted to explore more. I added five more LEDs (six total), and played around with some different loops. Here’s what I ended up with (it’s dark so you can see the lights):

<iframe class="full-embed hd" src="https://www.youtube.com/embed/VbIfvKNeQZU" title="Arduino day 1: fun with LEDs" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

It’s a much better experience in person—my camera’s frame rate isn’t quite high enough and it had trouble focusing. But trust me, it was awesome. What you see is the program cycling through a bunch of different patterns: 

* Runway - like an airstrip 
* Flicker Digital – randomly flash the LEDs on/off 
* Flicker Analog – randomly change the intensity of the LEDs 
* Flash – flash all the LEDs on/off at the same time  


### Build:

{% imagesize /assets/2010/IMAG0661.jpg:img %}

Circuit (built with the amazing [Fritzing](http://fritzing.org/)):

{% imagesize /assets/2010/day_one_-_bb.png:img %}

Schematic (automatically built from the above image with the amazing [Fritzing](http://fritzing.org/)):

{% imagesize /assets/2010/day_one_-_schema.png:img %}

### Code:

```c
int Leds[] = {3, 5, 6, 9, 10, 11};
#define LedCount (sizeof(Leds)/sizeof(int)) //array size  

void setup()  { 
  for(int i=0; i<LedCount; i++){
    pinMode(Leds[i], OUTPUT);
  }
} 

void loop()  { 
  for(int i=0; i<10; i++){
    DoRunway();
  }
  
  Reset();
  
  for(int i=0; i<10; i++){
    DoFlickerDigital();
  }
  
  Reset();

  for(int i=0; i<10; i++){
    DoFlickerAnalog();
  }
  
  Reset();

  for(int i=0; i<10; i++){
    DoFlash();
  }

  Reset();
}

void Reset(){
  SetAll(0);
  delay(1000);
  SetAll(255);
  delay(100);
  SetAll(0);
  delay(1000);
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

This isn’t meant to be an example of fantastic code, obviously. ;)

Tomorrow I’ll try to dig up an input device or something to make this a little more interesting.

---

### 2 comments

**Michael Haren said on 2010-11-02**

Note: when I first posted this I forget to include the resistors in the circuit and schematic diagrams. They were in my build photo, but I only added them to the others just now (sorry!).

They're all 470ohm Rs, since I don't have anything smaller at the moment (220s would have been better).

Probably heading to Radio Shack later today if I can find one that's still open :/.

**Michael Haren said on 2010-11-02**

Thank you for your comment @Laura. It has inspired me to see to try and work in a rant each day. Today (day 2) is no exception.

Comments closed
{: .comments-closed }