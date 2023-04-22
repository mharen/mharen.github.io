---
date: '2011-02-03T11:39:00.001-05:00'
description: ''
published: true
slug: 2011-02-trouble-creating-windows-services-with
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Windows
- Work
- Usability
- Technology
- legacy-blogger
time_to_read: 5
title: "Trouble Creating Windows Services With \u201Csc.exe create\u201D"
---


I was recently tasked with figuring out why a seemingly correct call to sc.exe wasn’t working. This turned into an exercise in frustration as I tried the command about 50 different ways. This is close, but not close enough:
<blockquote>   <pre><strong>** Don’t do this—it doesn’t work (keep reading) **
</strong>C:\&gt;sc.exe create ServiceName binpath=&quot;C:\Path\Service.exe -args&quot;
                              depend=&quot;tcpip&quot;
                              DisplayName=&quot;Service Name&quot;

DESCRIPTION: Creates a service entry in the registry and Service Database.
USAGE: sc &lt;server&gt; create [service name] [binPath= ] &lt;option1&gt; &lt;option2&gt;...
OPTIONS:
NOTE: The option name includes the equal sign.
 type= &lt;own|share|interact|kernel|filesys|rec&gt;
       (default = own)
 start= &lt;boot|system|auto|demand|disabled&gt;
       (default = demand)
 error= &lt;normal|severe|critical|ignore&gt;
       (default = normal)
 binPath= &lt;BinaryPathName&gt;
 group= &lt;LoadOrderGroup&gt;
 tag= &lt;yes|no&gt;
 depend= &lt;Dependencies(separated by / (forward slash))&gt;
 obj= &lt;AccountName|ObjectName&gt;
       (default = LocalSystem)
 DisplayName= &lt;display name&gt;
 password= &lt;password&gt;</pre>
</blockquote>


It unhelpfully just dumps the usage information without telling me what I did wrong. After screwing around with it for far too long, I finally figured it out. It says that each “option name includes the equal sign”, but <strong>it also includes the space after the equal sign</strong>.


It turns out that a literal, precise interpretation of the command line arguments is needed:

<blockquote>
  <pre>

C:\&gt;sc.exe create ServiceName binpath=<font style="background-color: #ffff00;"> </font>&quot;C:\Path\Service.exe -args&quot; 
                              depend=<font style="background-color: #ffff00;"> </font>&quot;tcpip&quot; 
                              DisplayName=<font style="background-color: #ffff00;"> </font>&quot;Service Name&quot;
[SC] CreateService SUCCESS
</pre>
</blockquote>


![image%5B3%5D.png](image%5B3%5D.png)Obvious, right? :/ I’m sure the devs have their reasons for this unusual parsing requirement but it’s definitely a big usability fail.


Interestingly, while preparing this post I learned that the help info *has been improved* in Windows 7 and Windows Server 2008:

<blockquote>
  <pre>NOTE: The option name includes 
      the equal sign.
      <strong>A space is required between 
      the equal sign and the value.</strong></pre>
</blockquote>


So I guess *now it’s documented*, but still a usability fail.

---

## 8 comments captured from [original post](https://blog.wassupy.com/2011/02/trouble-creating-windows-services-with.html) on Blogger

**wolverine said on 2012-05-17**

Thanks a lot. It helped.

**Unknown said on 2013-01-10**

Gracias me ayudado demasiado.

**Zafar Iqbal said on 2013-02-23**

Thanks dear  its working 



**Unknown said on 2013-04-01**

That solved my problem, thanks!

**movie2one said on 2013-09-18**

Thank you, you have saved my time..

**Unknown said on 2013-10-31**

Big thanks from me too.

What an awful piece of work sc.exe is for something so important. Really pathetic.

**Luisma said on 2014-07-01**

Thank you so much. I was going crazy before this.

You should post ir on StackOverflow.com

Best regards,

**Kaziu said on 2015-01-28**

It seems to be fixed now, doesn't it? I didn't put the spaces and it works fine.

