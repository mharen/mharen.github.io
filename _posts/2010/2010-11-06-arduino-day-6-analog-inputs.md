---
layout: post
date: '2010-11-06T23:43:00.001-04:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: 'Arduino Day 6: Analog Inputs'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

I used up the last of my components today: a light sensor (CdS/photoresistor) and a knob-driven variable resistor (potentiometer). This probably means my days of “the basics” are about over!

Let’s talk about “basics” for a second. I visited some awesome friends in the hospital recently and while trying to cheer them up, Sarah and I started chatting about some famous YouTube videos like the double rainbow guy. These poor, poor friends had no idea what we were talking about.

Fortunately, they had a laptop handy, and unlike the first couple of days they were there, the wifi worked. They were summarily introduced to the Internet with the following choice selections:  <table><tbody>     <tr>       <td></td>        <td></td>     </tr>      <tr>       <td></td>        <td></td>     </tr>      <tr>       <td></td>        <td></td>     </tr>   </tbody></table>

If you or someone you know hasn't yet experienced the hilarity of user submitted content, please, do not fear. You are welcome here. It's a safe-ish place.

Now where was I? Oh yes…

Today’s build is another extension on the sound thing I’ve been working on. I took the Mario playing board and added in a light-trigger so it only plays when it’s dark. I also used the potentiometer to control the tempo of the song. Let me show you:  

  <h4>Build</h4>

![IMAG0707%5B8%5D.jpg](IMAG0707%5B8%5D.jpg)  <h4>Circuit</h4>

Since this build was a very minor addition to my previous circuits, I’m only showing the simple changes here:

![Sketch_bb%5B6%5D.png](Sketch_bb%5B6%5D.png)  <h4>Schematic</h4>

![Sketch_schem%5B14%5D.png](Sketch_schem%5B14%5D.png)  <h4>Code</h4>

The only changes today were in the Loop() routine:
<blockquote>   
```cs
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

</blockquote>

<h4>Next Steps</h4>


This was a very fun project because it gave me another opportunity to engage Thing1. I inverted the light sensor logic for her so that it plays only when a bright light is shining on it. She had about eight seconds of fun shining a flashlight on/off/on/off/on/off and seeing the song and LEDs react. Considering her skill with the TV remote (a much more impressive device), I guess the eight seconds of interest I got from my three year old was pretty good.


I honestly have no idea what I’m going to do tomorrow. Suggestions?