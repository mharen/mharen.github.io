---
date: '2010-10-08T14:58:00.001-04:00'
description: ''
published: true
slug: 2010-10-project-update-name-and-sitemap
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Technology
- Project Noodle
- legacy-blogger
time_to_read: 5
title: 'My New Project Update: Name and Sitemap'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;"><strong>Tip!</strong> If you are disoriented, you might want to <a href="http://blog.wassupy.com/search/label/Project%20Noodle">browse more posts</a> about this project</div>  <h4>Choosing a Name</h4>
<p>After about 12 seconds of deliberation, I’ve decided to call my interview tracking application “<strong>Noodle</strong>”. This was <a href="http://footedjammies.blogspot.com/">Sarah’s</a> suggestion. To parry any accusations of bias, I have chosen to award a prize to the runner-up, too. Thank you, <a href="http://stuffmystudentsdraw.blogspot.com/">Math Zombie</a>, for suggesting I use a MacGyver themed names. I will bank that idea for a future project.</p>  <h4>Recent Progress</h4>
<p>I’ve refined the sitemap a bit:</p>  <p align="center">![image%5B10%5D.png](image%5B10%5D.png)</p>
<p>I have decided to employ a little discipline by working out the models, views, and controllers—the essential elements to an ASP.NET MVC application—<em>before </em>I begin coding. Here’s what I have so far:</p>  <p align="center">![image%5B32%5D.png](image%5B32%5D.png)</p>
<p>That’s a little messy; let me explain. The <code>URL</code> that would be in your browser is the label on the arrows in the first column, e.g. “/candidate-123-john-doe”. When you go to that <code>URL</code>, my application will route it through the <code>Candidate</code> controller, build a <code>CandidateDetailsModel</code>, and present it to you with the <code>CandidateDetails</code> view. This detail-heavy image simply attempts to enumerate all the pages—user interfaces—in the application.</p>
<p>Of course I haven’t captured quite <em>everything</em>. This thing will eventually support feeds (RSS, Atom, and JSON) and all kinds of help content scattered throughout. Those are version 0.2 features so I’m not going to work through them just yet.</p>
<p>I’ll knock out some preliminary database design next, and then I’ll be ready to create some actual screens.</p>

---

## 3 comments captured from [original post](https://blog.wassupy.com/2010/10/project-update-name-and-sitemap.html) on Blogger

**Sarah said on 2010-10-08**

I'm touched that you chose my name :D

**Brad Griffith said on 2010-10-09**

What program are you using for your architecture documentation / planning?  I like those sketches!

**Michael Haren said on 2010-10-09**

Those are made with Balsamiq mockups. It's pretty awesome; I use it frequently.

http://www.balsamiq.com/products/mockups/

Awesome company, too.

