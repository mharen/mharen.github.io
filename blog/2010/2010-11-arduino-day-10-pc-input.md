---
date: '2010-11-10T23:54:00.001-05:00'
description: ''
published: true
slug: 2010-11-arduino-day-10-pc-input
tags:
- http://schemas.google.com/blogger/2008/kind#post
- 30 Days Of Arduino
- Arduino
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Arduino Day 10: PC Input'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

I’m starting to lay the groundwork for a larger project that will be driven from network data. I don’t have an Ethernet shield so I’ll drive this from USB. Today’s exercise is simply to verify that I can write data to the board from a higher level program on my computer. In this case, I’m using C#.  

  <h4>Build</h4>

![DSC_0011%5B3%5D.jpg](DSC_0011%5B3%5D.jpg)  <h4>Circuit</h4>

![Sketch_bb%5B6%5D.png](Sketch_bb%5B6%5D.png)  <h4>Schematic</h4>

![Sketch_schem%5B6%5D.png](Sketch_schem%5B6%5D.png)  <h4>Code</h4>  <h5>C#</h5>
<blockquote>   <pre class="csharpcode"><span class="kwrd">using</span> System;
<span class="kwrd">using</span> System.IO.Ports;
<span class="kwrd">using</span> System.Threading;

<span class="kwrd">namespace</span> ArduinoDay10
{
    <span class="kwrd">class</span> Program
    {
        <span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            var SerialPort = <span class="kwrd">new</span> SerialPort()
            {
                PortName = <span class="str">&quot;COM7&quot;</span>,
                BaudRate = 9600
            };

            SerialPort.Open();

            <span class="kwrd">for</span>(<span class="kwrd">int</span> i = 0; i &lt; 50; i++)
            {
                var SerialOutput = (i % 3).ToString();
                Console.WriteLine(<span class="str">&quot;Sending {0}&quot;</span>, SerialOutput);
                SerialPort.Write(SerialOutput);
                Thread.Sleep(500);
            }

            SerialPort.Close();
        }
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

<span class="kwrd">void</span> loop() {
  <span class="kwrd">if</span> (Serial.available() &gt; 0) {
    <span class="rem">// read the incoming byte:</span>
    <span class="kwrd">int</span> Byte = Serial.read();
    
    <span class="kwrd">int</span> Led = Byte - 48;
    
    <span class="kwrd">if</span>(0 &lt;= Led &amp;&amp; Led &lt;= 2){
      Ding(Led);
      delay(50);
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
  
  <span class="rem">// light on</span>
  digitalWrite(LedPins[light], HIGH);
  
  <span class="rem">// play tone</span>
  <span class="kwrd">for</span> (<span class="kwrd">long</span> i = 0; i &lt; Iterations; i++ )
  {
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
  
  <span class="rem">// light off</span>
  digitalWrite(LedPins[light], LOW);
}</pre>
</blockquote>

<h4>Next Steps</h4>






Ultimately I want to drive this from a Hudson CI build feed so I’ll continue working on that in the coming days. 

---

## 2 comments captured from [original post](https://blog.wassupy.com/2010/11/arduino-day-10-pc-input.html) on Blogger

**Unknown said on 2013-04-29**

What components are used?

What value resistor is used?

thanks

**Michael Haren said on 2013-04-29**

Dyota,

I don't remember off hand, but it looks like I did go to the trouble to apply color codes to the images so you ought to be able to look them up from there.

