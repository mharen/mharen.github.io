---
layout: post
date: '2010-10-24T23:40:00.001-04:00'
categories:
- database
- technology
- project noodle
title: 'Project Noodle: Initial Database Design'
---

<div style="border-bottom: #888 1px solid; border-left: #888 1px solid; padding-bottom: 5px; background-color: #eee; margin: 0px auto; padding-left: 5px; width: 200px; padding-right: 5px; float: right; border-top: #888 1px solid; border-right: #888 1px solid; padding-top: 5px;">**Tip!** If you are disoriented, you might want to [browse more posts](http://blog.wassupy.com/search/label/Project%20Noodle) about this project</div>

First off: this will change as I go.

Here’s my first pass at the database tables for Project Noodle:

![image%5B12%5D.png](/assets/2010/image%5B12%5D.png)

It’s definitely not fully normalized (e.g. <code>Interviews.{CriterionValue1,2,3}</code>)—some of that’s intentional. Database design is always a balance.

At this stage, I am really interested in two key things:  <ol>   <li>Does my schema actually capture all the information I think I need to store? </li>    <li>Are the queries I expect to write easy to write? </li> </ol>

And so, being the semi-disciplined person I am (or at least when I’m blogging about a recommendation), I will check these two things.   <h4>Does my schema cover everything?</h4>

In another window I brought up the [mockups](../2010/2010-09-my-new-project-initial-mockups.html). Right off the bat, I’m finding a gap in what I need to capture and what my schema supports:  <ul>   <li>I don’t have anywhere to store why, when, or where a candidate is to be interviewed </li>    <li>I don’t have anywhere to store a candidates picture, or resume </li>    <li>I don’t have anywhere to store a candidates actual offer or hire status </li> </ul>

So let’s fix that together. It looks like I need something akin to an “interview master” table which will store the details of a block of interviews. This can’t really go in the candidates table since a single candidate could come in multiple times. 

On the other hand, since HR will likely want to schedule interviews in advance, perhaps I could just create an interview record for each user when the interviews are setup. Then, I can group them by date on the Upcoming Interviews screen. 

Having been down this road before, I’m opting for a master table. I’ve found that it helps solve a lot of problems that may not be obvious just yet and it’s probably The Right Thing To Do. Here we go:

![image%5B16%5D.png](/assets/2010/image%5B16%5D.png)

A more enterprisey solution would probably break out the ratings from the <code>Interviews</code> table, move the photo and resume columns from <code>Candidates</code> into a full blown files table, add a <code>Locations</code> table to hold conference rooms, and a <code>CandidateTypes</code> table for values like “SW Coop”. 

I’m opting for the much simpler structure above, deferring that refactoring until a significant problem demands that they be made.  <h4>Are my obvious queries easy?</h4>

I know I want to display a list of interviews with who/when/why/where information. It looks like I can get all that from the <code>InterviewMasters</code> and <code>Candidates</code> tables. It now occurs to me that I don’t have a way to archive interviews. I’ll ignore that for now and come back to it if it becomes an issue.

I also need to be able to CRU interview details (rankings). This should be very simple with the <code>Interviews</code> table and a couple easy joins.

Finally, I need to be able to aggregate interview feedback from many interviewers into a single view. This also looks very straight forward.

It looks like I haven’t gone overboard with the normalization because I don’t see any red flags so far. I’ve also opted to do no history or versioning, which has helped to avoid a lot of complexity with all of the above queries.  <h4>Next</h4>

Next up is probably some actual screen development and code.