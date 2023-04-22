---
date: '2010-11-04T23:59:00.000-04:00'
description: ''
published: true
slug: 2010-11-arduino-day-4-fun-with-sound
tags:
- http://schemas.google.com/blogger/2008/kind#post
- 30 Days Of Arduino
- Arduino
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Arduino Day 4: Fun With Sound'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> This post is part of <a href="http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino">a series</a> on my adventures with Arduino</div>  <p>I wired up a buzzer from Radio Shack for some endless fun with sound. After jumping in head-first, I was unable to make this thing beep so I turned to Google. I immediately found <a href="http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692">this very insightful thread</a> that clearly explained how this buzzer works and what I was doing wrong. Apparently I needed to oscillate the signal. Who knew?</p>  <p>Anyway, after playing around with beeps, I wired up Mary Had a Little Lamb and played it for Sarah. She looked at me perplexed and asked what it was. Not a good sign.</p>  <p>It seems that I am completely tone deaf. Not only did I have the scale in the wrong order (high vs. low), I had all kinds of wrong notes in there. Lucky for me, I’m married to a musical wonder who helped me out. She set me straight with a proper set of notes and then helped me read music from the Internet. At several points, she even corrected the music we found (and her corrections <em>always </em>sounded better). Incredible. </p>  <p><img align="right" alt="I hate this show so much that I made this up-side-down" height="168" src="http://lh4.ggpht.com/_IKD9WtY5kxU/TNOHEE9UzxI/AAAAAAAABMQ/TDwb0Gkqu6g/privatepractice%5B7%5D.jpg?imgmax=800" style="margin: 0px; display: inline; float: right;" title="I hate this show so much that I made this up-side-down" width="150" />Speaking of Incredible, did you guys see “The Incredibles”? That movie was awesome. You know what’s not awesome? “Private Practice”. It’s like they took the worst parts of Grey’s Anatomy, crapped it down a toilet, and after traveling down the coastal sewer system (gathering steam along the way), it emerged as the ridonkulous show we have today. The worst of it is that I can’t figure out why Grey’s still exists—it has no good parts left.</p>  <p>These shows are simply absurd in every way. Crazy stuff happens on “House MD”, too, but at least they worked it into the story by saying that House is this genius doctor who only takes crazy cases. Private Practice is about a crummy, nearly bankrupt group of doctors with debilitating personal issues who somehow find themselves in the most controversial, insane situations <em>every day</em>. If I had one wish, world peace, ending poverty or hunger or whatever would probably win, but ending this show and erasing all memory of it would be up there.</p>  <p>10…9…8…7…ok I’m feeling better now. So here’s what we ended up with:</p>  <p align="center"></p>  <h4>Build</h4>  <p>Today’s build was very easy. Most of my time was spent working on code and learning about music notes.</p>  <p><img alt="IMAG0682" height="605" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TNOHElFFLzI/AAAAAAAABMU/t0tVz5nc33k/IMAG0682%5B8%5D.jpg?imgmax=800" style="margin: 0px auto; display: block; float: none;" title="IMAG0682" width="700" /></p>  <h4>Circuit</h4>  <p><img alt="Day 4 - bb" height="267" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TNOHFPH50vI/AAAAAAAABMY/tKxk5VOKKNQ/Day%204%20-%20bb%5B6%5D.png?imgmax=800" style="margin: 0px auto; display: block; float: none;" title="Day 4 - bb" width="630" /></p>  <h4>Schematic</h4>  <p><img alt="Day 4 - Schematic" height="524" src="http://lh6.ggpht.com/_IKD9WtY5kxU/TNOHFja4OYI/AAAAAAAABMc/c5Yo4El6RiU/Day%204%20-%20Schematic%5B6%5D.png?imgmax=800" style="margin: 0px auto; display: block; float: none;" title="Day 4 - Schematic" width="501" /></p>  <h4>Code</h4>  <p>Today’s code was ultimately very simple…it just took a while to prune it down to the essentials listed below. As I mentioned, Sarah put the list of notes together and helped translate the song’s music into the encoded note, length, and rest values.</p>  <p>I realize I don’t need so many notes but we did a batch job through Excel so I left them all in here for future use.</p>  <blockquote>   <pre class="csharpcode"><span class="rem">// notes adapted from http://www.phy.mtu.edu/~suits/notefreqs.html</span>
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
  <span class="rem">// the note the desired duration</span>
  <span class="kwrd">int</span> Iterations = frequencyHz * ((<span class="kwrd">float</span>)durationMillis / 1000);
  
  <span class="kwrd">for</span> (<span class="kwrd">long</span> i = 0; i &lt; Iterations; i++ )
  {
      <span class="rem">// beep!</span>
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
}</pre>
</blockquote>

<h4>Next Steps</h4>

<p>I’m thinking it’d be neat to add some LEDs for each tone or add buttons so sounds can be driven (like a keyboard). I might get into that tomorrow.</p>

---

## 3 comments captured from [original post](https://blog.wassupy.com/2010/11/arduino-day-4-fun-with-sound.html) on Blogger

**Sarah said on 2010-11-05**

Excellent.  And sadly, I have to agree with your Private Practice analysis.  It is painful for even me to watch anymore :(  Unfortunately, I am about 3 episodes behind so I *have* to watch it to catch up!  What if it gets better???

**Michael Haren said on 2010-11-05**

It won't get better (Matrix). I've been down that road (24). I know that pain (Alias). 

Together we can break the cycle.

If we don't, you'll be epically disappointed (Lost).

**Sarah said on 2010-11-05**

Your post is funny, but your comment is even better.  That is why I married you :D

