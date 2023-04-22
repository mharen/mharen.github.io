---
date: '2012-11-09T23:52:00.001-05:00'
description: ''
published: true
slug: 2012-11-handling-drag-events-in-ios-with
categories:
- NaBloPoMo 2012
- Code
- Technology
time_to_read: 5
title: Handling Drag Events in iOS with Javascript
---


I built [this thing](http://blocky.apphb.com/) the other day while [playing around](../2012/2012-11-signalr-first-impressions-its-awesome.html) with [SignalR](https://github.com/SignalR/SignalR). It fills in cells in a table as you trace around with your mouse. On mobile, however, it didn’t work as well as I’d like. There it would only let you tap, not drag, which was a pretty big bummer.

The fix I settled on required two tricks combined together. First, I needed to translate the touch events into mouse events. Second, I needed to rework how the touch events work in the first place.

I adapted a [snippet of code](http://ross.posterous.com/2008/08/19/iphone-touch-events-in-javascript/) to effectively catch the touchmove events and replay them as mousemove events like so:  <pre class="csharpcode">    <span class="rem">// don't just copy this code. It gets better farther down...</span>
<span class="kwrd">    function</span> touchHandler(<span class="kwrd">event</span>) {
        <span class="kwrd">var</span> touch = <span class="kwrd">event</span>.touches[0];
        <span class="kwrd">var</span> simulatedEvent = document.createEvent(<span class="str">&quot;MouseEvent&quot;</span>);

        simulatedEvent.initMouseEvent(<span class="str">&quot;mousemove&quot;</span>, <span class="kwrd">true</span>, <span class="kwrd">true</span>, window, 1,
            touch.screenX, touch.screenY,
            touch.clientX, touch.clientY, <span class="kwrd">false</span> <span class="rem">/*ctrl*/</span>, <span class="kwrd">false</span> <span class="rem">/*alt*/</span>,
            <span class="kwrd">false</span> <span class="rem">/*shift*/</span>, <span class="kwrd">false</span> <span class="rem">/*meta*/</span>, 0 <span class="rem">/*left*/</span>, <span class="kwrd">null</span> <span class="rem">/*related target*/</span>);

        touch.target.dispatchEvent(simulatedEvent);
        <span class="kwrd">event</span>.preventDefault();
    }

    document.addEventListener(<span class="str">&quot;touchmove&quot;</span>, touchHandler, <span class="kwrd">true</span>);</pre>


This wasn’t enough to accommodate my needs, though. I really wanted the behavior of a mousemove event and this wasn’t doing it. The difference took too long for me to discover: the target of a mousemove event is the element underneath the mouse while the target of the touchmove event is the element that was under your finger when the dragging started.


That is, as you move across the screen, you will get a flurry of events. The mousemove events will reference the element beneath the cursor. The touchmove events will reference the element that was under your finger when you started moving. Touchmove events treat the action more like a drag-drop—they *do* tell you the coordinates of your finger as it slides across the screen, but they continue to report the original element that was initially touched.


So here’s the second fix: figure out what element is under your finger and fire the mousemove event with *that*. Luckily, there’s this handy function that can tell you what element is at a given x/y position: [elementFromPoint(x, y)](https://developer.mozilla.org/en-US/docs/DOM/document.elementFromPoint). Here’s what the updated version looks like:

<pre class="csharpcode">    <span class="kwrd">function</span> touchHandler(<span class="kwrd">event</span>) {
        <span class="kwrd">var</span> touches = <span class="kwrd">event</span>.touches;
        <span class="kwrd">var</span> touch = touches[0];
        <span class="kwrd">var</span> simulatedEvent = document.createEvent(<span class="str">&quot;MouseEvent&quot;</span>);

        simulatedEvent.initMouseEvent(<span class="str">&quot;mousemove&quot;</span>, <span class="kwrd">true</span>, <span class="kwrd">true</span>, window, 1,
            touch.screenX, touch.screenY,
            touch.clientX, touch.clientY, <span class="kwrd">false</span> <span class="rem">/*ctrl*/</span>, <span class="kwrd">false</span> <span class="rem">/*alt*/</span>,
            <span class="kwrd">false</span> <span class="rem">/*shift*/</span>, <span class="kwrd">false</span> <span class="rem">/*meta*/</span>, 0 <span class="rem">/*left*/</span>, <span class="kwrd">null</span> <span class="rem">/*related target*/</span>);

<strong>        <span class="kwrd">var</span> elementUnderFinger = document.elementFromPoint(touch.clientX, touch.clientY);
        elementUnderFinger.dispatchEvent(simulatedEvent);
</strong>        <span class="kwrd">event</span>.preventDefault();
    }</pre>


**It works!** But let’s not stop there. What about multi-touch? You’ll notice above that we have an array “event.touches” but we only use the first one (touches[0]). Let’s try handling them all!

<pre class="csharpcode">   <span class="kwrd">function</span> touchHandler(<span class="kwrd">event</span>) {
      <span class="kwrd">var</span> touches = <span class="kwrd">event</span>.touches;
<strong>      <span class="kwrd">for</span> (<span class="kwrd">var</span> i = 0; i &lt; touches.length; ++i) {
</strong>          <span class="kwrd">var</span> touch = touches[i];
          <span class="kwrd">var</span> simulatedEvent = document.createEvent(<span class="str">&quot;MouseEvent&quot;</span>);

          simulatedEvent.initMouseEvent(<span class="str">&quot;mousemove&quot;</span>, <span class="kwrd">true</span>, <span class="kwrd">true</span>, window, 1,
              touch.screenX, touch.screenY,
              touch.clientX, touch.clientY, <span class="kwrd">false</span> <span class="rem">/*ctrl*/</span>, <span class="kwrd">false</span> <span class="rem">/*alt*/</span>,
              <span class="kwrd">false</span> <span class="rem">/*shift*/</span>, <span class="kwrd">false</span> <span class="rem">/*meta*/</span>, 0 <span class="rem">/*left*/</span>, <span class="kwrd">null</span> <span class="rem">/*related target*/</span>);

          <span class="kwrd">var</span> elementUnderFinger = document.elementFromPoint(touch.clientX, touch.clientY);
          elementUnderFinger.dispatchEvent(simulatedEvent);
          <span class="kwrd">event</span>.preventDefault();
**      }**
   }</pre>


I’m going to claim that this works (it does)…but depending on what you’re doing with the mousemove events that this creates, there may be unexpected behavior as what you will observe is mousemove events from two fingers intermixed together. If you visualized this as a mouse cursor, you’d see it skipping back and forth between each finger. That might be ok—it depends on what you do with it.


With this added to my SignalR sample, multi-touch iOS devices are now supported. Woot!






Oh, and that “event.preventDefault()” part is there to stop the screen from moving when you drag it. If that’s all you wanted, you can do this [simpler version](http://stackoverflow.com/a/9251757/29):

<pre class="csharpcode">    document.addEventListener(<span class="str">&quot;touchmove&quot;</span>, <span class="kwrd">function</span> (e) { e.preventDefault(); }, <span class="kwrd">true</span>);</pre>


If that doesn’t seem to be doing it, you can try interrupting the touchstart and touchend events, too.


NB: [this iOS Developer Library Article](http://developer.apple.com/library/ios/#documentation/AppleApplications/Reference/SafariWebContent/HandlingEvents/HandlingEvents.html) was useful in helping me understand how all the touch events work together. There’s a note in there about how some events only fire on “clickable” elements. That refers to the click and mouse-related events, not the touch events, so don’t worry about it.

<hr />Music credit: “[Opening para Songo 21](http://freemusicarchive.org/music/SONGO_21/SONGO_21_-_Studio_sessions_2003/01_-_Opening_para_Songo_21)” (by [SONGO 21](http://freemusicarchive.org/music/SONGO_21/))