---
date: '2012-11-02T22:24:00.001-04:00'
description: ''
published: true
slug: 2012-11-how-dropbox-with-two-factor
tags:
- http://schemas.google.com/blogger/2008/kind#post
- NaBloPoMo 2012
- Technology
- legacy-blogger
time_to_read: 5
title: How Dropbox with Two-Factor Authentication Neatly Handles Application Specific
  Passwords
---

<p>I am a long time fan of Dropbox and <a href="http://support.google.com/accounts/bin/answer.py?hl=en&amp;answer=180744">two-factor authentication</a> (there’s a cool video there that explains what two-factor auth is if it’s news to you). When Dropbox added support for the “pain in the ass but worth it” way of making my data super (SUPER!) safe, I jumped on board.</p>
<p>It didn’t occur to me until today, though, how they handle application-specific passwords. That is, passwords for apps that aren’t aware of this two-factor business.</p>
<p>Google handles this in a pretty straight forward (but painful) way by simply letting you create application specific passwords as you need them:</p>
<p>![asp2%25255B2%25255D.png](asp2%25255B2%25255D.png)</p>
<p>So when my phone’s document scanning app (<a href="https://itunes.apple.com/us/app/jotnot-scanner/id307868751?mt=8">JotNot</a>) complained that I couldn’t connect it to Dropbox, I realized the issue was that I had added two-factor authentication since I hooked the two things together. So I went looking for a way to generate an application-specific password for the app. </p>
<p>I was surprised that I couldn’t find a way to do this so I turned to Google and <a href="http://blog.binaryfactory.ca/2012/08/dropbox-two-step-authentication/">found this</a>:</p>
<blockquote> 
<p>“The menu to create application specific passwords doesn’t seem to be directly available, but don’t worry, as soon as you will add a new app, <strong>Dropbox will detect the failure to login and email you the link to create an application specific password.</strong>”</p>
</blockquote>
<p>Oh. Alright, let’s try that! I opened up the app and entered my Dropbox login and it failed (expected) and received this in my email:</p>
<p>![expired%25255B2%25255D.png](expired%25255B2%25255D.png)</p>
<p>OK, that’s true—my password is probably pretty old. I skipped the link here (phishing and all that) and just went directly to the dropbox website to change my password since apparently it has “expired.” Then I tried to login with my scanning app again. It failed (again, expected) but this time I got this in my email:</p>
<p>![add%25255B2%25255D.png](add%25255B2%25255D.png)</p>
<p>Neat! Let’s do that.</p>
<p>![uber%252520secret%25255B2%25255D.png](uber%252520secret%25255B2%25255D.png)</p>
<p>Cool, there is (at least before I sanitized it for this blog) a longish, random password I can enter on my phone.</p>  <p align="center">![2012-11-02%25252021.37.27%25255B3%25255D.png](2012-11-02%25252021.37.27%25255B3%25255D.png)</p>
<p>Woot! Now I’m linked up and can continue scanning documents into my Dropbox.</p>
<p>So how do Google and Dropbox compare in their approaches? <strong>I really, really like that Dropbox sends you an email when you need an application specific password.</strong> This is great because the app itself didn’t give me any useful indication that this was the issue (it just said my login was bad). This is a brilliant idea.</p>
<p>It would be nice if Dropbox allowed me to just go and add the new password without waiting on the email. Or they could at least add a note near their password settings in my profile explaining how this works (or maybe I missed it). Two-factor is a pain (without it, none of the above would have happened), but considering the benefits, and how smoothly it’s been implemented, I highly recommend it.</p>