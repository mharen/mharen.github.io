---
layout: post
date: '2010-03-05T18:08:00.001-05:00'
categories:
title: Active Directory Look-Up
---

I’ve been told that these programming posts are not interesting or funny. For those that have no interest in programming, I offer the following joke:

> I was gonna get a candy bar; the button I was supposed to push was ‘HH’, so I went to the side, I found the ‘H’ button, I pushed it twice. F’in...potato chips came out, man, because they had an ‘HH’ button for Christ's sake! You need to let me know. I'm not familiar with the concept of ‘HH’. I did not learn my AA-BB-CC's. God god, dammit dammit 
> 
> – [Mitch Hedberg](http://www.mitchhedberg.net/) ([via](http://en.wikiquote.org/wiki/Mitch_Hedberg))

Now would be a good time for you to stop reading.  

***

I’ve been working on an app that’s defers authentication to the company’s Active Directory. Rather than ask user’s to fill in profile info like a display name, I decided to pull this info out of the directory.

This turned out to be ridiculously easy after adding a reference to `System.DirectoryServices.AccountManagement to the project`:  

```cs
using (var PC = new PrincipalContext(ContextType.Domain))
{
    var UserPrincipal = Principal.FindByIdentity(PC, userName);
}
```
 
In this case, we’re passing along the user’s NT name, including the domain to help make it unique (e.g. “domain\user”) and getting back an object of type [System.DirectoryServices.AccountManagement.Principal](http://msdn.microsoft.com/en-us/library/system.directoryservices.accountmanagement.principal(v=VS.90).aspx), which has some [nice properties](http://msdn.microsoft.com/en-us/library/system.directoryservices.accountmanagement.principal_members(v=VS.90).aspx) like `DisplayName` and `Sid`.

Since I’m running this app as a domain user, I don’t even have to configure the directory connection (which is nice, because that part’s a pain).

***

OK so I have the user’s name, but I’m rarely a fan of duplicating data. But I need a *local* copy of the user’s name to keep things nice and speedy (plus hitting the domain for a person’s name all the time is a little silly, too). 

My compromise is that I update my local copy with the directory’s profile data each time the user logs in. I’m already hitting the domain to authenticate the user any way so it’s not any extra work. This should take care of the rare situation that someone’s name or profile info changes without requiring anyone to do anything.