---
date: '2010-03-01T16:11:00.001-05:00'
description: ''
published: true
slug: 2010-03-moving-list-items-between-lists
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Moving List Items Between Lists
---


I often apply a push-pull pattern when working with business/data interfaces. I’m talking about something like this:

![image%5B2%5D.png](image%5B2%5D.png) 

I don’t much like these so I came up with something similar that works well for small datasets which I’ll describe here. Here it is [in action](http://jsbin.com/ucoqi):

[![image%5B6%5D.png](image%5B6%5D.png)](http://jsbin.com/ucoqi) and here’s how to [build it](http://jsbin.com/ucoqi/edit). First, the basic layout:  <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">body</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">ul</span> <span class="attr">id</span><span class="kwrd">='list1'</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>Item 1 <span class="kwrd">&lt;</span><span class="html">img</span> <span class="attr">class</span><span class="kwrd">='icon move'</span> <span class="attr">src</span><span class="kwrd">='blank.png'</span><span class="kwrd">/&gt;&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>Item 2 <span class="kwrd">&lt;</span><span class="html">img</span> <span class="attr">class</span><span class="kwrd">='icon move'</span> <span class="attr">src</span><span class="kwrd">='blank.png'</span><span class="kwrd">/&gt;&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>Item 3 <span class="kwrd">&lt;</span><span class="html">img</span> <span class="attr">class</span><span class="kwrd">='icon move'</span> <span class="attr">src</span><span class="kwrd">='blank.png'</span><span class="kwrd">/&gt;&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>Item 4 <span class="kwrd">&lt;</span><span class="html">img</span> <span class="attr">class</span><span class="kwrd">='icon move'</span> <span class="attr">src</span><span class="kwrd">='blank.png'</span><span class="kwrd">/&gt;&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">ul</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;</span><span class="html">ul</span> <span class="attr">id</span><span class="kwrd">='list2'</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>Item 5 <span class="kwrd">&lt;</span><span class="html">img</span> <span class="attr">class</span><span class="kwrd">='icon move'</span> <span class="attr">src</span><span class="kwrd">='blank.png'</span><span class="kwrd">/&gt;&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>Item 6 <span class="kwrd">&lt;</span><span class="html">img</span> <span class="attr">class</span><span class="kwrd">='icon move'</span> <span class="attr">src</span><span class="kwrd">='blank.png'</span><span class="kwrd">/&gt;&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>Item 7 <span class="kwrd">&lt;</span><span class="html">img</span> <span class="attr">class</span><span class="kwrd">='icon move'</span> <span class="attr">src</span><span class="kwrd">='blank.png'</span><span class="kwrd">/&gt;&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>Item 8 <span class="kwrd">&lt;</span><span class="html">img</span> <span class="attr">class</span><span class="kwrd">='icon move'</span> <span class="attr">src</span><span class="kwrd">='blank.png'</span><span class="kwrd">/&gt;&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">ul</span><span class="kwrd">&gt;</span>
  <span class="kwrd">&lt;/</span><span class="html">body</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">html</span><span class="kwrd">&gt;</span>​</pre>


What I want to do is have each <code>li</code> hop to the opposing list when its move button is clicked. It’s very simple with jQuery’s live event binding ([demo](http://jsbin.com/ucoqi/1), [source](http://jsbin.com/ucoqi/1/edit)):

<pre class="csharpcode">  $(<span class="kwrd">function</span>(){
    $(<span class="str">'ul#list1 .move'</span>).live(<span class="str">'click'</span>, <span class="kwrd">function</span>(){
      $(<span class="kwrd">this</span>).closest(<span class="str">'li'</span>).appendTo(<span class="str">'ul#list2'</span>);
    });
    
    $(<span class="str">'ul#list2 .move'</span>).live(<span class="str">'click'</span>, <span class="kwrd">function</span>(){
      $(<span class="kwrd">this</span>).closest(<span class="str">'li'</span>).appendTo(<span class="str">'ul#list1'</span>);
    });
  });</pre>





These events aren’t bound to the items themselves. Rather they sit higher up the DOM and, through some event delegation magic, are handled by any <code>li</code> matching the selector (including elements appended in the future). So when an <code>li</code>’s <code>move</code> icon is clicked, the event handler walks up the DOM until it finds the <code>li</code> element, and moves it to the other list via a call to <code>appendTo()</code>. This technique can be combined with [jQuery UI’s sortable component](http://jqueryui.com/demos/sortable/), too, for drag/drop and reorder support, too.


It’s also really easy to add animation ([demo](http://jsbin.com/ucoqi/3), [source](http://jsbin.com/ucoqi/3/edit)):

<pre class="csharpcode">  $(<span class="kwrd">function</span>(){
    $(<span class="str">'ul#list1 .move'</span>).live(<span class="str">'click'</span>, <span class="kwrd">function</span>(){
      $li = $(<span class="kwrd">this</span>).closest(<span class="str">'li'</span>);
      $li.fadeOut(<span class="str">'slow'</span>, <span class="kwrd">function</span>(){ $li.appendTo(<span class="str">'ul#list2'</span>).fadeIn(); });
    });
    
    $(<span class="str">'ul#list2 .move'</span>).live(<span class="str">'click'</span>, <span class="kwrd">function</span>(){
      $li = $(<span class="kwrd">this</span>).closest(<span class="str">'li'</span>);
      $li.fadeOut(<span class="str">'slow'</span>, <span class="kwrd">function</span>(){ $li.appendTo(<span class="str">'ul#list1'</span>).fadeIn(); });
    });
  });</pre>


Now we’re getting to the point where some refactoring might be appropriate ([demo](http://jsbin.com/ucoqi/5), [source](http://jsbin.com/ucoqi/5/edit)):

<pre class="csharpcode">  $.fn.pushTo = <span class="kwrd">function</span>(toSelector)
  {
    $<span class="kwrd">this</span> = $(<span class="kwrd">this</span>);
    return $<span class="kwrd">this</span>.fadeOut(<span class="str">'slow'</span>, <span class="kwrd">function</span>(){ $<span class="kwrd">this</span>.appendTo(toSelector).fadeIn(); });   
  };
  
  $(<span class="kwrd">function</span>(){
    $(<span class="str">'ul#list1 .move'</span>).live(<span class="str">'click'</span>, <span class="kwrd">function</span>(){
      $(<span class="kwrd">this</span>).closest(<span class="str">'li'</span>).pushTo(<span class="str">'ul#list2'</span>);
    });
    
    $(<span class="str">'ul#list2 .move'</span>).live(<span class="str">'click'</span>, <span class="kwrd">function</span>(){
      $(<span class="kwrd">this</span>).closest(<span class="str">'li'</span>).pushTo(<span class="str">'ul#list1'</span>);
    });
  });</pre>


It’s not really any less code, but we’ve moved the messy animation pieces out into a chainable function. I could have moved the <code>.closest()</code> pieces into the function, too, but that would make the <code>pushTo()</code> method a little too specific to this task for my taste. Since we have the animation isolated to one line, we can easily change it to slide the items in and out ([demo](http://jsbin.com/ucoqi/7), [source](http://jsbin.com/ucoqi/7/edit)):

<pre class="csharpcode">  $.fn.pushTo = <span class="kwrd">function</span>(toSelector)
  {
    $<span class="kwrd">this</span> = $(<span class="kwrd">this</span>);
    $<span class="kwrd">this</span>.slideUp(<span class="str">'slow'</span>, <span class="kwrd">function</span>(){ $<span class="kwrd">this</span>.appendTo(toSelector).slideDown(); });   
    <span class="kwrd">return</span> $<span class="kwrd">this</span>;
  };</pre>


Finally, if you use something like this in a real app, use ‘fast’ for the animation speed. I’m using ‘slow’ here to make it obvious. In practice, though, it’d be very annoying. 