---
layout: post
date: '2010-11-07T23:59:00.000-05:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: 'Arduino Day 7: Buttons and Buzzers'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

I had very limited time to build today so I’m afraid I don’t have much to show for it. Part of the problem was a lack of ideas, too. I think I need to bite off a bigger, multi-day project. I have some things in mind…

A big benefit to the simple build, though, was that Thing1 was actually interested enough to help from start to finish (*five *minutes). She helped me with wires and button placement and played with the buttons while I coded it up, and then played with the buttons again once they did something.

Here we go:  

  <h4>Build</h4>

![IMAG0719%5B8%5D.jpg](/assets/2010/IMAG0719%5B8%5D.jpg)  <h4>Circuit</h4>

Crazy simple circuit today:

![Sketch_bb%5B7%5D.png](/assets/2010/Sketch_bb%5B7%5D.png)  <h4>Schematic</h4>

![Sketch_schem%5B7%5D.png](/assets/2010/Sketch_schem%5B7%5D.png)  <h4>Code</h4>

Today’s coding was a very simple selection from previous exercises, so this should look familiar:
<blockquote>   
```cs
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

</blockquote>

<h4>Next Steps</h4>


I’d really like to get some live content into this thing. For example, we have a build system at work that automatically builds all of our code. When a build fails, it goes “red” and we’re notified. I’d like to create an “extreme feedback device” (Google it for examples) which represents the build status in some physical way. We’ll see how that goes.