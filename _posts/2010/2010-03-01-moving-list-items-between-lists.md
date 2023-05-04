---
layout: post
date: '2010-03-01T16:11:00.001-05:00'
categories:
- work
- code
- technology
title: Moving List Items Between Lists
---

I often apply a push-pull pattern when working with business/data interfaces. I’m talking about something like this:

![]({{ "/assets/2010/push-pull-2.png" | relative_url }}) 

I don’t much like these so I came up with something similar that works well for small datasets which I’ll describe here. Here it is [in action](http://jsbin.com/ucoqi):

[![]({{ "/assets/2010/push-pull-6.png" | relative_url }})](http://jsbin.com/ucoqi)

and here’s how to [build it](http://jsbin.com/ucoqi/edit). First, the basic layout:  

```html
<body>
  <ul id='list1'>
    <li>Item 1 <img class='icon move' src='blank.png'/></li>
    <li>Item 2 <img class='icon move' src='blank.png'/></li>
    <li>Item 3 <img class='icon move' src='blank.png'/></li>
    <li>Item 4 <img class='icon move' src='blank.png'/></li>
  </ul>
  <ul id='list2'>
    <li>Item 5 <img class='icon move' src='blank.png'/></li>
    <li>Item 6 <img class='icon move' src='blank.png'/></li>
    <li>Item 7 <img class='icon move' src='blank.png'/></li>
    <li>Item 8 <img class='icon move' src='blank.png'/></li>
  </ul>
</body>
```
 
What I want to do is have each `li` hop to the opposing list when its move button is clicked. It’s very simple with jQuery’s live event binding ([demo](http://jsbin.com/ucoqi/1), [source](http://jsbin.com/ucoqi/1/edit)):

```js
$(function(){
  $('ul#list1 .move').live('click', function(){
    $(this).closest('li').appendTo('ul#list2');
  });
  
  $('ul#list2 .move').live('click', function(){
    $(this).closest('li').appendTo('ul#list1');
  });
});
```

These events aren’t bound to the items themselves. Rather they sit higher up the DOM and, through some event delegation magic, are handled by any `li` matching the selector (including elements appended in the future). So when an `li`’s `move` icon is clicked, the event handler walks up the DOM until it finds the `li` element, and moves it to the other list via a call to `appendTo()`. This technique can be combined with [jQuery UI’s sortable component](http://jqueryui.com/demos/sortable/), too, for drag/drop and reorder support, too.

It’s also really easy to add animation ([demo](http://jsbin.com/ucoqi/3), [source](http://jsbin.com/ucoqi/3/edit)):

```js
$(function(){
  $('ul#list1 .move').live('click', function(){
    $li = $(this).closest('li');
    $li.fadeOut('slow', function(){ $li.appendTo('ul#list2').fadeIn(); });
  });
  
  $('ul#list2 .move').live('click', function(){
    $li = $(this).closest('li');
    $li.fadeOut('slow', function(){ $li.appendTo('ul#list1').fadeIn(); });
  });
});
```
 
Now we’re getting to the point where some refactoring might be appropriate ([demo](http://jsbin.com/ucoqi/5), [source](http://jsbin.com/ucoqi/5/edit)):

```js
$.fn.pushTo = function(toSelector)
{
  $this = $(this);
  return $this.fadeOut('slow', function(){ $this.appendTo(toSelector).fadeIn(); });   
};

$(function(){
  $('ul#list1 .move').live('click', function(){
    $(this).closest('li').pushTo('ul#list2');
  });
  
  $('ul#list2 .move').live('click', function(){
    $(this).closest('li').pushTo('ul#list1');
  });
});
```
 
It’s not really any less code, but we’ve moved the messy animation pieces out into a chainable function. I could have moved the `.closest()` pieces into the function, too, but that would make the `pushTo()` method a little too specific to this task for my taste. Since we have the animation isolated to one line, we can easily change it to slide the items in and out ([demo](http://jsbin.com/ucoqi/7), [source](http://jsbin.com/ucoqi/7/edit)):


```js
$.fn.pushTo = function(toSelector)
{
  $this = $(this);
  $this.slideUp('slow', function(){ $this.appendTo(toSelector).slideDown(); });   
  return $this;
};
```
 
Finally, if you use something like this in a real app, use ‘fast’ for the animation speed. I’m using ‘slow’ here to make it obvious. In practice, though, it’d be very annoying. 