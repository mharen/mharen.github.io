---
layout: post
date: '2010-11-11T23:59:00.000-05:00'
categories:
- 30-days-of-arduino
- arduino
- code
- technology
title: 'Arduino Day 11: Extreme Feedback for Hudson Builds (Includes Chuck Norris
  Cameo)'
---

**Tip!** This post is part of [a series](/search/label/30-days-of-arduino/) on my adventures with Arduino

Improving on yesterday’s build, I added in some actual network-sourced data. My little traffic lights now show the build status of one of my projects:  

<iframe class="full-embed hd" src="https://www.youtube.com/embed/57fANDt9TGo" title="Arduino Day 11: Extreme Feeback: Build Status" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

In case you don’t know what any of that was, let me try to explain. At work I build software, and that software is written in code. We have a server monitor our code and automatically try to build it (convert the code into executable software) whenever it changes. We use an awesome tool called Hudson to do this for us. What I’ve built is called an extreme feedback device because it reports a piece of soft data (the build status) in a physical way (beeping lights).

Whenever the build status changes (any of “success”, “building” or “failed”), the board beeps and lights up the appropriate LED (green, yellow or red).

In the future this tool could be tied to a [mechanical foam dart gun](http://www.thinkgeek.com/computing/accessories/8a0f/) to physically punish whoever broke the build. Speaking of missiles, I saw *Delta Force* recently enough to make this connection: Chuck Norris’s motorcycle *launched missiles*. Yeah.

{% imagesize /assets/2010/chuck-norris-delta-force.jpg:img %}

You might imagine how politically correct and culturally sensitive a 1986 movie about terrorism, with the subtitle “They don't negotiate with terrorists... they blow them away!” is. It’s like *24* with less talk and more explosions.

But a motor cycle that launches missiles. Wow. That picture above, by the way, was presumably from around 25 years ago. Guess how old he was then, and how old he that makes him now:

[![](/assets/2010/Norrishuckabee.jpg)](http://upload.wikimedia.org/wikipedia/en/7/7f/Norrishuckabee.JPG)

70\. Chuck Norris is **seventy** years old. And apparently immortal which is extra scary considering, well, [you know](http://www.chucknorrisfacts.com/). 

#### Build (Repeat)

![](/assets/2010/DSC_00113.jpg) 

#### Circuit (Repeat)

![](/assets/2010/Sketch_bb6.png) 

#### Schematic (Repeat)

![](/assets/2010/Sketch_schem6.png) 

#### Code (Updated)

I started out today by doing all this in Powershell...but ultimately flipped back to full C# because most of my PS code was looking like C# anyway (and I’m very weak with PS).

##### C#

```cs
static void Main(string[] args)
{

    var SerialPort = new SerialPort()
    {
        PortName = "COM7",
        BaudRate = 9600
    };

    try
    {
        SerialPort.Open();
        string SerialOutput = null;

        for(;;)
        {
            var StatusXml = XDocument.Load(@"http://nope/job/jobname/lastBuild/api/xml");

            if (StatusXml.Root.Element("building").Value == "true")
            {
                SerialOutput = "1"; // yellow
            }
            else if (StatusXml.Root.Element("result").Value == "SUCCESS")
            {
                SerialOutput = "0"; // green
            }
            else
            {
                SerialOutput = "2"; // red
            }

            Console.WriteLine("Sending {0}", SerialOutput);
            SerialPort.Write(SerialOutput);
            Thread.Sleep(1000);
        }
    }
    finally
    {
        SerialPort.Close();
    }
}
```

##### Arduino

```c
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

int ActiveLed = 0;

void loop() {
  if (Serial.available() > 0) {
    // read the incoming byte:
    int Byte = Serial.read();
    
    int Led = Byte - 48;
    
    if(0 <= Led && Led <= 2 && ActiveLed != Led){

      // clear all pins to make debugging (i.e. messing up the state of the app) easier
      digitalWrite(LedPins[ActiveLed], LOW);
      digitalWrite(LedPins[Led], HIGH);
      
      ActiveLed = Led;
      Ding(Led);
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
  
  // play tone
  for (long i = 0; i < Iterations; i++ )
  {
      digitalWrite(BuzzPin, HIGH);
      delayMicroseconds(Osc);
      digitalWrite(BuzzPin, LOW);
      delayMicroseconds(Osc);
  }  
}
```

#### Next Steps

I’ve got a busy weekend coming up so I’ll probably just spend a little time refining what I have. I’m open to ideas, though!

---

### 2 comments

**Sarah said on 2010-11-12**

I tried to think of a funny Chuck Norris joke but apparently I am not very witty.  That or it's 1:30 in the morning.  Either way :)

**Michael Haren said on 2010-11-12**

Chuck norris can think of witty jokes at 130am
