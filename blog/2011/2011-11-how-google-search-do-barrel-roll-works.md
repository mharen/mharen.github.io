---
date: '2011-11-03T14:55:00.001-04:00'
description: ''
published: true
slug: 2011-11-how-google-search-do-barrel-roll-works
tags:
- Easter Eggs
- http://schemas.google.com/blogger/2008/kind#post
- In the News
- Random Updates
- NaBloPoMo 2011
- Technology
- legacy-blogger
time_to_read: 5
title: "How the Google Search \u201CDo a barrel roll\u201D Works"
---

<p>As a web guy I was intrigued by today’s Google easter egg. If you haven’t heard, go to Google and search for “<a href="https://www.google.com/search?q=do+a+barrel+roll">Do a barrel roll</a>”. If you’re using a decent browser, the entire page will do fun things.</p>
<p><img alt="image" height="453" src="http://lh5.ggpht.com/-TCId5Qsr-qI/TrLjlDS6A6I/AAAAAAAAD70/TOfsYrt3u3E/image%25255B4%25255D.png" style="margin: 3px auto; display: block; float: none;" title="image" width="700" /></p>
<p>How do they do it? I jumped into the source to see. It’s a simple CSS transition:</p>  <pre class="csharpcode">@-moz-keyframes roll    { 100% { -moz-transform: rotate(360deg); } } 
@-o-keyframes roll      { 100% { -o-transform: rotate(360deg); } } 
@-webkit-keyframes roll { 100% { -webkit-transform: rotate(360deg); } } 
body{ 
    border: 1px solid #000;
    -moz-animation-name: roll; -moz-animation-duration: 4s; -moz-animation-iteration-count: 1; 
    -o-animation-name: roll; -o-animation-duration: 4s; -o-animation-iteration-count: 1; 
    -webkit-animation-name: roll; -webkit-animation-duration: 4s; -webkit-animation-iteration-count: 1; 
} </pre>
Nice and easy, eh? Now go play with <a href="http://jsfiddle.net/mharen/KRkvE/3/">this fiddle</a>.