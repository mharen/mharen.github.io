---
date: '2010-03-10T12:42:00.001-05:00'
description: ''
published: true
slug: 2010-03-autohotkey-wrapping-selection-with-tag
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Autohotkey: Wrapping the selection with a tag'
---


[Autohotkey](http://www.autohotkey.com/) is a nice tool to be familiar with—it enables you to create advanced hotkeys. Today, I built a very simple script which saved me a bunch of time. Here’s the skinny:

I’ve been blogging about software a lot and these posts are often heavy with terms or phrases that I wrap in <code>http://www.autohotkey.com/</code> tags. Unfortunately, my editor ([Live Writer](http://download.live.com/writer)), as awesome as it is, doesn’t support something like this. AutoHotKey to the rescue!

Here’s the script:  <pre><code class="csharpcode">#c::                       <span class="rem">; fire on WIN+c</span>
AutoTrim Off               <span class="rem">; Retain any leading and trailing whitespace on the clipboard.</span>
ClipSaved := ClipboardAll  <span class="rem">; Save the entire clipboard so we can restore it when we're done</span>
SendInput ^x               <span class="rem">; cut the selection to the clipboard</span>
ClipWait                   <span class="rem">; wait for the clipboard to contain something</span>
SendInput &lt;code&gt;%clipboard%&lt;/code&gt; <span class="rem">; Output what was selected, surrounded by &lt;code&gt; tags</span>
Clipboard := ClipSaved     <span class="rem">; Restore the original clipboard</span>
ClipSaved =                <span class="rem">; Free the memory in case the clipboard was very large.</span>
return</code></pre>


Load this into your AHK script, hit reload, and fire away. Select some text, hit <code>WIN+C</code>, and watch in amazement as it is surrounded by <code>&lt;code&gt;</code> tags.