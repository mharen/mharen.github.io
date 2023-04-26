---
layout: post
date: '2011-11-03T14:55:00.001-04:00'
categories:
- easter-eggs
- in-the-news
- random-updates
- nablopomo-2011
- technology
title: "How the Google Search \u201CDo a barrel roll\u201D Works"
---

As a web guy I was intrigued by today’s Google easter egg. If you haven’t heard, go to Google and search for “[Do a barrel roll](https://www.google.com/search?q=do+a+barrel+roll)”. If you’re using a decent browser, the entire page will do fun things.

![google home page doing a barrel roll](/assets/2011/barrel-roll.png)

How do they do it? I jumped into the source to see. It’s a simple CSS transition:

```css
@-moz-keyframes roll    { 100% { -moz-transform: rotate(360deg); } } 
@-o-keyframes roll      { 100% { -o-transform: rotate(360deg); } } 
@-webkit-keyframes roll { 100% { -webkit-transform: rotate(360deg); } } 

body{ 
    border: 1px solid #000;

    -moz-animation-name: roll;
    -moz-animation-duration: 4s;
    -moz-animation-iteration-count: 1;
    
    -o-animation-name: roll;
    -o-animation-duration: 4s;
    -o-animation-iteration-count: 1;
    
    -webkit-animation-name: roll;
    -webkit-animation-duration: 4s;
    -webkit-animation-iteration-count: 1; 
}
```

Nice and easy, eh? Now go play with [this fiddle](http://jsfiddle.net/mharen/KRkvE/3/).