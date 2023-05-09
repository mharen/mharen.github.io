---
layout: post
date: '2012-11-11T23:59:00.000-05:00'
categories:
- nablopomo-2012
- code
- technology
title: 'Snippet: Eating The Backspace Key on Data Entry Screens (Or, How I Became A Secret Hero)'
---

Have you ever been filling out a form on the web and accidentally navigated away from the form...and lost your work? Ouch. There’re few things as frustrating as *retyping* something into a computer.

In addition to the typical things that a good web programmer does to help prevent data loss (e.g. use simple forms, prompt before leaving a dirty form, don’t break the forward/back buttons, background-save frequent drafts, etc.), here’s a technique I’ve used in a few projects that has silently saved people from some suffering: 

**Disable the keyboard shortcut for the back button via the backspace key**

In case you didn’t know, the backspace key is typically mapped to the back button. Now imagine you’re updating a large text area with all kinds of thought provoking wisdom. Then you tab away from the text area or click off of it for some reason. Some time later you might hit the backspace key to delete the last letter you typed. Unfortunately, since your focus isn’t in a text area or input, you are navigated away from the page, losing your masterpiece.

It’s simple to eat that keyboard shortcut in Javascript. Here’s a snippet that uses jQuery since jQuery’s pretty much everywhere:  
```js
$(document).keydown(function (e) {
    if (e.which == 8 /* backspace */
        && !$(e.target).is('input,textarea')) 
    { 
        e.preventDefault(); 
    }
});
```

That is, if the keydown event fires and it’s backspace key and we’re not in an input or textarea, stop the keydown event. We can liven this up a little by interrupting the event if it’s readonly or disabled. [This answer](http://stackoverflow.com/a/2768256/29) on Stackoverflow by [erikkallen](http://stackoverflow.com/users/47161/erikkallen) covers that case, too:

```js
$(document).unbind('keydown').bind('keydown', function (event) {
    var doPrevent = false;
    if (event.keyCode === 8) {
        var d = event.srcElement || event.target;
        if ((d.tagName.toUpperCase()==='INPUT' && 
                (d.type.toUpperCase()==='TEXT' || d.type.toUpperCase()==='PASSWORD')) 
            || d.tagName.toUpperCase() === 'TEXTAREA') {

            doPrevent = d.readOnly || d.disabled;
        }
        else {
            doPrevent = true;
        }
    }

    if (doPrevent) {
        event.preventDefault();
    }
});
```

And if you don’t want to use any jQuery, [here’s](http://jsfiddle.net/JEKXH/3/) the pure JS version (with [more](http://stackoverflow.com/a/1629949/29) [thanks](http://stackoverflow.com/a/10182352/29) [to](http://stackoverflow.com/q/1411545/29) Stackoverflow):

```js
document.onkeydown = function (event) {
    var doPrevent = false;
    var keyCode = event.charCode ? event.charCode : event.keyCode;

    if(keyCode !== 8 /* backspace */){
        return;
    }
    
    var d = event.srcElement || event.target;
    if ((d.tagName.toUpperCase()==='INPUT' && 
            (d.type.toUpperCase()==='TEXT' || d.type.toUpperCase()==='PASSWORD')) 
        || d.tagName.toUpperCase() === 'TEXTAREA') {

        doPrevent = d.readOnly || d.disabled;
    }
    else {
        doPrevent = true;
    }

    if (doPrevent) {
        event.preventDefault();
    }
};​
```

It’s the little things...

---

### 2 comments

**infocyde said on 2012-12-04**

I used pretty much the same code grocked from stackoverflow, and it doesn't work consistently. I'm using a lot of popup windows to mimic a MDI interface, that might screwing things up. Just an FYI, I'm not sure your code snippet is full proof.

**Michael Haren said on 2012-12-04**

It may not be fool proof, sure. If you can repro the issues you're having, though, I'd be happy to help.

A jsfiddle link would be ideal.

Comments closed
{: .comments-closed }