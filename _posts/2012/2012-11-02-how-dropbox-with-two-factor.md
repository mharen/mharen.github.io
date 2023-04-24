---
layout: post
date: '2012-11-02T22:24:00.001-04:00'
categories:
- nablopomo 2012
- technology
title: How Dropbox with Two-Factor Authentication Neatly Handles Application Specific
  Passwords
---


I am a long time fan of Dropbox and [two-factor authentication](http://support.google.com/accounts/bin/answer.py?hl=en&answer=180744) (there’s a cool video there that explains what two-factor auth is if it’s news to you). When Dropbox added support for the “pain in the ass but worth it” way of making my data super (SUPER!) safe, I jumped on board.

It didn’t occur to me until today, though, how they handle application-specific passwords. That is, passwords for apps that aren’t aware of this two-factor business.

Google handles this in a pretty straight forward (but painful) way by simply letting you create application specific passwords as you need them:

![asp2%5B2%5D.png](/assets/2012/asp2%5B2%5D.png)

So when my phone’s document scanning app ([JotNot](https://itunes.apple.com/us/app/jotnot-scanner/id307868751?mt=8)) complained that I couldn’t connect it to Dropbox, I realized the issue was that I had added two-factor authentication since I hooked the two things together. So I went looking for a way to generate an application-specific password for the app. 

I was surprised that I couldn’t find a way to do this so I turned to Google and [found this](http://blog.binaryfactory.ca/2012/08/dropbox-two-step-authentication/):
<blockquote> 

“The menu to create application specific passwords doesn’t seem to be directly available, but don’t worry, as soon as you will add a new app, **Dropbox will detect the failure to login and email you the link to create an application specific password.**”
</blockquote>

Oh. Alright, let’s try that! I opened up the app and entered my Dropbox login and it failed (expected) and received this in my email:

![expired%5B2%5D.png](/assets/2012/expired%5B2%5D.png)

OK, that’s true—my password is probably pretty old. I skipped the link here (phishing and all that) and just went directly to the dropbox website to change my password since apparently it has “expired.” Then I tried to login with my scanning app again. It failed (again, expected) but this time I got this in my email:

![add%5B2%5D.png](/assets/2012/add%5B2%5D.png)

Neat! Let’s do that.

![uber%20secret%5B2%5D.png](/assets/2012/uber%20secret%5B2%5D.png)

Cool, there is (at least before I sanitized it for this blog) a longish, random password I can enter on my phone.  

![2012-11-02%2021.37.27%5B3%5D.png](/assets/2012/2012-11-02%2021.37.27%5B3%5D.png)

Woot! Now I’m linked up and can continue scanning documents into my Dropbox.

So how do Google and Dropbox compare in their approaches? **I really, really like that Dropbox sends you an email when you need an application specific password.** This is great because the app itself didn’t give me any useful indication that this was the issue (it just said my login was bad). This is a brilliant idea.

It would be nice if Dropbox allowed me to just go and add the new password without waiting on the email. Or they could at least add a note near their password settings in my profile explaining how this works (or maybe I missed it). Two-factor is a pain (without it, none of the above would have happened), but considering the benefits, and how smoothly it’s been implemented, I highly recommend it.