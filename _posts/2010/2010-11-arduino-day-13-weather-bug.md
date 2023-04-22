---
date: '2010-11-13T23:59:00.000-05:00'
description: ''
published: true
slug: 2010-11-arduino-day-13-weather-bug
categories:
- 30 Days Of Arduino
- Arduino
- Code
- Technology
time_to_read: 5
title: 'Arduino Day 13: Weather Bug'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30%20Days%20Of%20Arduino) on my adventures with Arduino</div>

Today’s quick and simple adaptation of Thursday’s build was suggested by my brother, Chris. It’s a simple traffic light view of the weather:

The app parses XML files from the Internet and extracts a temperature value. If the temperature is less than 30 or over 100, it lights the red LED. If it’s between 30 and 60 or 90 and 100, the yellow LED lights. If it’s in the remaining sweet spot of 60-90, the green LED lights.  

![IMAG0774%5B4%5D.jpg](IMAG0774%5B4%5D.jpg)

Build, circuit, schematic, and Arduino code are identical to my [previous project](../2010/2010-11-arduino-day-11-extreme-feedback-for.html" target="_blank).  <h4>C# (Updated)</h4>
<blockquote>   <pre class="csharpcode"><span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
{

    var SerialPort = <span class="kwrd">new</span> SerialPort()
    {
        PortName = <span class="str">&quot;COM7&quot;</span>,
        BaudRate = 9600
    };

    <span class="kwrd">while</span> (<span class="kwrd">true</span>)
    {
        <span class="kwrd">try</span>
        {
            SerialPort.Open();
            <span class="kwrd">string</span> SerialOutput = <span class="kwrd">null</span>;

            <span class="rem">// Miami, Florida</span>
            <span class="rem">//var StatusXml = XDocument.Load(@&quot;http://www.weather.gov/xml/current_obs/display.php?stid=KTMB&quot;);</span>

            <span class="rem">// Akron, Ohio</span>
            var StatusXml = XDocument.Load(<span class="str">@&quot;http://www.weather.gov/xml/current_obs/KCAK.xml&quot;</span>);

            <span class="rem">// Nome, Alaska</span>
            <span class="rem">// var StatusXml = XDocument.Load(@&quot;http://www.weather.gov/xml/current_obs/PAOM.xml&quot;);</span>

            <span class="kwrd">float</span> Temperature = <span class="kwrd">float</span>.Parse(StatusXml.Root.Element(<span class="str">&quot;temp_f&quot;</span>).Value);

            <span class="kwrd">if</span> (Temperature &lt; 30 || Temperature &gt; 100)
            {
                SerialOutput = <span class="str">&quot;2&quot;</span>; <span class="rem">// red</span>
            }
            <span class="kwrd">else</span> <span class="kwrd">if</span> (Temperature &lt; 60 || Temperature &gt; 90)
            {
                SerialOutput = <span class="str">&quot;1&quot;</span>; <span class="rem">// yellow</span>
            }
            <span class="kwrd">else</span>
            {
                SerialOutput = <span class="str">&quot;0&quot;</span>; <span class="rem">// green</span>
            }
            Console.WriteLine(<span class="str">&quot;Sending {0}&quot;</span>, SerialOutput);
            SerialPort.Write(SerialOutput);

            Thread.Sleep(TimeSpan.FromMinutes(1));
        }
        <span class="kwrd">finally</span>
        {
            SerialPort.Close();
        }
    }
}</pre>
</blockquote>

<h4>Next Steps</h4>


More projects!