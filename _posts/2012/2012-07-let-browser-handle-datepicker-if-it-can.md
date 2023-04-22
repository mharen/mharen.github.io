---
date: '2012-07-25T20:16:00.001-04:00'
description: ''
published: true
slug: 2012-07-let-browser-handle-datepicker-if-it-can
categories:
- Work
- Code
- Technology
time_to_read: 5
title: Let the Browser Handle the Datepicker (if it can)
---


I built a simple data entry app a while back and took the opportunity to try out a lot of neat new things in the web world. This included using [Modernizr](http://modernizr.com/) to detect native date picker support shipping in some browsers.
Traditionally, I’d just toss a Javascript date picker like the one from the excellent [jQuery UI library](http://jqueryui.com/demos/datepicker/) when needed but now that browsers are starting to support other [input types](http://www.w3.org/TR/html-markup/input.html#input), e.g. &lt;input type="date"/&gt;, it’s possible to use the JS pickers as a *fallback*.
This idea isn’t novel with me, of course. I first saw it in one of Scott Hanselman’s talks (I can’t find a link at the moment, but I did find another MS blogger that [does pretty much the same thing in great detail](http://www.asp.net/mvc/tutorials/javascript/using-the-html5-and-jquery-ui-datepicker-popup-calendar-with-aspnet-mvc/using-the-html5-and-jquery-ui-datepicker-popup-calendar-with-aspnet-mvc-part-4)). If what I present below is too light on detail, go read his post.
Here’s how I did it in [my ASP.NET MVC project](https://github.com/mharen/service-tracker/):
First, create an editor template to render DateTime properties:<pre class="csharpcode"><span class="rem">// in Views/Shared/EditorTemplates/DateTime.cshtml</span>
﻿@model DateTime?
@{ 
     var <span class="kwrd">value</span> = (Model != <span class="kwrd">null</span> &amp;&amp; Model != DateTime.MinValue)
        ? Model.Value.ToString(<span class="str">"yyyy-MM-dd"</span>) 
        : <span class="str">""</span>; 
}
@Html.TextBox(<span class="str">""</span>, <span class="kwrd">value</span>, <span class="kwrd">new</span> { type = <span class="str">"date"</span> })</pre>
Now whenever you call “EditorFor” with a DateTime in a view, it will use that EditorTemplate to render it. If you’ve been using “EditorFor” all along, you’re in good shape.
Then the only other thing you need is to attach a datepicker if the browser needs it. I dropped this into my global scripts file, which runs on every single page:<pre class="csharpcode"><span class="rem">// attach the jquery datepicker unless the current browser has one</span>
<span class="kwrd">if</span> (!Modernizr.inputtypes.date) {
    $(<span class="str">"input[type=date]"</span>).datepicker();
}</pre>
The theory here is that now when a browser adds support for native datepickers, the site will automatically *stop adding the jQuery datepicker*. Slick.
Here’s an example. If you try this in Chrome (added sometime on or before version 20…?), the second input should be a native datepicker (![SNAG-0045%5B3%5D.png](SNAG-0045%5B3%5D.png)</a>
Oh, and by the way, this is especially great for mobile devices—this is supported on iOS but [not much else](http://caniuse.com/#feat=input-datetime) (yet).