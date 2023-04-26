---
layout: post
date: '2010-03-10T12:42:00.001-05:00'
categories:
- work
- code
- technology
title: 'Autohotkey: Wrapping the selection with a tag'
---


[Autohotkey](http://www.autohotkey.com/) is a nice tool to be familiar with—it enables you to create advanced hotkeys. Today, I built a very simple script which saved me a bunch of time. Here’s the skinny:

I’ve been blogging about software a lot and these posts are often heavy with terms or phrases that I wrap in `http://www.autohotkey.com/` tags. Unfortunately, my editor ([Live Writer](http://download.live.com/writer)), as awesome as it is, doesn’t support something like this. AutoHotKey to the rescue!

Here’s the script:  <pre><code class="csharpcode">#c::                       ; fire on WIN+c
AutoTrim Off               ; Retain any leading and trailing whitespace on the clipboard.
ClipSaved := ClipboardAll  ; Save the entire clipboard so we can restore it when we're done
SendInput ^x               ; cut the selection to the clipboard
ClipWait                   ; wait for the clipboard to contain something
SendInput `%clipboard%` ; Output what was selected, surrounded by <code> tags
Clipboard := ClipSaved     ; Restore the original clipboard
ClipSaved =                ; Free the memory in case the clipboard was very large.
return</code>
```
 
Load this into your AHK script, hit reload, and fire away. Select some text, hit `WIN+C`, and watch in amazement as it is surrounded by `<code>` tags.