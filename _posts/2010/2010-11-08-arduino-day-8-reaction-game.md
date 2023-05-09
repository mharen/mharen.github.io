---
layout: post
date: '2010-11-08T23:30:00.001-05:00'
categories:
- 30-days-of-arduino
- arduino
- code
- technology
title: "Arduino Day 8: \"Reaction\" Game"
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

Today’s build combines a lot of the skills I’ve learned so far. It’s a simple game you’ve probably played before. It works like this for two players (though any number is possible): 

1. Each player gets a clicker
2. When the buzzer sounds and the center light illuminates, hit our clicker as fast as you can
3. The first player to click wins

Here’s the finished project: 

<iframe class="full-embed hd" src="https://www.youtube.com/embed/_uI7ZL5zChU" title="Arduino Day 8: &quot;Reaction&quot; Game" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

I don’t have anything to rant about today so I’ll instead direct you to this rather entertaining interview with [David Sedaris](http://www.thedailyshow.com/watch/thu-november-4-2010/david-sedaris). If you don’t know who that is, you probably won’t find it funny. In that case, [this](http://www.collegehumor.com/videos/playlist:prankwar) type of humor probably more your style. 

#### Build

{% imagesize /assets/2010/IMAG0725-day-8.jpg:img %}

{% imagesize /assets/2010/IMAG0726-day-8.jpg:img %}

The circuit and code are completely from scratch, but they are so simple I wouldn’t be surprised to find a near duplicate elsewhere. Note that the buttons are on opposite sides of the board on purpose: this is a two player game.

#### Circuit

{% imagesize /assets/2010/Sketch_bb-day-8.png:img %}

#### Schematic

The schematic makes this thing look insane. I suggest just looking at the circuit above—it’s really a simple build.

{% imagesize /assets/2010/Sketch_schem-day-8.png:img %}

#### Code

```cs
const int ToneHz = 2000;
const int P1ButtonPin = 3;
const int P1LedPin = 4;
const int BuzzPin = 5;
const int P2LedPin = 6;
const int P2ButtonPin = 7;
const int BuzzDuration = 100; 

void setup() {
  pinMode(P1LedPin, OUTPUT);
  pinMode(BuzzPin, OUTPUT);
  pinMode(P2LedPin, OUTPUT);
  
  // boot test
  digitalWrite(P1LedPin, HIGH);
  delay(200);
  digitalWrite(P1LedPin, LOW);
  digitalWrite(P2LedPin, HIGH);
  delay(200);
  digitalWrite(P2LedPin, LOW);
  Buzz(ToneHz, BuzzDuration * 2);
}

// our main loop will look at the game state to 
// figure out what to do. when the state's not changing,
// things like buzzing or reading input will occur
// repeatedly, very fast

enum GameState {
 InsertCoin, // waiting for player to start game
 Pounce,     // about to buzz (sleeping random amount)
 Bzzzzz,     // buzzing (waiting for button)
 Woohoo      // player 1 or 2 pressed first
};

// randomly start with p1 or p2
int Victor = random(1,3);

// start in the finished state because that sets up some things for us
GameState State = Woohoo;

void loop() {
  // these pins get reference a lot so just figure it out at the beginning
  int LastWinnerLedPin = Victor == 1? P1LedPin : P2LedPin;
  int LastWinnerButtonPin = Victor == 1? P1ButtonPin : P2ButtonPin;

  int P1; int P2;
  switch(State){
    case InsertCoin:
      if(digitalRead(LastWinnerButtonPin)){
        // let's go!
        digitalWrite(LastWinnerLedPin, LOW); 
        State = Pounce;
      }
      break;
    
    case Pounce:
      State = Bzzzzz;
      
      // don't buzz for 1-7 seconds (the suspense is intense)
      delay(random(1000,7000));
      break;
      
    case Bzzzzz:
      Buzz(ToneHz, BuzzDuration / 5);
      
      P1 = digitalRead(P1ButtonPin);
      P2 = digitalRead(P2ButtonPin);
      
      if(P1 || P2){
        // note the victor and move on to the next state
        // I suppose this gives a teeny advantage to player 1 since it gets checked first
        Victor = P1? 1 : 2;
        State = Woohoo;
      }
      break;
      
    case Woohoo:
      // light up the victor
      digitalWrite(LastWinnerLedPin, HIGH);
      
      // pseudo debouce
      delay(500);
      
      // signal a victory
      BlinkAFewTimes(LastWinnerLedPin);
      
      // go back to idle
      State = InsertCoin;
      break;
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

void BlinkAFewTimes(int pin){
  BlinkOnce(pin);
  BlinkOnce(pin);
}

void BlinkOnce(int pin){
  digitalWrite(pin, LOW); 
  delay(50);
  digitalWrite(pin, HIGH); 
  delay(50);  
}
```

#### Next Steps

While this project could certainly be improved (e.g. holding down your button insures victory when instead you should lose for pressing it early), I’m satisfied with it.

I might try to build a Simon game tomorrow. Special thanks to [@corsae](http://twitter.com/#!/corsae/status/1655470213300224) for a nice list of project ideas.

---

### 2 comments

**Sarah said on 2010-11-08**

Very nice :)  Thank you for letting me win on that last turn ;)

**Math Zombie said on 2010-11-09**

The music in your video is kind of ominous.

Comments closed
{: .comments-closed }