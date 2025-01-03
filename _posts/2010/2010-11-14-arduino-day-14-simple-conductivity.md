---
layout: post
date: '2010-11-14T23:56:00.001-05:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: 'Arduino Day 14: Simple Conductivity Sensor'
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

In keeping with the traffic light theme of the past few days, I built a ridiculously simple conductivity sensor with an analog input. Place something between the two leads to determine if it is highly conductive, somewhat conductive, or barely or not at all conductive. Like this:  

<iframe class="full-embed hd" src="https://www.youtube.com/embed/iYd_xMBUhTY" title="Arduino Day 14: Conductivity" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

Yes, that’s Thing 1’s leftovers from lunch (or maybe Thing 2...). Her sandwich bread is somewhat conductive (yellow), but the ham inside is very conductive (green), as is the apple sauce.

Why is the applesauce dark red? Good Question. It’s homemade, and the best we can figure, the apples just turned brown as they normally do when cut. 

### Build

The build is identical to the previous few days with a simple analog input added the same way as the CdS cell in [another build](../../2010/11/arduino-day-6-analog-inputs.html) (I used a 10kΩ resistor instead of 470Ω, though).

{% imagesize /assets/2010/IMAG0782.jpg:img %}

### Code

```c
const int BuzzPin = 5;
const int BuzzDuration = 50; 
const int Tones[] = { 1000, 2000, 3000 };
const int LedPins[] = { 9, 10, 11 };
const int SignalPin = 0;

void setup() {
  pinMode(LedPins[0], OUTPUT);    
  pinMode(LedPins[1], OUTPUT);    
  pinMode(LedPins[2], OUTPUT);    
  pinMode(BuzzPin, OUTPUT);
}

// keep track of which LED is lit
int ActiveLed = -1;

void loop() {
  // grab the singal from the analog input
  int Val = analogRead(SignalPin);
  int Led;

  // red (no signal)
  if(Val < 100){
    Led = 2;
  }
  
  // yellow (some signal)
  else if(Val < 500){
    Led = 1; 
  }
  
  // green (lotsa signal)
  else{
    Led = 0;
  }

  // if a different LED should be lit, change it
  if(Led != ActiveLed){
    // turn off the currently lit LED
    digitalWrite(LedPins[ActiveLed], LOW);

    // light the new one
    digitalWrite(LedPins[Led], HIGH);
    Ding(Led);
 
    // remember me
    ActiveLed = Led;
  }
  delay(50);
}

void Ding(int light){
  // e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low
  // to create 50% duty cycle
  // http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692
  int Osc = 1000000 / Tones[light] / 4; // in microseconds
  
  // compute the number of iterations needed to hold
  // the nfote the desired duration
  int Iterations = Tones[light] * ((float)200 / 1000);
  
  // play tone
  for (long i = 0; i < Iterations; i++ )
  {
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
}
```

### Next Steps

I’ve got a lot of travel this week so doing projects will be very challenging...but we’ll see!