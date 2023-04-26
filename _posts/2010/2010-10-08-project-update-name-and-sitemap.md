---
layout: post
date: '2010-10-08T14:58:00.001-04:00'
categories:
- technology
- project-noodle
title: 'My New Project Update: Name and Sitemap'
---

1. [My New Project](../../2010/09/my-new-project)
2. [My New Project: Initial Mockups](../../2010/09/my-new-project-initial-mockups)
3. My New Project Update: Name and Sitemap (you are here)
4. [Project Noodle: Initial Database Design](../../2010/10/project-noodle-initial-database-design)
5. [Code Isn't Always the Best Tool](../../2011/03/code-isnt-always-best-tool)
6. [Project Noodle: Terminated](../../2011/03/project-noodle-terminated)

***

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** If you are disoriented, you might want to [browse more posts](http://blog.wassupy.com/search/label/Project Noodle) about this project</div>  <h4>Choosing a Name</h4>

After about 12 seconds of deliberation, I’ve decided to call my interview tracking application “**Noodle**”. This was [Sarah’s](http://footedjammies.blogspot.com/) suggestion. To parry any accusations of bias, I have chosen to award a prize to the runner-up, too. Thank you, [Math Zombie](http://stuffmystudentsdraw.blogspot.com/), for suggesting I use a MacGyver themed names. I will bank that idea for a future project.  <h4>Recent Progress</h4>

I’ve refined the sitemap a bit:  

![image[10].png](/assets/2010/image[10].png)

I have decided to employ a little discipline by working out the models, views, and controllers—the essential elements to an ASP.NET MVC application—*before *I begin coding. Here’s what I have so far:  

![image[32].png](/assets/2010/image[32].png)

That’s a little messy; let me explain. The `URL` that would be in your browser is the label on the arrows in the first column, e.g. “/candidate-123-john-doe”. When you go to that `URL`, my application will route it through the `Candidate` controller, build a `CandidateDetailsModel`, and present it to you with the `CandidateDetails` view. This detail-heavy image simply attempts to enumerate all the pages—user interfaces—in the application.

Of course I haven’t captured quite *everything*. This thing will eventually support feeds (RSS, Atom, and JSON) and all kinds of help content scattered throughout. Those are version 0.2 features so I’m not going to work through them just yet.

I’ll knock out some preliminary database design next, and then I’ll be ready to create some actual screens.

---

### 3 comments

**Sarah said on 2010-10-08**

I'm touched that you chose my name :D

**Brad Griffith said on 2010-10-09**

What program are you using for your architecture documentation / planning?  I like those sketches!

**Michael Haren said on 2010-10-09**

Those are made with Balsamiq mockups. It's pretty awesome; I use it frequently.

http://www.balsamiq.com/products/mockups/

Awesome company, too.

