---
layout: post
date: '2010-11-07T23:59:00.000-05:00'
categories:
- 30-days-of-arduino
- arduino
- code
- technology
title: 'Arduino Day 7: Buttons and Buzzers'
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

I had very limited time to build today so I’m afraid I don’t have much to show for it. Part of the problem was a lack of ideas, too. I think I need to bite off a bigger, multi-day project. I have some things in mind...

A big benefit to the simple build, though, was that Thing1 was actually interested enough to help from start to finish (*five *minutes). She helped me with wires and button placement and played with the buttons while I coded it up, and then played with the buttons again once they did something.

Here we go:  

<iframe width="640" height="385" src="https://www.youtube.com/embed/_BNAhP3OazQ" title="Arduino Day 7: Buttons and Buzzers" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

#### Build

![]({{ "/assets/2010/IMAG0719-day-7.jpg" | relative_url }}) 

(those dainty fingers belong to thing2)

![]({{ "/assets/2010/IMAG0721-day-7.jpg" | relative_url }}) 

#### Circuit

Crazy simple circuit today:

![]({{ "/assets/2010/Sketch_bb-day-7.png" | relative_url }}) 

#### Schematic

![]({{ "/assets/2010/Sketch_schem-day-7.png" | relative_url }}) 
#### Code

Today’s coding was a very simple selection from previous exercises, so this should look familiar:
```c
#define c2 654
#define c3 1308

const int BuzzPin = 4;
const int NoteDuration = 100; 

void setup() {
  pinMode(BuzzPin, OUTPUT);  
}

void loop() {

  int RedButton = digitalRead(2);  
  int BlkButton = digitalRead(3);  
  
  if(RedButton){
    Buzz(c3, NoteDuration);
  }
  if(BlkButton){
    Buzz(c2, NoteDuration); 
  }
}

void Buzz(int frequencyHz, int durationMillis){
  // e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low
  // to create 50% duty cycle
  // http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692
  int Osc = 1000000 / frequencyHz / 2; // in microseconds
  
  // compute the number of iterations needed to hold
  // the nfote the desired duration
  int Iterations = frequencyHz * ((float)durationMillis / 1000);
  
  for (long i = 0; i < Iterations; i++ )
  {
      // beep!
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
}
```



#### Next Steps


I’d really like to get some live content into this thing. For example, we have a build system at work that automatically builds all of our code. When a build fails, it goes “red” and we’re notified. I’d like to create an “extreme feedback device” (Google it for examples) which represents the build status in some physical way. We’ll see how that goes.