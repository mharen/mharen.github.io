---
layout: post
date: '2010-03-10T12:01:00.001-05:00'
categories: technology
title: "Building URLs for \u201CSRC\u201D Attributes in ASP.NET MVC"
---


I’ve been told that these programming posts are not interesting or funny. For those that have no interest in programming, I offer the following jokes: 
<blockquote> 

“Chuck Norris can divide by zero”   

“Chuck Norris can touch MC Hammer”  

“Chuck Norris CAN believe it's not butter.”
</blockquote>

–[Chuck Norris Facts](http://www.chucknorrisfacts.com/chuck-norris-top-50-facts) 

Now would be a good time for you to stop reading. 

   
***

Dive into ASP.NET MVC and it won’t be long before you do this in a master page:  
```cs
    <link type="text/css" rel="Stylesheet" href="~/Content/all-src.min.css" />
    <script type="text/javascript" src="~/Scripts/all-src.min.js"></script>
```
 
This of course includes a couple global files—one for styles and one for scripts. Here’s the rub: it doesn’t work at all. It’ll seem like it works at first, because you’ll have nice styles and some of your scripts might even work, but it will be a short-lived experience.


Unfortunately something funny is going on here. Those URLs are not valid—they’re more than relative (relative URLs are fine), they’re relative from an application root, denoted by the tilde (`~`). That tilde means nothing to the browser. 


Now the funny business is that ASP.NET will rewrite the link tag *automatically* to include the correct relative URL by replacing the “`~`” with the appropriate path. It *does not *do that with script tags. So you try to be clever and use a web-friendly relative URL syntax like this:


```cs
    <script type="text/javascript" src="../../Scripts/all-src.min.js"></script>
```
 
Sorry, that doesn’t cut it. The “`../../`” will only work properly if the content page (which uses the master page) is nested 2-levels deep, which is not likely to be true very often.


The trick is to call into `Url.Content` or `Url.Content` like so:


```cs
    <script type="text/javascript" src="<%=**Url.Content**("~/Scripts/all-src.min.js")%>"></script>
```
 
This extra step will give me a nice URL, regardless of the page’s depth in my tree. So what’s the difference between [`Url.Content`](http://aspnet.codeplex.com/sourcecontrol/network/Show?projectName=aspnet&changeSetId=23011#266520) and [`Url.Content`](http://msdn.microsoft.com/en-us/library/system.web.ui.control.resolveurl.aspx)? `ResolveUrl` has been around *forever* as part of `Url.Content`. On the other hand, `Url.Content` is relatively new and ships as part of `Url.Content`. Aside from that, I have no idea—if you do, [please share](http://stackoverflow.com/questions/2418050).


Note: these commands work pretty much everywhere—`imgs`, `Url.Content`, etc.