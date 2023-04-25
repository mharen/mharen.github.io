---
layout: post
date: '2011-02-03T11:39:00.001-05:00'
categories:
- windows
- work
- usability
- technology
title: "Trouble Creating Windows Services With \u201Csc.exe create\u201D"
---


I was recently tasked with figuring out why a seemingly correct call to sc.exe wasn’t working. This turned into an exercise in frustration as I tried the command about 50 different ways. This is close, but not close enough:
<blockquote>   <pre><strong>** Don’t do this—it doesn’t work (keep reading) **
</strong>C:\>sc.exe create ServiceName binpath="C:\Path\Service.exe -args"
                              depend="tcpip"
                              DisplayName="Service Name"

DESCRIPTION: Creates a service entry in the registry and Service Database.
USAGE: sc <server> create [service name] [binPath= ] <option1> <option2>...
OPTIONS:
NOTE: The option name includes the equal sign.
 type= <own|share|interact|kernel|filesys|rec>
       (default = own)
 start= <boot|system|auto|demand|disabled>
       (default = demand)
 error= <normal|severe|critical|ignore>
       (default = normal)
 binPath= <BinaryPathName>
 group= <LoadOrderGroup>
 tag= <yes|no>
 depend= <Dependencies(separated by / (forward slash))>
 obj= <AccountName|ObjectName>
       (default = LocalSystem)
 DisplayName= <display name>
 password= <password>
```

</blockquote>


It unhelpfully just dumps the usage information without telling me what I did wrong. After screwing around with it for far too long, I finally figured it out. It says that each “option name includes the equal sign”, but **it also includes the space after the equal sign**.


It turns out that a literal, precise interpretation of the command line arguments is needed:

<blockquote>
  <pre>

C:\>sc.exe create ServiceName binpath=<font style="background-color: #ffff00;"> </font>"C:\Path\Service.exe -args" 
                              depend=<font style="background-color: #ffff00;"> </font>"tcpip" 
                              DisplayName=<font style="background-color: #ffff00;"> </font>"Service Name"
[SC] CreateService SUCCESS

```

</blockquote>


![image[3].png](/assets/2011/image[3].png)Obvious, right? :/ I’m sure the devs have their reasons for this unusual parsing requirement but it’s definitely a big usability fail.


Interestingly, while preparing this post I learned that the help info *has been improved* in Windows 7 and Windows Server 2008:

<blockquote>
  <pre>NOTE: The option name includes 
      the equal sign.
      <strong>A space is required between 
      the equal sign and the value.</strong>
```

</blockquote>


So I guess *now it’s documented*, but still a usability fail.

---

### 8 comments

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

