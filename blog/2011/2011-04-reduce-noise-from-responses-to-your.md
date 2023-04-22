---
date: '2011-04-15T10:45:00.001-04:00'
description: ''
published: true
slug: 2011-04-reduce-noise-from-responses-to-your
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: Reduce Noise from Responses To Your Outlook Meeting Requests
---

<p>I give tech talks to my company’s developers about every other month and each time I send out a meeting request to a large group of people. The few days that follow my meeting request are filled with uninteresting responses—RSVPs from those that can/cannot attend. Like this:</p>
<p>![image%5B5%5D.png](image%5B5%5D.png)</p>
<p>Of course I could mark the request as “no response requested” but I really do need to know how many people are planning to attend so I can have enough space/food available.</p>
<p>There’s a setting in Outlook to automatically process meeting requests and such. I don’t want to use that because I’m not sure it works on responses and even if it does, I don’t want to miss the occasional response that’s been manually edited before being sent. </p>
<p>Here’s what I came up with instead:</p>
<p>![image%5B2%5D.png](image%5B2%5D.png)</p>
<p>This is a mail rule catches messages that look like meeting request responses and moves them directly to my archive <em>unless </em>they contain any text in the body. This has been working quite well for months as any boilerplate reply goes straight to my archive while anything with a custom response still shows up in my inbox.</p>
<p>This could almost certainly be improved, e.g.:</p>  <ul>   <li>There’s probably a built-in way of detecting meeting responses besides searching the subject</li>    <li>There’s probably a built-in way of detecting if the user has edited the response besides checking the body for any vowel</li>    <li>There’s possibly a built-in way to do this whole thing, hiding as an elusive checkbox eight layers deep in the options somewhere</li> </ul>
<p>I couldn’t find solutions to those in the five minutes I spent making this hack. If you have a better way of doing this, please share in the comments!</p>