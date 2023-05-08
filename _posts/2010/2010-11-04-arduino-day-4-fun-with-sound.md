---
layout: post
date: '2010-11-04T23:59:00.000-04:00'
categories:
- 30-days-of-arduino
- arduino
- code
- technology
title: 'Arduino Day 4: Fun With Sound'
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

I wired up a buzzer from Radio Shack for some endless fun with sound. After jumping in head-first, I was unable to make this thing beep so I turned to Google. I immediately found [this very insightful thread](http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692) that clearly explained how this buzzer works and what I was doing wrong. Apparently I needed to oscillate the signal. Who knew?

Anyway, after playing around with beeps, I wired up Mary Had a Little Lamb and played it for Sarah. She looked at me perplexed and asked what it was. Not a good sign.

It seems that I am completely tone deaf. Not only did I have the scale in the wrong order (high vs. low), I had all kinds of wrong notes in there. Lucky for me, I’m married to a musical wonder who helped me out. She set me straight with a proper set of notes and then helped me read music from the Internet. At several points, she even corrected the music we found (and her corrections *always *sounded better). Incredible. 

{% imagesize /assets/2010/privatepractice.jpg" | relative_url }} "I hate this show so much that I made this up-side-down":img %}

Speaking of Incredible, did you guys see “The Incredibles”? That movie was awesome. You know what’s not awesome? “Private Practice”. It’s like they took the worst parts of Grey’s Anatomy, crapped it down a toilet, and after traveling down the coastal sewer system (gathering steam along the way), it emerged as the ridonkulous show we have today. The worst of it is that I can’t figure out why Grey’s still exists—it has no good parts left.

These shows are simply absurd in every way. Crazy stuff happens on “House MD”, too, but at least they worked it into the story by saying that House is this genius doctor who only takes crazy cases. Private Practice is about a crummy, nearly bankrupt group of doctors with debilitating personal issues who somehow find themselves in the most controversial, insane situations *every day*. If I had one wish, world peace, ending poverty or hunger or whatever would probably win, but ending this show and erasing all memory of it would be up there.

10...9...8...7...ok I’m feeling better now. So here’s what we ended up with:  

<iframe class="full-embed hd" src="https://www.youtube.com/embed/ZGQOJTgm7A4" title="Arduino Day 4: Fun With Sound" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
 
#### Build

Today’s build was very easy. Most of my time was spent working on code and learning about music notes.

![](/assets/2010/IMAG0682.jpg) 

#### Circuit

![](/assets/2010/Day_4_-_bb.png) 

#### Schematic

![](/assets/2010/Day_4_-_Schematic.png) 

#### Code

Today’s code was ultimately very simple...it just took a while to prune it down to the essentials listed below. As I mentioned, Sarah put the list of notes together and helped translate the song’s music into the encoded note, length, and rest values.

I realize I don’t need so many notes but we did a batch job through Excel so I left them all in here for future use.

```c
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
  // the note the desired duration
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


I’m thinking it’d be neat to add some LEDs for each tone or add buttons so sounds can be driven (like a keyboard). I might get into that tomorrow.

---

### 3 comments

**Sarah said on 2010-11-05**

Excellent.  And sadly, I have to agree with your Private Practice analysis.  It is painful for even me to watch anymore :(  Unfortunately, I am about 3 episodes behind so I *have* to watch it to catch up!  What if it gets better???

**Michael Haren said on 2010-11-05**

It won't get better (Matrix). I've been down that road (24). I know that pain (Alias). 

Together we can break the cycle.

If we don't, you'll be epically disappointed (Lost).

**Sarah said on 2010-11-05**

Your post is funny, but your comment is even better.  That is why I married you :D

