---
layout: post
date: '2012-07-25T20:16:00.001-04:00'
categories:
- code
- technology
title: Let the Browser Handle the Datepicker (if it can)
---

I built a simple data entry app a while back and took the opportunity to try out a lot of neat new things in the web world. This included using [Modernizr](http://modernizr.com/) to detect native date picker support shipping in some browsers.

Traditionally, I’d just toss a Javascript date picker like the one from the excellent [jQuery UI library](http://jqueryui.com/demos/datepicker/) when needed but now that browsers are starting to support other [input types](http://www.w3.org/TR/html-markup/input.html#input), e.g. `<input type="date"/>`, it’s possible to use the JS pickers as a *fallback*.

This idea isn’t novel with me, of course. I first saw it in one of Scott Hanselman’s talks (I can’t find a link at the moment, but I did find another MS blogger that [does pretty much the same thing in great detail](http://www.asp.net/mvc/tutorials/javascript/using-the-html5-and-jquery-ui-datepicker-popup-calendar-with-aspnet-mvc/using-the-html5-and-jquery-ui-datepicker-popup-calendar-with-aspnet-mvc-part-4)). If what I present below is too light on detail, go read his post.

Here’s how I did it in [my ASP.NET MVC project](https://github.com/mharen/service-tracker/):

First, create an editor template to render DateTime properties:
```cs
// in Views/Shared/EditorTemplates/DateTime.cshtml
﻿@model DateTime?
@{ 
     var value = (Model != null && Model != DateTime.MinValue)
        ? Model.Value.ToString("yyyy-MM-dd") 
        : ""; 
}
@Html.TextBox("", value, new { type = "date" })
```

Now whenever you call “EditorFor” with a DateTime in a view, it will use that EditorTemplate to render it. If you’ve been using “EditorFor” all along, you’re in good shape.

Then the only other thing you need is to attach a datepicker if the browser needs it. I dropped this into my global scripts file, which runs on every single page:

```cs
// attach the jquery datepicker unless the current browser has one
if (!Modernizr.inputtypes.date) {
    $("input[type=date]").datepicker();
}
```

The theory here is that now when a browser adds support for native datepickers, the site will automatically *stop adding the jQuery datepicker*. Slick.

Here’s an example. If you try this in Chrome (added sometime on or before version 20...?), the second input should be a native datepicker:

![](/assets/2012/SNAG-0045.png)

Oh, and by the way, this is especially great for mobile devices—this is supported on iOS but [not much else](http://caniuse.com/#feat=input-datetime) (yet).