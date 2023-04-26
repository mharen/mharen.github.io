---
layout: post
date: '2011-03-10T16:40:00.001-05:00'
categories:
- code
- technology
title: The Curious Behavior of HTML Image Inputs, Or Why "&x=0&y=0" Is Showing Up Uninvited
---

While working on an internal tool I noticed that the search form was producing unexpected `get` requests. Here’s the form:

```html
<form action="/Search" method="get">
  <input id="s" name="s" type="text" value="" />
  <input type="image" src="search.png" value="Search" />
</form>
```

I expected this to create requests like 

```cs
/Search?s=blah
```

but instead I got this:

```cs
/Search?s=blah&x=0&y=0
```

Hmm. Initially I thought this was some sort of ASP.NET trick to [remember scroll position](http://weblogs.asp.net/hosamkamel/archive/2007/09/07/maintain-scroll-position-after-postbacks-in-asp-net-2-0.aspx). But I’m using MVC, which has a lot less unexpected magic in it so I quickly concluded it must be something else. I thought about those image maps that used to be all the rage back in 1999 and determined that my [image input](http://www.whatwg.org/specs/web-apps/current-work/multipage/number-state.html#concept-input-type-image-coordinate) was causing the problem.


This was easily confirmed by actually clicking on the magnifying glass on my page and seeing requests like this:

```cs
/Search?s=blah&x=**<font color="#ff0000">5</font>**&y=**<font color="#ff0000">3</font>**
```

Ah, so yes, it is recording where I click. While I’m sure that’s really great in some situations, it’s not what I want now. Interestingly, the solution to this problem wasn’t so simple. The cleanest workaround seems to be disabling the image input when the form is submitted. Since the browser won’t send the value of disabled inputs upon submission this solves the problem.

Here’s a tiny line of jQuery which solved the problem for me:

```cs
// disable the image submit buttons so the browser doesn't add &x=&y= to the qs
$('form.strip-img-inputs-on-submit').submit(function (e) {
    $(this).find('input[type=image]').attr('disabled', true);
});
```

Essentially all this does is find all forms with a certain class and disable image inputs when submitted.