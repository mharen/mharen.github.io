---
layout: post
date: '2010-11-10T23:54:00.001-05:00'
categories:
- 30 days of arduino
- arduino
- code
- technology
title: 'Arduino Day 10: PC Input'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** This post is part of [a series](http://blog.wassupy.com/search/label/30 Days Of Arduino) on my adventures with Arduino</div>

I’m starting to lay the groundwork for a larger project that will be driven from network data. I don’t have an Ethernet shield so I’ll drive this from USB. Today’s exercise is simply to verify that I can write data to the board from a higher level program on my computer. In this case, I’m using C#.  

  <h4>Build</h4>

![DSC_0011[3].jpg](/assets/2010/DSC_0011[3].jpg)  <h4>Circuit</h4>

![Sketch_bb[6].png](/assets/2010/Sketch_bb[6].png)  <h4>Schematic</h4>

![Sketch_schem[6].png](/assets/2010/Sketch_schem[6].png)  <h4>Code</h4>  <h5>C#</h5>
```c
using System;
using System.IO.Ports;
using System.Threading;

namespace ArduinoDay10
{
    class Program
    {
        static void Main(string[] args)
        {
            var SerialPort = new SerialPort()
            {
                PortName = "COM7",
                BaudRate = 9600
            };

            SerialPort.Open();

            for(int i = 0; i < 50; i++)
            {
                var SerialOutput = (i % 3).ToString();
                Console.WriteLine("Sending {0}", SerialOutput);
                SerialPort.Write(SerialOutput);
                Thread.Sleep(500);
            }

            SerialPort.Close();
        }
    }
}
```



<h5>Arduino</h5>

<blockquote>
  
```cs
const int BuzzPin = 5;
const int BuzzDuration = 100; 
const int Tones[] = { 1000, 2000, 3000 };
const int LedPins[] = { 9, 10, 11 };

void setup() {
  Serial.begin(9600);

  pinMode(LedPins[0], OUTPUT);    
  pinMode(LedPins[1], OUTPUT);    
  pinMode(LedPins[2], OUTPUT);    
  pinMode(BuzzPin, OUTPUT);
}

void loop() {
  if (Serial.available() > 0) {
    // read the incoming byte:
    int Byte = Serial.read();
    
    int Led = Byte - 48;
    
    if(0 <= Led && Led <= 2){
      Ding(Led);
      delay(50);
    }
  }
}

void Ding(int light){
  // e.g. 1 / 2048Hz = 488uS, or 244uS high and 244uS low
  // to create 50% duty cycle
  // http://www.arduino.cc/cgi-bin/yabb2/YaBB.pl?num=1231194692
  int Osc = 1000000 / Tones[light] / 2; // in microseconds
  
  // compute the number of iterations needed to hold
  // the nfote the desired duration
  int Iterations = Tones[light] * ((float)200 / 1000);
  
  // light on
  digitalWrite(LedPins[light], HIGH);
  
  // play tone
  for (long i = 0; i < Iterations; i++ )
  {
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
  
  // light off
  digitalWrite(LedPins[light], LOW);
}
```



<h4>Next Steps</h4>






Ultimately I want to drive this from a Hudson CI build feed so I’ll continue working on that in the coming days. 

---

### 2 comments

**Unknown said on 2013-04-29**

What components are used?

What value resistor is used?

thanks

**Michael Haren said on 2013-04-29**

Dyota,

I don't remember off hand, but it looks like I did go to the trouble to apply color codes to the images so you ought to be able to look them up from there.

