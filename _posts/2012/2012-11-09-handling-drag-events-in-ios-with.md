---
layout: post
date: '2012-11-09T23:52:00.001-05:00'
categories:
- nablopomo 2012
- code
- technology
title: Handling Drag Events in iOS with Javascript
---


I built [this thing](http://blocky.apphb.com/) the other day while [playing around](../2012/2012-11-signalr-first-impressions-its-awesome.html) with [SignalR](https://github.com/SignalR/SignalR). It fills in cells in a table as you trace around with your mouse. On mobile, however, it didn’t work as well as I’d like. There it would only let you tap, not drag, which was a pretty big bummer.

The fix I settled on required two tricks combined together. First, I needed to translate the touch events into mouse events. Second, I needed to rework how the touch events work in the first place.

I adapted a [snippet of code](http://ross.posterous.com/2008/08/19/iphone-touch-events-in-javascript/) to effectively catch the touchmove events and replay them as mousemove events like so:  
```cs
    // don't just copy this code. It gets better farther down...
    function touchHandler(event) {
        var touch = event.touches[0];
        var simulatedEvent = document.createEvent("MouseEvent");

        simulatedEvent.initMouseEvent("mousemove", true, true, window, 1,
            touch.screenX, touch.screenY,
            touch.clientX, touch.clientY, false /*ctrl*/, false /*alt*/,
            false /*shift*/, false /*meta*/, 0 /*left*/, null /*related target*/);

        touch.target.dispatchEvent(simulatedEvent);
        event.preventDefault();
    }

    document.addEventListener("touchmove", touchHandler, true);
```



This wasn’t enough to accommodate my needs, though. I really wanted the behavior of a mousemove event and this wasn’t doing it. The difference took too long for me to discover: the target of a mousemove event is the element underneath the mouse while the target of the touchmove event is the element that was under your finger when the dragging started.


That is, as you move across the screen, you will get a flurry of events. The mousemove events will reference the element beneath the cursor. The touchmove events will reference the element that was under your finger when you started moving. Touchmove events treat the action more like a drag-drop—they *do* tell you the coordinates of your finger as it slides across the screen, but they continue to report the original element that was initially touched.


So here’s the second fix: figure out what element is under your finger and fire the mousemove event with *that*. Luckily, there’s this handy function that can tell you what element is at a given x/y position: [elementFromPoint(x, y)](https://developer.mozilla.org/en-US/docs/DOM/document.elementFromPoint). Here’s what the updated version looks like:


```cs
    function touchHandler(event) {
        var touches = event.touches;
        var touch = touches[0];
        var simulatedEvent = document.createEvent("MouseEvent");

        simulatedEvent.initMouseEvent("mousemove", true, true, window, 1,
            touch.screenX, touch.screenY,
            touch.clientX, touch.clientY, false /*ctrl*/, false /*alt*/,
            false /*shift*/, false /*meta*/, 0 /*left*/, null /*related target*/);

<strong>        var elementUnderFinger = document.elementFromPoint(touch.clientX, touch.clientY);
        elementUnderFinger.dispatchEvent(simulatedEvent);
</strong>        event.preventDefault();
    }
```



**It works!** But let’s not stop there. What about multi-touch? You’ll notice above that we have an array “event.touches” but we only use the first one (touches[0]). Let’s try handling them all!


```cs
   function touchHandler(event) {
      var touches = event.touches;
<strong>      for (var i = 0; i < touches.length; ++i) {
</strong>          var touch = touches[i];
          var simulatedEvent = document.createEvent("MouseEvent");

          simulatedEvent.initMouseEvent("mousemove", true, true, window, 1,
              touch.screenX, touch.screenY,
              touch.clientX, touch.clientY, false /*ctrl*/, false /*alt*/,
              false /*shift*/, false /*meta*/, 0 /*left*/, null /*related target*/);

          var elementUnderFinger = document.elementFromPoint(touch.clientX, touch.clientY);
          elementUnderFinger.dispatchEvent(simulatedEvent);
          event.preventDefault();
**      }**
   }
```



I’m going to claim that this works (it does)…but depending on what you’re doing with the mousemove events that this creates, there may be unexpected behavior as what you will observe is mousemove events from two fingers intermixed together. If you visualized this as a mouse cursor, you’d see it skipping back and forth between each finger. That might be ok—it depends on what you do with it.


With this added to my SignalR sample, multi-touch iOS devices are now supported. Woot!






Oh, and that “event.preventDefault()” part is there to stop the screen from moving when you drag it. If that’s all you wanted, you can do this [simpler version](http://stackoverflow.com/a/9251757/29):


```cs
    document.addEventListener("touchmove", function (e) { e.preventDefault(); }, true);
```



If that doesn’t seem to be doing it, you can try interrupting the touchstart and touchend events, too.


NB: [this iOS Developer Library Article](http://developer.apple.com/library/ios/#documentation/AppleApplications/Reference/SafariWebContent/HandlingEvents/HandlingEvents.html) was useful in helping me understand how all the touch events work together. There’s a note in there about how some events only fire on “clickable” elements. That refers to the click and mouse-related events, not the touch events, so don’t worry about it.

<hr />Music credit: “[Opening para Songo 21](http://freemusicarchive.org/music/SONGO_21/SONGO_21_-_Studio_sessions_2003/01_-_Opening_para_Songo_21)” (by [SONGO 21](http://freemusicarchive.org/music/SONGO_21/))