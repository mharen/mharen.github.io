---
date: '2011-01-20T21:26:00.001-05:00'
description: ''
published: true
slug: 2011-01-automating-minitab-with-c
categories:
- Work
- Code
- Technology
time_to_read: 5
title: Automating Minitab with C#
---


My job takes me a lot of different places and I work with a lot of different technologies along the way. Recently my team and I were tasked with a sort of [ETL](http://en.wikipedia.org/wiki/Extract,_transform,_load" target="_blank)/reporting project involving some bizarrely formatted flat files, an Oracle database, and a couple Minitab macros. It was actually very straight forward except for one piece: automating Minitab.

I’m sharing the core piece of our development below in hopes that this will save a future dev some grief. I know that this looks very simple, and it is. Getting down to these few lines was not, I assure you, easy. A shout out to [@xover9000](http://www.twitter.com/xover9000" target="_blank) for doing pretty much all of this:
<blockquote>   <pre class="csharpcode"><span class="rem">// the basic pieces</span>
var MtbApp = <span class="kwrd">new</span> Mtb.Application();
var MtbProj = MtbApp.ActiveProject;
var MtbUI = MtbApp.UserInterface;

<span class="rem">// We want this to run completely without user interaction</span>
<span class="rem">// Don't display messages or dialogs or anything</span>
<span class="rem">// (learned about the last couple here the hard way...)</span>
MtbUI.DisplayAlerts = <span class="kwrd">false</span>;
MtbUI.Interactive = <span class="kwrd">false</span>;
MtbUI.UserControl = <span class="kwrd">false</span>; 

<span class="rem">// Do the work</span>
<span class="rem">// I don't know why we preface this with a percent sign but that's how mtb rolls</span>
MtbProj.ExecuteCommand(<span class="str">@&quot;%C:\Path\To\YourMacro.mac&quot;</span>);

<span class="rem">// Macro run complete. Do whatever else you want or just quit</span>
<span class="rem">// Note: .Quit is asynchronous which means if you really need Mtb closed</span>
<span class="rem">// before you continue (e.g. before you run another macro), you need to </span>
<span class="rem">// add your own logic to wait for it (also learned that one the hard way...)</span>
MtbApp.Quit();</pre>
</blockquote>


Through those objects you do have access to all kinds of functionality if you need, but just for running macros those eight lines ought to cover it.


If you’re using a recent version of .NET, any errors that occur while running the above snippet will be raised as *COMException*s. The *Application* object has some error-related properties on it but in my experience their contents are copied into the *COMException* for you so that’s probably all you really need.