---
layout: post
date: '2010-03-05T11:59:00.001-05:00'
categories: code
title: 'HTML/JS: Progressive Enhancement'
---


The great thing about a semantic approach to web development is how nice and easy it can be to make progressive enhancements.

For example, suppose I have a “what’s this” help link beside some potentially confusing statement:

&#160;![image[11].png](/assets/2010/image[11].png) 



Nothing fancy here—just a link with a _blank target ([source](http://jsbin.com/unuqo/3/edit), [demo](http://jsbin.com/unuqo/3)):  
```cs
<p>Hello World 
  <a href="/help/tips"
     target="_blank" 
     title="Hello World Help"
     class="help-link">(what's this?)</a></p>
```



It’s not very pretty but it gets the job done without any Javascript. Let’s make it sexy:


![image[8].png](/assets/2010/image[8].png) 


Here we’ve augmented the help link with a nice [jQuery UI](http://jqueryui.com/home) [dialog](http://jqueryui.com/demos/dialog/) instead of a browser popup ([source](http://jsbin.com/unuqo/4/edit), [demo](http://jsbin.com/unuqo/4)):


```cs
$(function(){
  
  $('.help-link').click(function(){
    
    $('<div></div>')
      .attr('title', this.title)
      .load(this.href)
      .dialog({
        modal: true,
        buttons: {
          Ok: function () {
            $(this).dialog('close');
          }
        },
        width: 600,
        height: 350    
      });
    
    return false;
  });
  
});​
```



This doesn’t require any changes to the HTML/CSS—it uses existing attributes like <code>href</code> and <code>title</code> to wire itself up to the link. And, if JS is disabled or broken, *the link will still work*. 


By applying incremental enhancements in this fashion, we can easily maintain decent support for less-capable browsers while keeping our code clean and elegant.


You might notice, too, that this JS snippet is looking at a class (<code>help-link</code>), not an <code>id</code>. Since it infers everything it needs to show the dialog from the link itself, this snippet will work on **any** link in the page tagged with the <code>help-link</code> class. Nice, right?