---
layout: post
date: '2011-01-20T21:26:00.001-05:00'
categories:
- work
- code
- technology
title: Automating Minitab with C#
---


My job takes me a lot of different places and I work with a lot of different technologies along the way. Recently my team and I were tasked with a sort of [ETL](http://en.wikipedia.org/wiki/Extract,_transform,_load")/reporting project involving some bizarrely formatted flat files, an Oracle database, and a couple Minitab macros. It was actually very straight forward except for one piece: automating Minitab.

I’m sharing the core piece of our development below in hopes that this will save a future dev some grief. I know that this looks very simple, and it is. Getting down to these few lines was not, I assure you, easy. A shout out to [@xover9000](http://www.twitter.com/xover9000") for doing pretty much all of this:
<blockquote>   
```cs
// the basic pieces
var MtbApp = new Mtb.Application();
var MtbProj = MtbApp.ActiveProject;
var MtbUI = MtbApp.UserInterface;

// We want this to run completely without user interaction
// Don't display messages or dialogs or anything
// (learned about the last couple here the hard way...)
MtbUI.DisplayAlerts = false;
MtbUI.Interactive = false;
MtbUI.UserControl = false; 

// Do the work
// I don't know why we preface this with a percent sign but that's how mtb rolls
MtbProj.ExecuteCommand(@"%C:\Path\To\YourMacro.mac");

// Macro run complete. Do whatever else you want or just quit
// Note: .Quit is asynchronous which means if you really need Mtb closed
// before you continue (e.g. before you run another macro), you need to 
// add your own logic to wait for it (also learned that one the hard way...)
MtbApp.Quit();
```

</blockquote>


Through those objects you do have access to all kinds of functionality if you need, but just for running macros those eight lines ought to cover it.


If you’re using a recent version of .NET, any errors that occur while running the above snippet will be raised as *COMException*s. The *Application* object has some error-related properties on it but in my experience their contents are copied into the *COMException* for you so that’s probably all you really need.