---
layout: post
date: '2010-10-24T23:40:00.001-04:00'
categories:
- database
- technology
- project-noodle
title: 'Project Noodle: Initial Database Design'
---

1. [My New Project](../../2010/09/my-new-project)
2. [My New Project: Initial Mockups](../../2010/09/my-new-project-initial-mockups)
3. [My New Project Update: Name and Sitemap](../../2010/10/project-update-name-and-sitemap)
4. Project Noodle: Initial Database Design (you are here)
5. [Code Isn't Always the Best Tool](../../2011/03/code-isnt-always-best-tool)
6. [Project Noodle: Terminated](../../2011/03/project-noodle-terminated)

***

First off: this will change as I go.

Here’s my first pass at the database tables for Project Noodle:

{% imagesize /assets/2010/schema-12.png:img %}

It’s definitely not fully normalized (e.g. `Interviews.{CriterionValue1,2,3}`)—some of that’s intentional. Database design is always a balance.

At this stage, I am really interested in two key things:  

1. Does my schema actually capture all the information I think I need to store?
2. Are the queries I expect to write easy to write?

And so, being the semi-disciplined person I am (or at least when I’m blogging about a recommendation), I will check these two things.   

#### Does my schema cover everything?

In another window I brought up the [mockups](../../2010/09/my-new-project-initial-mockups.html). Right off the bat, I’m finding a gap in what I need to capture and what my schema supports: 
* I don’t have anywhere to store why, when, or where a candidate is to be interviewed 
* I don’t have anywhere to store a candidates picture, or resume 
* I don’t have anywhere to store a candidates actual offer or hire status  


So let’s fix that together. It looks like I need something akin to an “interview master” table which will store the details of a block of interviews. This can’t really go in the candidates table since a single candidate could come in multiple times. 

On the other hand, since HR will likely want to schedule interviews in advance, perhaps I could just create an interview record for each user when the interviews are setup. Then, I can group them by date on the Upcoming Interviews screen. 

Having been down this road before, I’m opting for a master table. I’ve found that it helps solve a lot of problems that may not be obvious just yet and it’s probably The Right Thing To Do. Here we go:

{% imagesize /assets/2010/schema-16.png:img %}

A more enterprisey solution would probably break out the ratings from the `Interviews` table, move the photo and resume columns from `Candidates` into a full blown files table, add a `Locations` table to hold conference rooms, and a `CandidateTypes` table for values like “SW Coop”. 

I’m opting for the much simpler structure above, deferring that refactoring until a significant problem demands that they be made.  

#### Are my obvious queries easy?

I know I want to display a list of interviews with who/when/why/where information. It looks like I can get all that from the `InterviewMasters` and `Candidates` tables. It now occurs to me that I don’t have a way to archive interviews. I’ll ignore that for now and come back to it if it becomes an issue.

I also need to be able to CRU interview details (rankings). This should be very simple with the `Interviews` table and a couple easy joins.

Finally, I need to be able to aggregate interview feedback from many interviewers into a single view. This also looks very straight forward.

It looks like I haven’t gone overboard with the normalization because I don’t see any red flags so far. I’ve also opted to do no history or versioning, which has helped to avoid a lot of complexity with all of the above queries.  

#### Next

Next up is probably some actual screen development and code.