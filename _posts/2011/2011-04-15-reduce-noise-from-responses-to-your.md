---
layout: post
date: '2011-04-15T10:45:00.001-04:00'
categories:
- work
- technology
title: Reduce Noise from Responses To Your Outlook Meeting Requests
---

I give tech talks to my company’s developers about every other month and each time I send out a meeting request to a large group of people. The few days that follow my meeting request are filled with uninteresting responses—RSVPs from those that can/cannot attend. Like this:

![](/assets/2011/2011-04-15-5.png)

Of course I could mark the request as “no response requested” but I really do need to know how many people are planning to attend so I can have enough space/food available.

There’s a setting in Outlook to automatically process meeting requests and such. I don’t want to use that because I’m not sure it works on responses and even if it does, I don’t want to miss the occasional response that’s been manually edited before being sent. 

Here’s what I came up with instead:

![](/assets/2011/2011-04-15-2.png)

This is a mail rule catches messages that look like meeting request responses and moves them directly to my archive *unless *they contain any text in the body. This has been working quite well for months as any boilerplate reply goes straight to my archive while anything with a custom response still shows up in my inbox.

This could almost certainly be improved, e.g.: 

* There’s probably a built-in way of detecting meeting responses besides searching the subject
* There’s probably a built-in way of detecting if the user has edited the response besides checking the body for any vowel
* There’s possibly a built-in way to do this whole thing, hiding as an elusive checkbox eight layers deep in the options somewhere 

I couldn’t find solutions to those in the five minutes I spent making this hack. If you have a better way of doing this, please share in the comments!