---
layout: post
date: '2010-11-05T23:55:00.001-04:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: 'Arduino Day 5: Fun With Charlieplexing'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30 Days Of Arduino) on my adventures with Arduino</div>

Here’s the challenge of the day: wire up a bunch of LEDs to blink in sync to the music from [yesterday’s fun](../../2010/11/arduino-day-4-fun-with-sound.html). In all my LED fun before, though, I was wiring up LEDs directly to output pins on the Arduino—one-to-one. This doesn’t scale very well. 

Fortunately there’s this thing called [multiplexing](http://en.wikipedia.org/wiki/Multiplexing) (muxing) which lets you combine a bunch of signals together (board outputs), transmit them over fewer wires, and then demux them at the destination (LEDs).

A particularly popular method of this in the Arduino world seems to be [Charlieplexing](http://en.wikipedia.org/wiki/Charlieplexing). Charlieplexing is pretty sweet because from *n* pins, you can individually address *n(n-1)* LEDs. For example, a mere 6 pins can address 30 LEDs. Nice!

Speaking of Charlie. Did you guys see that “Lost” finale a while back? I can’t talk about it but [this](http://www.collegehumor.com/video:1936291) sums up how I feel pretty well. I just watched that again and the pain/disappointment is still too real to discuss it.

So anyway, I Charlieplexed six LEDs for use with that silly Mario song from yesterday.&#160; The song has maybe 10 notes in total. I simply took the frequency range of those notes and broke it into six slices. As I mentioned yesterday, I have no musical skill whatsoever so these are completely arbitrary and not in any order.

Here we go:  

  <h4>Build</h4>

![IMAG0694[8].jpg](/assets/2010/IMAG0694[8].jpg)  <h4>Circuit</h4>

This doesn’t well represent the circuit:

![day 5_bb[7].png](/assets/2010/day 5_bb[7].png)

It was actually much simpler to build, requiring very little wire. Looking at the schematic below you can see that the four points on top of the LEDs connect to a single point as do the four points on bottom. This makes bread boarding the circuit pretty easy.

If you look closely in the build shot above you can see that I used four rows, and the middle two are common to provide less contorting of the LED leads.  <h4>Schematic</h4>

I don’t fully understand how thing thing works but it does. Let Google lead you to more information on the subject, including better schematics:

![day 5_schem[8].png](/assets/2010/day 5_schem[8].png)  <h4>Code</h4>

I strongly suggest reading voraciously about how this Charlieplexing thing works. It will save you some grief.

Today’s changes are in bold:
```c
int Pins[] = { 2, 3, 4 };
int Leds[6][2] = 
{
  { 0, 1 }, { 1, 0 },
  { 0, 2 }, { 2, 0 },
  { 1, 2 }, { 2, 1 } 
};
</strong>
#define PinCount (sizeof(Pins)/sizeof(int))
#define LedCount (sizeof(Leds)/sizeof(int))
</strong>
// notes adapted from http://www.phy.mtu.edu/~suits/notefreqs.html
// with some help from Excel and my amazing, super talented wife
// who is not completely tone deaf like me
#define c0 164
#define c0s 173
#define d0 184
#define d0s 195
#define e0 206
#define f0 218
#define f0s 231
#define g0 245
#define g0s 260
#define a0 275
#define a0s 291
#define b0 309
#define c1 327
#define c1s 347
#define d1 367
#define d1s 389
#define e1 412
#define f1 437
#define f1s 463
#define g1 490
#define g1s 519
#define a1 550
#define a1s 583
#define b1 617
#define c2 654
#define c2s 693
#define d2 734
#define d2s 778
#define e2 824
#define f2 873
#define f2s 925
#define g2 980
#define g2s 1038
#define a2 1100
#define a2s 1165
#define b2 1235
#define c3 1308
#define c3s 1386
#define d3 1468
#define d3s 1556
#define e3 1648
#define f3 1746
#define f3s 1850
#define g3 1960
#define g3s 2077
#define a3 2200
#define a3s 2331
#define b3 2469
#define c4 2616
#define c4s 2772
#define d4 2937
#define d4s 3111
#define e4 3296
#define f4 3492
#define f4s 3700
#define g4 3920
#define g4s 4153
#define a4 4400
#define a4s 4662
#define b4 4939
#define c5 5233
#define c5s 5544
#define d5 5873
#define d5s 6223
#define e5 6593
#define f5 6985
#define f5s 7400
#define g5 7840
#define g5s 8306
#define a5 8800
#define a5s 9323
#define b5 9878

// adapted from http://www.rose-hulman.edu/class/me
//             /HTML/ME430_0910_W_Olson/code/example buzzer.c

const int
    song[] =   { e2, e2, e2, c2, e2, g2, g1, 
                 c2, g1, e1, a1, b1, a1s,a1,
                 g1, e2, g2, a2, f2, g2, e2, c2, d2, b1,
                 c2, g1, e1, a1, b1, a1s,a1,
                 g1, e2, g2, a2, f2, g2, e2, c2, d2, b1,
                 g2, f2s,f2, d2s,e2, g1s,a1, c2, a1, c2, d2,
                 g2, f2s,f2, d2s,e2, c3, c3, c3,
                 g2, f2s,f2, d2s,e2, g1s,a1, c2, a1, c2, d2,
                 d2s,d2, c2 };
const float 
    length[] = { 1,  2,  1,  1,  2,  4,  4,  
                 2,  1,  2,  1,  1,  1,  2,
                 1.3,1.3,1.3,2,  1,  1,  1,  1,  1,  1,
                 2,  1,  2,  1,  1,  1,  2,
                 1.3,1.3,1.3,2,  1,  1,  1,  1,  1,  1,
                 1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,
                 1,  1,  1,  2,  1,  1,  1,  4,
                 1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,
                 2,  1,  4 };
const int 
    rests[] =  { 0,  0,  1,  0,  0,  0,  0,  
                 1,  2,  1,  1,  1,  0,  0,
                 0,  0,  0,  0,  0,  1,  1,  0,  0,  2,
                 1,  2,  1,  1,  1,  0,  0,
                 0,  0,  0,  0,  0,  1,  1,  0,  0,  4,
                 0,  0,  0,  0,  1,  0,  0,  1,  0,  0,  2,
                 0,  0,  0,  0,  1,  1,  0,  2,
                 0,  0,  0,  0,  1,  0,  0,  1,  0,  0,  2,
                 1,  2,  4 };

#define x (sizeof(song)/sizeof(int))
const int BuzzPin = 12;
const int NoteDuration = 100; 

void setup() {
  pinMode(BuzzPin, OUTPUT);  
}

void loop() {
  
  for(int i = 0; i<x; i++){
    // play each note for the corresponding duration
    Buzz(song[i], NoteDuration*length[i]);

    // tiny break between notes
    delay(50); 

    // rest the corresponding duration (often 0)
    delay(NoteDuration*rests[i]);
  }
  
  delay(3000); // pause a moment before starting over
}

void Buzz(int frequencyHz, int durationMillis){
  // e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low
  // to create 50% duty cycle
  // http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692
  int Osc = 1000000 / frequencyHz / 2; // in microseconds
  
  // compute the number of iterations needed to hold
  // the nfote the desired duration
  int Iterations = frequencyHz * ((float)durationMillis / 1000);
  
  // light on
  Beep(frequencyHz);
</strong>  for (long i = 0; i < Iterations; i++ )
  {
      // beep!
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
  // led off
  Reset();
</strong>}

void Reset(){
  for (int i=0; i < PinCount; i++){
    pinMode(Pins[i] , INPUT);
  }
}</strong>

void Beep(int hz){
  if      (hz < 450)  { Burn(Leds[0]); }
  else if (hz < 600)  { Burn(Leds[1]); }
  else if (hz < 750)  { Burn(Leds[2]); }
  else if (hz < 900)  { Burn(Leds[3]); }
  else if (hz < 1050) { Burn(Leds[4]); }
  else                { Burn(Leds[5]); }
}
</strong>
void Burn(int led[2]){
  Burn(led[0], led[1]); 
}
</strong>
void Burn(int highPin, int lowPin){
  pinMode(Pins[highPin], OUTPUT);
  pinMode(Pins[lowPin], OUTPUT);

  digitalWrite(Pins[highPin], HIGH);
  digitalWrite(Pins[lowPin], LOW);  
}</strong>
```



<h4>Next Steps</h4>


I’m not totally sure what I’ve got next (I’m running out of new components). I might work a switch in there or maybe try to do a larger LED array for some animation. I’m thinking about projects I can get Thing1 interested in, too. She likes to help but loses interest after about four seconds so it’s tough. She loved pushing a button I wired into the speaker, though:


![IMAG0704[5].jpg](/assets/2010/IMAG0704[5].jpg)


(The only way I can get her to look at the camera long enough for a snapshot is by asking her to stick out her tongue.)