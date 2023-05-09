---
layout: post
date: '2010-10-07T17:31:00.001-04:00'
categories: technology
title: Why Computers Suck, Part 1
---

I work with a lot of remote machines and this usually involves some fairly unpolished VPN software. Today’s experience definitely takes the cake. 

When *you* login to your computer, here’s what probably happens:  

  1. Turn on computer     
  2. Possibly enter username/password

Done.

Here’s how *I* login:  

1\. Turn on my computer

2\. Enter username/password

3\. Launch Internet Explorer and go to specific address

4\. Skip an SSL warning by clicking “Continue to this website (not recommended)” 

{% imagesize /assets/2010/computers-suck-1.png:img %}

5\. Enter my numeric user ID, which I retrieve from an email since I can’t remember it and my PIN, and my RSA token code (changes every 60 seconds):

{% imagesize /assets/2010/computers-suck-2.png:img %}

{% imagesize /assets/2010/computers-suck-3.png:img %}


6\. Install some VMWare addon thingy

7\. Enter my login again, but this time with a different password that I also can’t remember, and choose a different domain:

{% imagesize /assets/2010/computers-suck-4.png:img %}

8\. Then I accept a meaningless security warning:

{% imagesize /assets/2010/computers-suck-5.png:img %}

9\. And ignore a JS error:

{% imagesize /assets/2010/computers-suck-6.png:img %}

10\. Or two:

{% imagesize /assets/2010/computers-suck-7.png:img %}

11\. And another warning; this is getting ridiculous

{% imagesize /assets/2010/computers-suck-8.png:img %}

12\. And another

{% imagesize /assets/2010/computers-suck-9.png:img %}

13\. And finally I’m ready to actually do something:

{% imagesize /assets/2010/computers-suck-10.png:img %}

14\. But the “connection to the View Server is not ready. Please wait.”

{% imagesize /assets/2010/view-server-37.png:img %}

Wait for what? Apparently I took too long doing all of the above and need to start again. Yikes!

It’s completely not cool that this is what computers do to people. With the possible exception of entering my password, I am horrible unqualified to answer the majority of those questions.

As part of my job, I strive to make situations like this less common.

Oh, and in case you’re wondering why I have two RSA tokens in that second picture above, it’s because I have a different one for each company. Handy, right? (No.)

---

### 3 comments

**Michael Haren said on 2010-10-07**

I didn't include the fact that I started this process in Chrome, but it failed so I switched to IE-x64 and it failed, so I switched to IE-x86, and it finally worked.

**Unknown said on 2010-10-07**

But tell me the point of all these shenanigans is that you are logging in from home?

**Michael Haren said on 2010-10-07**

@jb : that's not my situation here, though it might as well be. My situation is that I work as a contractor for many different  companies and each one had their own progress for connecting to their network. 

The processes I posted is better than requiring a dedicated machine, or going to site, but could certainly be improved.

Comments closed
{: .comments-closed }