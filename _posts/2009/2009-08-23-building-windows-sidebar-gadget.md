---
layout: post
date: '2009-08-23T00:48:00.001-04:00'
categories:
- windows
- usability
- technology
title: Building a Windows Sidebar Gadget
---


I use Hudson CI to monitor software builds at work and thought it’d be nice to provide visibility of Hudson’s data through a sidebar gadget. Unfortunately, one didn’t exist so I took it upon myself to make one. It turned out to be very, very easy.

Here’s the end result:

![SNAG-0013[6].png](/assets/2009/SNAG-0013[6].png) 

The gadget is on the right side, the regular Hudson interface on the left. The top 11 projects are listed as links to their project pages within Hudson. The colored bullets indicate build status (green = good, red = bad). I experimented with shading, text color, etc. and concluded that just having colored bullets was clear, clean and consistent with the regular Hudson interface.

![image[9].png](/assets/2009/image[9].png)Anyway, the easiest way to get started with Gadget development seems to be starting with an existing gadget. I started with the unofficial Stackoverflow.com [flair gadget](http://flairgadget.codeplex.com/). A .gadget file is really just a zip file. 7zip seems to know this as it allowed me to unzip it without renaming it to .zip which was nice. After unzipping, I stripped out pretty much everything except the structure. 

The gadget is remarkably simple—it’s just two web pages, main.html and settings.html. All the other files are just there for support: a few images, jquery (my favorite JS library), and json2 (brings JSON support to IE which is curiously missing on my Windows 7 machine). Obviously main.js/.css/.html go together as do settings.js/.css/.html.

Here’s what the main page looks like:
<blockquote>   
```cs
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Hudson Monitor</title>
  <link rel="stylesheet" href="styles/main.css" />
  <script type="text/javascript" src="scripts/jquery-1.3.2.min.js"></script>
  <script type="text/javascript" src="scripts/main.js"></script>
  <script type="text/javascript">
    $().ready(function() {
      FillMain();
    });
  </script>
</head>
<body>
<g:background src="images/bg.png">
    <ul id="jobs"></ul>
</g:background>
</body>
</html>
```

</blockquote>


The HTML really boils down to a single element: <ul>. The real magic happens within main.js. Here’s the relevant section:

<blockquote>
  
```cs
function FillMain() {
    // Get the url from the saved settings
    var url = System.Gadget.Settings.readString("hudsonUrl");

    if (url == null || url.length == 0) {
        $("#jobs").append(<span class="str">"<li class='status-red'> \
            Whoa there! Check your options, pal</li>"</span>);
        return;
    }

    $.getJSON(url+"/api/json/?jsonp=?", FillMainCallback);

    // Repeat every 20 minutes
    setTimeout("FillMain()", 20 * 60 * 1000);
}

function FillMainCallback(data) {
    $("#jobs").empty(); 

    // space is limited
    var items = data.jobs.slice(0, 11);
    
    // add each item to the list
    $.each(items, function(i, item) {
        var itemName = item.name; 
        var itemClass = 'status-' + item.color;
        var itemUrl = item.url;

        $("#jobs").append("<li class='" + itemClass + "'><a href='" 
            + itemUrl + "'>" + itemName + "</a></li>");
    });
}
```

</blockquote>


I won’t talk about that too much except to say jQuery makes all of this so much easier:

<ul>
  <li>$.getJSON(): contacts the Hudson build server and retrieves a terse list of build statuses. Hudson provides a straightforward, albeit limited API at http://hudson-url/api. </li>

  <li>$.each(): iterates over each Hudson project returned by the server; for each one, adds it to the list (#jobs) as a new list item </li>
</ul>


With the data flowing nicely, all that was needed was a little light graphics work and some CSS and I called it a day. I borrows the pretty background image with the curvy, aero border from the Outlook gadget but replaced the Outlook icon with a Hudson logo.


This is a feature-poor gadget, I admit. I plan to add the ability to order the projects by other criteria (e.g. last-activity-date) and the ability to pick which projects are listed. I might try out some other UI designs, too. What I have is functional and clean but leaves a bit to be desired.

---

### 4 comments

**GBtG said on 2009-08-23**

Does jQuery offer a syntax that doesn't involve building markup in strings?

BTW: "20 * 60 * 1000" is brilliant, and my new way of coding durations.

**Michael Haren said on 2009-08-23**

Yes, you can create elements with plain vanilla JS using document.createElement()(http://stackoverflow.com/questions/327047/).

I find the jquery markup method easier as it often leads to less code. Though the native function is faster, I cannot imagine a scenario in which that would matter.

**portella said on 2010-10-06**

Hi, you don't want to provide your gadget? I use Hudson and will be helpfull ... for sure I can redo your work with your usefull tips ... 

[]'s, Portella

**Amani Phoenix said on 2014-05-21**

nice post

