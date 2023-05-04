---
layout: post
date: '2010-11-13T23:59:00.000-05:00'
categories:
- 30-days-of-arduino
- arduino
- code
- technology
title: 'Arduino Day 13: Weather Bug'
---

**Tip!** This post is part of [a series](/tag/30-days-of-arduino) on my adventures with Arduino

Today’s quick and simple adaptation of Thursday’s build was suggested by my brother, Chris. It’s a simple traffic light view of the weather:

The app parses XML files from the Internet and extracts a temperature value. If the temperature is less than 30 or over 100, it lights the red LED. If it’s between 30 and 60 or 90 and 100, the yellow LED lights. If it’s in the remaining sweet spot of 60-90, the green LED lights.  

![]({{ "/assets/2010/IMAG0772.jpg" | relative_url }})
![]({{ "/assets/2010/IMAG0773.jpg" | relative_url }})
![]({{ "/assets/2010/IMAG0774.jpg" | relative_url }})

Build, circuit, schematic, and Arduino code are identical to my [previous project](../../2010/11/arduino-day-11-extreme-feedback-for.html). 

#### C# (Updated)

```c
static void Main(string[] args)
{

    var SerialPort = new SerialPort()
    {
        PortName = "COM7",
        BaudRate = 9600
    };

    while (true)
    {
        try
        {
            SerialPort.Open();
            string SerialOutput = null;

            // Miami, Florida
            //var StatusXml = XDocument.Load(@"http://www.weather.gov/xml/current_obs/display.php?stid=KTMB");

            // Akron, Ohio
            var StatusXml = XDocument.Load(@"http://www.weather.gov/xml/current_obs/KCAK.xml");

            // Nome, Alaska
            // var StatusXml = XDocument.Load(@"http://www.weather.gov/xml/current_obs/PAOM.xml");

            float Temperature = float.Parse(StatusXml.Root.Element("temp_f").Value);

            if (Temperature < 30 || Temperature > 100)
            {
                SerialOutput = "2"; // red
            }
            else if (Temperature < 60 || Temperature > 90)
            {
                SerialOutput = "1"; // yellow
            }
            else
            {
                SerialOutput = "0"; // green
            }
            Console.WriteLine("Sending {0}", SerialOutput);
            SerialPort.Write(SerialOutput);

            Thread.Sleep(TimeSpan.FromMinutes(1));
        }
        finally
        {
            SerialPort.Close();
        }
    }
}
```

#### Next Steps

More projects!