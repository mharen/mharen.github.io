---
date: '2010-11-11T23:59:00.000-05:00'
description: ''
published: true
slug: 2010-11-arduino-day-11-extreme-feedback-for
tags:
- http://schemas.google.com/blogger/2008/kind#post
- 30 Days Of Arduino
- Arduino
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Arduino Day 11: Extreme Feedback for Hudson Builds (Includes Chuck Norris
  Cameo)'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> This post is part of <a href="http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino">a series</a> on my adventures with Arduino</div>  <p>Improving on yesterday’s build, I added in some actual network-sourced data. My little traffic lights now show the build status of one of my projects:</p>  <p align="center" style="clear: both;"></p>  <p>In case you don’t know what any of that was, let me try to explain. At work I build software, and that software is written in code. We have a server monitor our code and automatically try to build it (convert the code into executable software) whenever it changes. We use an awesome tool called Hudson to do this for us. What I’ve built is called an extreme feedback device because it reports a piece of soft data (the build status) in a physical way (beeping lights).</p>  <p>Whenever the build status changes (any of “success”, “building” or “failed”), the board beeps and lights up the appropriate LED (green, yellow or red).</p>  <p>In the future this tool could be tied to a <a href="http://www.thinkgeek.com/computing/accessories/8a0f/" target="_blank">mechanical foam dart gun</a> to physically punish whoever broke the build. Speaking of missiles, I saw <em>Delta Force</em> recently enough to make this connection: Chuck Norris’s motorcycle <em>launched missiles</em>. Yeah.</p>  <p><img alt="Chuck Norris in The Delta Force" src="http://www.cinema-suicide.com/wp-content/uploads/2010/06/chuck-norris-delta-force.jpg" style="margin: 3px auto; display: block; float: none;" /></p>  <p>You might imagine how politically correct and culturally sensitive a 1986 movie about terrorism, with the subtitle “They don't negotiate with terrorists... they blow them away!” is. It’s like <em>24</em> with less talk and more explosions.</p>  <p>But a motor cycle that launches missiles. Wow. That picture above, by the way, was presumably from around 25 years ago. Guess how old he was then, and how old he that makes him now:</p>  <p><a href="http://upload.wikimedia.org/wikipedia/en/7/7f/Norrishuckabee.JPG" target="_blank"><img alt="Norrishuckabee" height="450" src="http://lh6.ggpht.com/_IKD9WtY5kxU/TNzezBTdKzI/AAAAAAAABPg/JNYgGC5qDEo/Norrishuckabee%5B5%5D.jpg?imgmax=800" style="margin: 0px auto; display: block; float: none;" title="Norrishuckabee" width="391" /></a></p>  <p>70. Chuck Norris is <strong>seventy</strong> years old. And apparently immortal which is extra scary considering, well, <a href="http://www.chucknorrisfacts.com/" target="_blank">you know</a>.</p>  <h4>Build (Repeat)</h4>  <p><img alt="DSC_00113" height="503" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TNzez9IDxiI/AAAAAAAABPk/16_jZbhxC-c/DSC_00113%5B2%5D.jpg?imgmax=800" style="margin: 0px auto; display: block; float: none;" title="DSC_00113" width="700" /></p>  <h4>Circuit (Repeat)</h4>  <p><img alt="Sketch_bb6" height="340" src="http://lh4.ggpht.com/_IKD9WtY5kxU/TNze0indnGI/AAAAAAAABPo/GyvUSzrEeR8/Sketch_bb6%5B2%5D.png?imgmax=800" style="margin: 0px auto; display: block; float: none;" title="Sketch_bb6" width="454" /></p>  <h4>Schematic (Repeat)</h4>  <p><img alt="Sketch_schem6" height="511" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TNze1EMOXOI/AAAAAAAABPs/w1HiCFhDVHQ/Sketch_schem6%5B2%5D.png?imgmax=800" style="margin: 0px auto; display: block; float: none;" title="Sketch_schem6" width="635" /></p>  <h4>Code (Updated)</h4>  <h5>C#</h5>  <p>I started out today by doing all this in Powershell…but ultimately flipped back to full C# because most of my PS code was looking like C# anyway (and I’m very weak with PS).</p>  <blockquote>   <pre class="csharpcode"><span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
{

    var SerialPort = <span class="kwrd">new</span> SerialPort()
    {
        PortName = <span class="str">&quot;COM7&quot;</span>,
        BaudRate = 9600
    };

    <span class="kwrd">try</span>
    {
        SerialPort.Open();
        <span class="kwrd">string</span> SerialOutput = <span class="kwrd">null</span>;

        <span class="kwrd">for</span>(;;)
        {
            var StatusXml = XDocument.Load(<span class="str">@&quot;http://nope/job/jobname/lastBuild/api/xml&quot;</span>);

            <span class="kwrd">if</span> (StatusXml.Root.Element(<span class="str">&quot;building&quot;</span>).Value == <span class="str">&quot;true&quot;</span>)
            {
                SerialOutput = <span class="str">&quot;1&quot;</span>; <span class="rem">// yellow</span>
            }
            <span class="kwrd">else</span> <span class="kwrd">if</span> (StatusXml.Root.Element(<span class="str">&quot;result&quot;</span>).Value == <span class="str">&quot;SUCCESS&quot;</span>)
            {
                SerialOutput = <span class="str">&quot;0&quot;</span>; <span class="rem">// green</span>
            }
            <span class="kwrd">else</span>
            {
                SerialOutput = <span class="str">&quot;2&quot;</span>; <span class="rem">// red</span>
            }

            Console.WriteLine(<span class="str">&quot;Sending {0}&quot;</span>, SerialOutput);
            SerialPort.Write(SerialOutput);
            Thread.Sleep(1000);
        }
    }
    <span class="kwrd">finally</span>
    {
        SerialPort.Close();
    }
}</pre>
</blockquote>

<h5>Arduino</h5>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">const</span> <span class="kwrd">int</span> BuzzPin = 5;
<span class="kwrd">const</span> <span class="kwrd">int</span> BuzzDuration = 100; 
<span class="kwrd">const</span> <span class="kwrd">int</span> Tones[] = { 1000, 2000, 3000 };
<span class="kwrd">const</span> <span class="kwrd">int</span> LedPins[] = { 9, 10, 11 };

<span class="kwrd">void</span> setup() {
  Serial.begin(9600);

  pinMode(LedPins[0], OUTPUT);    
  pinMode(LedPins[1], OUTPUT);    
  pinMode(LedPins[2], OUTPUT);    
  pinMode(BuzzPin, OUTPUT);
}

<span class="kwrd">int</span> ActiveLed = 0;

<span class="kwrd">void</span> loop() {
  <span class="kwrd">if</span> (Serial.available() &gt; 0) {
    <span class="rem">// read the incoming byte:</span>
    <span class="kwrd">int</span> Byte = Serial.read();
    
    <span class="kwrd">int</span> Led = Byte - 48;
    
    <span class="kwrd">if</span>(0 &lt;= Led &amp;&amp; Led &lt;= 2 &amp;&amp; ActiveLed != Led){

      <span class="rem">// clear all pins to make debugging (i.e. messing up the state of the app) easier</span>
      digitalWrite(LedPins[ActiveLed], LOW);
      digitalWrite(LedPins[Led], HIGH);
      
      ActiveLed = Led;
      Ding(Led);
    }
  }
}

<span class="kwrd">void</span> Ding(<span class="kwrd">int</span> light){
  <span class="rem">// e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low</span>
  <span class="rem">// to create 50% duty cycle</span>
  <span class="rem">// http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692</span>
  <span class="kwrd">int</span> Osc = 1000000 / Tones[light] / 2; <span class="rem">// in microseconds</span>
  
  <span class="rem">// compute the number of iterations needed to hold</span>
  <span class="rem">// the nfote the desired duration</span>
  <span class="kwrd">int</span> Iterations = Tones[light] * ((<span class="kwrd">float</span>)200 / 1000);
  
  <span class="rem">// play tone</span>
  <span class="kwrd">for</span> (<span class="kwrd">long</span> i = 0; i &lt; Iterations; i++ )
  {
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
}</pre>
</blockquote>

<h4>Next Steps</h4>

<p>I’ve got a busy weekend coming up so I’ll probably just spend a little time refining what I have. I’m open to ideas, though!</p>

---

## 2 comments captured from [original post](https://blog.wassupy.com/2010/11/arduino-day-11-extreme-feedback-for.html) on Blogger

**Sarah said on 2010-11-12**

I tried to think of a funny Chuck Norris joke but apparently I am not very witty.  That or it's 1:30 in the morning.  Either way :)

**Michael Haren said on 2010-11-12**

Chuck norris can think of witty jokes at 130am

