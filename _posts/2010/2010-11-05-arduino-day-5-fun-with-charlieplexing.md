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

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

Here’s the challenge of the day: wire up a bunch of LEDs to blink in sync to the music from [yesterday’s fun](../2010/2010-11-arduino-day-4-fun-with-sound.html). In all my LED fun before, though, I was wiring up LEDs directly to output pins on the Arduino—one-to-one. This doesn’t scale very well. 

Fortunately there’s this thing called [multiplexing](http://en.wikipedia.org/wiki/Multiplexing) (muxing) which lets you combine a bunch of signals together (board outputs), transmit them over fewer wires, and then demux them at the destination (LEDs).

A particularly popular method of this in the Arduino world seems to be [Charlieplexing](http://en.wikipedia.org/wiki/Charlieplexing). Charlieplexing is pretty sweet because from *n* pins, you can individually address *n(n-1)* LEDs. For example, a mere 6 pins can address 30 LEDs. Nice!

Speaking of Charlie. Did you guys see that “Lost” finale a while back? I can’t talk about it but [this](http://www.collegehumor.com/video:1936291) sums up how I feel pretty well. I just watched that again and the pain/disappointment is still too real to discuss it.

So anyway, I Charlieplexed six LEDs for use with that silly Mario song from yesterday.&#160; The song has maybe 10 notes in total. I simply took the frequency range of those notes and broke it into six slices. As I mentioned yesterday, I have no musical skill whatsoever so these are completely arbitrary and not in any order.

Here we go:  

  <h4>Build</h4>

![IMAG0694%5B8%5D.jpg](IMAG0694%5B8%5D.jpg)  <h4>Circuit</h4>

This doesn’t well represent the circuit:

![day%205_bb%5B7%5D.png](day%205_bb%5B7%5D.png)

It was actually much simpler to build, requiring very little wire. Looking at the schematic below you can see that the four points on top of the LEDs connect to a single point as do the four points on bottom. This makes bread boarding the circuit pretty easy.

If you look closely in the build shot above you can see that I used four rows, and the middle two are common to provide less contorting of the LED leads.  <h4>Schematic</h4>

I don’t fully understand how thing thing works but it does. Let Google lead you to more information on the subject, including better schematics:

![day%205_schem%5B8%5D.png](day%205_schem%5B8%5D.png)  <h4>Code</h4>

I strongly suggest reading voraciously about how this Charlieplexing thing works. It will save you some grief.

Today’s changes are in bold:
<blockquote>   <pre class="csharpcode"><strong><span class="kwrd">int</span> Pins[] = { 2, 3, 4 };
<span class="kwrd">int</span> Leds[6][2] = 
{
  { 0, 1 }, { 1, 0 },
  { 0, 2 }, { 2, 0 },
  { 1, 2 }, { 2, 1 } 
};
</strong>
<span class="preproc">#define</span> PinCount (<span class="kwrd">sizeof</span>(Pins)/<span class="kwrd">sizeof</span>(<span class="kwrd">int</span>))
<strong><span class="preproc">#define</span> LedCount (<span class="kwrd">sizeof</span>(Leds)/<span class="kwrd">sizeof</span>(<span class="kwrd">int</span>))
</strong>
<span class="rem">// notes adapted from http://www.phy.mtu.edu/~suits/notefreqs.html</span>
<span class="rem">// with some help from Excel and my amazing, super talented wife</span>
<span class="rem">// who is not completely tone deaf like me</span>
<span class="preproc">#define</span> c0 164
<span class="preproc">#define</span> c0s 173
<span class="preproc">#define</span> d0 184
<span class="preproc">#define</span> d0s 195
<span class="preproc">#define</span> e0 206
<span class="preproc">#define</span> f0 218
<span class="preproc">#define</span> f0s 231
<span class="preproc">#define</span> g0 245
<span class="preproc">#define</span> g0s 260
<span class="preproc">#define</span> a0 275
<span class="preproc">#define</span> a0s 291
<span class="preproc">#define</span> b0 309
<span class="preproc">#define</span> c1 327
<span class="preproc">#define</span> c1s 347
<span class="preproc">#define</span> d1 367
<span class="preproc">#define</span> d1s 389
<span class="preproc">#define</span> e1 412
<span class="preproc">#define</span> f1 437
<span class="preproc">#define</span> f1s 463
<span class="preproc">#define</span> g1 490
<span class="preproc">#define</span> g1s 519
<span class="preproc">#define</span> a1 550
<span class="preproc">#define</span> a1s 583
<span class="preproc">#define</span> b1 617
<span class="preproc">#define</span> c2 654
<span class="preproc">#define</span> c2s 693
<span class="preproc">#define</span> d2 734
<span class="preproc">#define</span> d2s 778
<span class="preproc">#define</span> e2 824
<span class="preproc">#define</span> f2 873
<span class="preproc">#define</span> f2s 925
<span class="preproc">#define</span> g2 980
<span class="preproc">#define</span> g2s 1038
<span class="preproc">#define</span> a2 1100
<span class="preproc">#define</span> a2s 1165
<span class="preproc">#define</span> b2 1235
<span class="preproc">#define</span> c3 1308
<span class="preproc">#define</span> c3s 1386
<span class="preproc">#define</span> d3 1468
<span class="preproc">#define</span> d3s 1556
<span class="preproc">#define</span> e3 1648
<span class="preproc">#define</span> f3 1746
<span class="preproc">#define</span> f3s 1850
<span class="preproc">#define</span> g3 1960
<span class="preproc">#define</span> g3s 2077
<span class="preproc">#define</span> a3 2200
<span class="preproc">#define</span> a3s 2331
<span class="preproc">#define</span> b3 2469
<span class="preproc">#define</span> c4 2616
<span class="preproc">#define</span> c4s 2772
<span class="preproc">#define</span> d4 2937
<span class="preproc">#define</span> d4s 3111
<span class="preproc">#define</span> e4 3296
<span class="preproc">#define</span> f4 3492
<span class="preproc">#define</span> f4s 3700
<span class="preproc">#define</span> g4 3920
<span class="preproc">#define</span> g4s 4153
<span class="preproc">#define</span> a4 4400
<span class="preproc">#define</span> a4s 4662
<span class="preproc">#define</span> b4 4939
<span class="preproc">#define</span> c5 5233
<span class="preproc">#define</span> c5s 5544
<span class="preproc">#define</span> d5 5873
<span class="preproc">#define</span> d5s 6223
<span class="preproc">#define</span> e5 6593
<span class="preproc">#define</span> f5 6985
<span class="preproc">#define</span> f5s 7400
<span class="preproc">#define</span> g5 7840
<span class="preproc">#define</span> g5s 8306
<span class="preproc">#define</span> a5 8800
<span class="preproc">#define</span> a5s 9323
<span class="preproc">#define</span> b5 9878

<span class="rem">// adapted from http://www.rose-hulman.edu/class/me</span>
<span class="rem">//             /HTML/ME430_0910_W_Olson/code/example%20buzzer.c</span>

<span class="kwrd">const</span> <span class="kwrd">int</span>
    song[] =   { e2, e2, e2, c2, e2, g2, g1, 
                 c2, g1, e1, a1, b1, a1s,a1,
                 g1, e2, g2, a2, f2, g2, e2, c2, d2, b1,
                 c2, g1, e1, a1, b1, a1s,a1,
                 g1, e2, g2, a2, f2, g2, e2, c2, d2, b1,
                 g2, f2s,f2, d2s,e2, g1s,a1, c2, a1, c2, d2,
                 g2, f2s,f2, d2s,e2, c3, c3, c3,
                 g2, f2s,f2, d2s,e2, g1s,a1, c2, a1, c2, d2,
                 d2s,d2, c2 };
<span class="kwrd">const</span> <span class="kwrd">float</span> 
    length[] = { 1,  2,  1,  1,  2,  4,  4,  
                 2,  1,  2,  1,  1,  1,  2,
                 1.3,1.3,1.3,2,  1,  1,  1,  1,  1,  1,
                 2,  1,  2,  1,  1,  1,  2,
                 1.3,1.3,1.3,2,  1,  1,  1,  1,  1,  1,
                 1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,
                 1,  1,  1,  2,  1,  1,  1,  4,
                 1,  1,  1,  2,  1,  1,  1,  1,  1,  1,  1,
                 2,  1,  4 };
<span class="kwrd">const</span> <span class="kwrd">int</span> 
    rests[] =  { 0,  0,  1,  0,  0,  0,  0,  
                 1,  2,  1,  1,  1,  0,  0,
                 0,  0,  0,  0,  0,  1,  1,  0,  0,  2,
                 1,  2,  1,  1,  1,  0,  0,
                 0,  0,  0,  0,  0,  1,  1,  0,  0,  4,
                 0,  0,  0,  0,  1,  0,  0,  1,  0,  0,  2,
                 0,  0,  0,  0,  1,  1,  0,  2,
                 0,  0,  0,  0,  1,  0,  0,  1,  0,  0,  2,
                 1,  2,  4 };

<span class="preproc">#define</span> x (<span class="kwrd">sizeof</span>(song)/<span class="kwrd">sizeof</span>(<span class="kwrd">int</span>))
<span class="kwrd">const</span> <span class="kwrd">int</span> BuzzPin = 12;
<span class="kwrd">const</span> <span class="kwrd">int</span> NoteDuration = 100; 

<span class="kwrd">void</span> setup() {
  pinMode(BuzzPin, OUTPUT);  
}

<span class="kwrd">void</span> loop() {
  
  <span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i&lt;x; i++){
    <span class="rem">// play each note for the corresponding duration</span>
    Buzz(song[i], NoteDuration*length[i]);

    <span class="rem">// tiny break between notes</span>
    delay(50); 

    <span class="rem">// rest the corresponding duration (often 0)</span>
    delay(NoteDuration*rests[i]);
  }
  
  delay(3000); <span class="rem">// pause a moment before starting over</span>
}

<span class="kwrd">void</span> Buzz(<span class="kwrd">int</span> frequencyHz, <span class="kwrd">int</span> durationMillis){
  <span class="rem">// e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low</span>
  <span class="rem">// to create 50% duty cycle</span>
  <span class="rem">// http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692</span>
  <span class="kwrd">int</span> Osc = 1000000 / frequencyHz / 2; <span class="rem">// in microseconds</span>
  
  <span class="rem">// compute the number of iterations needed to hold</span>
  <span class="rem">// the nfote the desired duration</span>
  <span class="kwrd">int</span> Iterations = frequencyHz * ((<span class="kwrd">float</span>)durationMillis / 1000);
  
<strong>  <span class="rem">// light on</span>
  Beep(frequencyHz);
</strong>  <span class="kwrd">for</span> (<span class="kwrd">long</span> i = 0; i &lt; Iterations; i++ )
  {
      <span class="rem">// beep!</span>
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
<strong>  <span class="rem">// led off</span>
  Reset();
</strong>}

<strong><span class="kwrd">void</span> Reset(){
  <span class="kwrd">for</span> (<span class="kwrd">int</span> i=0; i &lt; PinCount; i++){
    pinMode(Pins[i] , INPUT);
  }
}</strong>

<strong><span class="kwrd">void</span> Beep(<span class="kwrd">int</span> hz){
  <span class="kwrd">if</span>      (hz &lt; 450)  { Burn(Leds[0]); }
  <span class="kwrd">else</span> <span class="kwrd">if</span> (hz &lt; 600)  { Burn(Leds[1]); }
  <span class="kwrd">else</span> <span class="kwrd">if</span> (hz &lt; 750)  { Burn(Leds[2]); }
  <span class="kwrd">else</span> <span class="kwrd">if</span> (hz &lt; 900)  { Burn(Leds[3]); }
  <span class="kwrd">else</span> <span class="kwrd">if</span> (hz &lt; 1050) { Burn(Leds[4]); }
  <span class="kwrd">else</span>                { Burn(Leds[5]); }
}
</strong>
<strong><span class="kwrd">void</span> Burn(<span class="kwrd">int</span> led[2]){
  Burn(led[0], led[1]); 
}
</strong>
<strong><span class="kwrd">void</span> Burn(<span class="kwrd">int</span> highPin, <span class="kwrd">int</span> lowPin){
  pinMode(Pins[highPin], OUTPUT);
  pinMode(Pins[lowPin], OUTPUT);

  digitalWrite(Pins[highPin], HIGH);
  digitalWrite(Pins[lowPin], LOW);  
}</strong></pre>
</blockquote>

<h4>Next Steps</h4>


I’m not totally sure what I’ve got next (I’m running out of new components). I might work a switch in there or maybe try to do a larger LED array for some animation. I’m thinking about projects I can get Thing1 interested in, too. She likes to help but loses interest after about four seconds so it’s tough. She loved pushing a button I wired into the speaker, though:


![IMAG0704%5B5%5D.jpg](IMAG0704%5B5%5D.jpg)


(The only way I can get her to look at the camera long enough for a snapshot is by asking her to stick out her tongue.)