---
layout: post
date: '2010-11-09T23:38:00.001-05:00'
categories:
- 30-days-of-arduino
- arduino
- code
- technology
title: 'Arduino Day 9: Simon(ish) Game'
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

I built another game on top of [yesterday’s circuit](../../2010/11/arduino-day-8-reaction-game.html). I think you’ll probably recognize it:  

<iframe class="full-embed hd" src="https://www.youtube.com/embed/ozySl-wQYGc" title="Arduino Day 9: Simon(ish) Game" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

The first time Wife tried this (she pretends to be interested, which I’m pretty sure is love) she shocked me by playing for six minutes straight, successfully knocking out a 27 bit sequence. Random chance would put that at 1 in 134217728 (0.0000007%)...it’s probably legit.

{% imagesize /assets/2010/007.png:img %}

Speaking of 007, did anyone see those last two Bond movies? Daniel Craig is way, way more badass than Pierce Brosnan. Nothing personal, P, but Daniel Craig could go on a hunger strike, float around on the international space station for 6 months (where he will lose considerable muscle and bone mass), return to relax peacefully among nature (squirrels and birds and whatnot), and still break your hand (and possibly arm) with his face when you sucker punch him in it. And only then would he go get something to eat like a taco or burger or something.

I know the above to be true when compared to Roger Moore, also, because I saw his “performance” in Moonraker and it was lame. I admit that I haven’t recently seen any of the other Bonds.  
#### Build

{% imagesize /assets/2010/DSC_0012.jpg:img %}

{% imagesize /assets/2010/DSC_0013.jpg:img %}

Special thanks to Wife’s awesome camera for giving me all that sweet, delicious bokeh you see above. <small>Apparently I’m required by law to list this info, too: 116mm 1/50 f/4.8 ISO200</small>. 
#### Circuit

![](/assets/2010/Sketch_bb-day-9.png) 
#### Schematic

![](/assets/2010/Sketch_schem-day-9.png) 

#### Code

This program follows a typical “game loop” approach where the game is in one of a few states waiting for something to happen at any given time. The only thing close to a trick is how I maintain a sequence of tones. Rather than compute and store a known sequence, I just use the built in random number generator. Since I can seed the generator with whatever I want, I can replay the same sequence over and over again.

It worked out very nicely, actually, and all I have to do to start a new game is reseed the generator to a random value.

```c
const int BuzzPin = 5;
const int BuzzDuration = 100; 

int ButtonPins[] = { 3, 7 };
int Tones[] = { 2000, 3000, 1000 };
int LedPins[] = { 4, 6, 5 };

void setup() {
  for(int i = 0; i < 3; i++){
    pinMode(LedPins[i], OUTPUT);    
    Ding(i);  // boot test
  }
}

// our main loop will look at the game state to 
// figure out what to do
enum GameState {
  InsertCoin, // waiting for player to start game
  Teach,      // buzzing a random sequence, increasing by one element each time
  Test,       // checking user-entered sequence
  Boo         // you've lost
};

// start in the finished state because that sets up some things for us
GameState State = InsertCoin;

// pick a seed value for the random number generator
// we'll reuse this each time the sequence is played so we get the same sequence
int Seed;

// keeps track of how many tones there are in the sequence
int Taps;

void loop() {
  switch(State){
    case InsertCoin:
      // light up both sides to suggest the user tap one to start
      digitalWrite(LedPins[0], HIGH); 
      digitalWrite(LedPins[1], HIGH); 
      
      GetPress();

      // let's go!
      Taps = 0;
      Seed = analogRead(0); // pick a new sequence seed

      digitalWrite(LedPins[0], LOW); 
      digitalWrite(LedPins[1], LOW); 

      State = Teach;
      delay(1000);
      
      break;
    
    case Teach:
      // add one to the sequence and play what we have so far
      Taps++;

      randomSeed(Seed);
      for(int i = 0; i < Taps; i++){
        Ding(random(0,2));
        delay(100);
      }

      State = Test;
      break;
      
    case Test:
      randomSeed(Seed);
      for(int i = 0; i < Taps; i++){
        int Tap = GetPress();
        int ExpectedTap = random(0,2);
        if(Tap != ExpectedTap){
          // you fail
          State = Boo; 
          return;
        }
      }      
      
      // if we make it through the entire test, good job!
      // add another note
      State = Teach;
      delay(1000);
      break;
      
    case Boo:
      for(int i = 0; i<5; i++){
        Ding(2);
      }
  
      State = InsertCoin;
      delay(1000);
      break;
  }
}

// this function blocks until a button is pressed
int GetPress(){
  int P1; int P2;
  
  do {
    P1 = digitalRead(P1ButtonPin);
    P2 = digitalRead(P2ButtonPin);

  } while(!(P1 || P2));
  
  int Key = P1? 0 : 1;
  Ding(Key);

  return Key;  
}

void Ding(int light){
  // e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low
  // to create 50% duty cycle
  // http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692
  int Osc = 1000000 / Tones[light] / 2; // in microseconds
  
  // compute the number of iterations needed to hold
  // the nfote the desired duration
  int Iterations = Tones[light] * ((float)200 / 1000);
  
  // light on
  digitalWrite(LedPins[light], HIGH);
  
  // play tone
  for (long i = 0; i < Iterations; i++ )
  {
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
  
  // light off
  digitalWrite(LedPins[light], LOW);
}
```

#### Next Steps

I’ll try to knock out another simple game tomorrow, and hopefully by Thursday I’ll have another component or two to play with. If not, I might be cracking open some household electronics for parts...

---

### 1 comment

**Sarah said on 2010-11-09**

Like. :)  I am very impressed that you used the term "bokeh" properly in a sentence!  And I think it is hilarious that you posted the stats of your photo :P

