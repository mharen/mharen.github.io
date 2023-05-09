---
layout: post
date: '2011-11-14T23:00:00.001-05:00'
categories:
- work
- nablopomo-2011
- technology
title: 'Outlook Tip: Automatically Archive Annoying Meeting Invitation Responses'
---

If you use Outlook’s handy meeting request feature to plan events like presentations and lunches involving a lot of people, you have probably experienced this shortly after sending out an invite:

{% imagesize /assets/2011/inbox.png:img alt='an email inbox full of meeting responses' %}

For the unitiated, what you’re looking at is the flurry of responses that come in after the invite goes out. Outlook uses actual emails to keep track of people accepting/declining invites. And by default, they all just show up in your inbox. 

Normally when something like this comes up, I just create a rule to take care of it. This case is no different but it’s not as simple as it seems. The problem is that when accepting or declining an invite, Outlook lets you add a message:

{% imagesize /assets/2011/accept-meeting.png:img alt='a screenshot of an outlook user accepting a meeting with a custom message' %}

I don’t want to automatically process or hide the responses if the sender went to the trouble to actually write something inside. With that in mind, I have the following rule:

{% imagesize /assets/2011/rule.png:img alt="an outlook rule with the following highlighted: 'Apply this rule after the message arrives where my name is in the To box *and* sent only to me *and* with 'Accepted:' or 'Declined:' or Tentative:' in the subject or body; move it to the '1 Archive' folder; except if the body contains 'a' or 'e' or 'i' or 'o' or 'u' or 'w' or 'y' *or* except if it is marked as high importance" %}

Basically, the rule executes whenever a message is sent just to me and has the telltale text in the subject. But, if the message *body* contains any text, leave the message in place. I couldn’t find any reasonable way to check if the body contains any text, so I had to resort to the hack of just checking for vowels. I guess you could add all the letters of the alphabet...but that’d just be silly.

Once in place, your inbox should be nice and clean again...or at least not cluttered by empty RSVPs.