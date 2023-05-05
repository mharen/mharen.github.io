---
layout: post
date: '2010-11-06T23:43:00.001-04:00'
categories:
- 30-days-of-arduino
- arduino
- code
- technology
title: 'Arduino Day 6: Analog Inputs'
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

I used up the last of my components today: a light sensor (CdS/photoresistor) and a knob-driven variable resistor (potentiometer). This probably means my days of “the basics” are about over!

Let’s talk about “basics” for a second. I visited some awesome friends in the hospital recently and while trying to cheer them up, Sarah and I started chatting about some famous YouTube videos like the double rainbow guy. These poor, poor friends had no idea what we were talking about.

Fortunately, they had a laptop handy, and unlike the first couple of days they were there, the wifi worked. They were summarily introduced to the Internet with the following choice selections:

<iframe width="330" height="272" src="https://www.youtube.com/embed/OQSNhk5ICTI" title="Yosemitebear Mountain Double Rainbow 1-8-10" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

<iframe width="330" height="272" src="https://www.youtube.com/embed/MX0D4oZwCsA" title="DOUBLE RAINBOW SONG!!" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
<iframe width="330" height="272" src="https://www.youtube.com/embed/RzVkntQsNMM" title="Yosemitebear Mountain Wildlife Fall 09" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
<iframe width="330" height="272" src="https://www.youtube.com/embed/_OBlgSz8sSM" title="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
<iframe width="330" height="210" src="https://www.youtube.com/embed/VF9-sEbqDvU" title="MARCEL THE SHELL WITH SHOES ON" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
<iframe width="330" height="272" src="https://www.youtube.com/embed/FtX8nswnUKU" title="kittens inspired by kittens" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

If you or someone you know hasn't yet experienced the hilarity of user submitted content, please, do not fear. You are welcome here. It's a safe-ish place.

Now where was I? Oh yes...

Today’s build is another extension on the sound thing I’ve been working on. I took the Mario playing board and added in a light-trigger so it only plays when it’s dark. I also used the potentiometer to control the tempo of the song. Let me show you:  

<iframe width="640" height="385" src="https://www.youtube.com/embed/gfhQ6J9veXE" title="Arduino Day 6: Analog Inputs" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

#### Build

![]({{ "/assets/2010/IMAG0705-day-6.jpg" | relative_url }}) 

![]({{ "/assets/2010/IMAG0707-day-6.jpg" | relative_url }}) 

#### Circuit

Since this build was a very minor addition to my previous circuits, I’m only showing the simple changes here:

![]({{ "/assets/2010/Sketch_bb-day-6.png" | relative_url }}) 

#### Schematic

![]({{ "/assets/2010/Sketch_schem-day-6.png" | relative_url }}) 

#### Code

The only changes today were in the Loop() routine:
```c
void loop() {
  int CdsReading;  
  for(int i = 0; i<x; i++){

    // wait until dark
    while ((CdsReading = analogRead(0)) < 500){
      // check 10x/sec
       delay(100);       
    }

    // get the pot value
    NoteDuration = analogRead(1);
    Serial.print("Pot reading = ");
    Serial.println(NoteDuration);

    // map the analog value [0,1023] to a reasonable speed value [25,250]
    NoteDuration = map(NoteDuration, 0, 1023, 25, 250);

    // play each note for the corresponding duration
    Buzz(song[i], NoteDuration*length[i]);

    // tiny break between notes
    delay(50); 

    // rest the corresponding duration (often 0)
    delay(NoteDuration*rests[i]);
  }
  
  delay(2000); // pause a moment before starting over
}
```

#### Next Steps

This was a very fun project because it gave me another opportunity to engage Thing1. I inverted the light sensor logic for her so that it plays only when a bright light is shining on it. She had about eight seconds of fun shining a flashlight on/off/on/off/on/off and seeing the song and LEDs react. Considering her skill with the TV remote (a much more impressive device), I guess the eight seconds of interest I got from my three year old was pretty good.


I honestly have no idea what I’m going to do tomorrow. Suggestions?