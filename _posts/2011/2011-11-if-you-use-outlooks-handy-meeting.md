---
layout: post
date: '2011-11-14T23:00:00.001-05:00'
categories:
- work
- nablopomo 2011
- technology
title: 'Outlook Tip: Automatically Archive Annoying Meeting Invitation Responses'
---


If you use Outlook’s handy meeting request feature to plan events like presentations and lunches involving a lot of people, you have probably experienced this shortly after sending out an invite:

![image%5B4%5D.png](image%5B4%5D.png)

For the unitiated, what you’re looking at is the flurry of responses that come in after the invite goes out. Outlook uses actual emails to keep track of people accepting/declining invites. And by default, they all just show up in your inbox. 

Normally when something like this comes up, I just create a rule to take care of it. This case is no different but it’s not as simple as it seems. The problem is that when accepting or declining an invite, Outlook lets you add a message:

![image%5B14%5D.png](image%5B14%5D.png)  

I don’t want to automatically process or hide the responses if the sender went to the trouble to actually write something inside. With that in mind, I have the following rule:

![image%5B13%5D.png](image%5B13%5D.png)

Basically, the rule executes whenever a message is sent just to me and has the telltale text in the subject. But, if the message *body* contains any text, leave the message in place. I couldn’t find any reasonable way to check if the body contains any text, so I had to resort to the hack of just checking for vowels. I guess you could add all the letters of the alphabet…but that’d just be silly.

[Here’s the rule](http://dl.dropbox.com/u/11272726/blog/Hide%20Annoying%20Meeting%20Responses.rwz) if you just want to import it (and update the move-to folder). If that makes you nervous (it should!), it’s not hard to recreate from the above screenshot.

Once in place, your inbox should be nice and clean again…or at least not cluttered by empty RSVPs.