---
date: '2010-11-07T23:59:00.000-05:00'
description: ''
published: true
slug: 2010-11-arduino-day-7-buttons-and-buzzers
tags:
- http://schemas.google.com/blogger/2008/kind#post
- 30 Days Of Arduino
- Arduino
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Arduino Day 7: Buttons and Buzzers'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> This post is part of <a href="http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino">a series</a> on my adventures with Arduino</div>
<p>I had very limited time to build today so I’m afraid I don’t have much to show for it. Part of the problem was a lack of ideas, too. I think I need to bite off a bigger, multi-day project. I have some things in mind…</p>
<p>A big benefit to the simple build, though, was that Thing1 was actually interested enough to help from start to finish (<em>five </em>minutes). She helped me with wires and button placement and played with the buttons while I coded it up, and then played with the buttons again once they did something.</p>
<p>Here we go:</p>  <p align="center"></p>  <h4>Build</h4>
<p><img alt="IMAG0721" height="631" src="http://lh4.ggpht.com/_IKD9WtY5kxU/TNeHe57R0vI/AAAAAAAABNU/eIOihaC5RwE/IMAG0721%5B7%5D.jpg" style="margin: 0px auto; display: block; float: none;" title="IMAG0721" width="700" /></p>  <p align="center">(those dainty fingers belong to thing2)</p>  <p align="center"><img alt="IMAG0719" height="700" src="http://lh4.ggpht.com/_IKD9WtY5kxU/TNeHgDFM9qI/AAAAAAAABNY/qe3a8Q4D0rk/IMAG0719%5B8%5D.jpg" style="margin: 0px auto; display: block; float: none;" title="IMAG0719" width="565" /></p>  <h4>Circuit</h4>
<p>Crazy simple circuit today:</p>
<p><img alt="Sketch_bb" height="254" src="http://lh6.ggpht.com/_IKD9WtY5kxU/TNeHgR3hDVI/AAAAAAAABNc/cJa7mwFgqkA/Sketch_bb%5B7%5D.png" style="margin: 0px auto; display: block; float: none;" title="Sketch_bb" width="614" /></p>  <h4>Schematic</h4>
<p><img alt="Sketch_schem" height="527" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TNeHgwMKZ9I/AAAAAAAABNg/8XdGWtNZjl0/Sketch_schem%5B7%5D.png" style="margin: 0px auto; display: block; float: none;" title="Sketch_schem" width="700" /></p>  <h4>Code</h4>
<p>Today’s coding was a very simple selection from previous exercises, so this should look familiar:</p>
<blockquote>   <pre class="csharpcode"><span class="preproc">#define</span> c2 654
<span class="preproc">#define</span> c3 1308

<span class="kwrd">const</span> <span class="kwrd">int</span> BuzzPin = 4;
<span class="kwrd">const</span> <span class="kwrd">int</span> NoteDuration = 100; 

<span class="kwrd">void</span> setup() {
  pinMode(BuzzPin, OUTPUT);  
}

<span class="kwrd">void</span> loop() {

  <span class="kwrd">int</span> RedButton = digitalRead(2);  
  <span class="kwrd">int</span> BlkButton = digitalRead(3);  
  
  <span class="kwrd">if</span>(RedButton){
    Buzz(c3, NoteDuration);
  }
  <span class="kwrd">if</span>(BlkButton){
    Buzz(c2, NoteDuration); 
  }
}

<span class="kwrd">void</span> Buzz(<span class="kwrd">int</span> frequencyHz, <span class="kwrd">int</span> durationMillis){
  <span class="rem">// e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low</span>
  <span class="rem">// to create 50% duty cycle</span>
  <span class="rem">// http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692</span>
  <span class="kwrd">int</span> Osc = 1000000 / frequencyHz / 2; <span class="rem">// in microseconds</span>
  
  <span class="rem">// compute the number of iterations needed to hold</span>
  <span class="rem">// the nfote the desired duration</span>
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

<p>I’d really like to get some live content into this thing. For example, we have a build system at work that automatically builds all of our code. When a build fails, it goes “red” and we’re notified. I’d like to create an “extreme feedback device” (Google it for examples) which represents the build status in some physical way. We’ll see how that goes.</p>