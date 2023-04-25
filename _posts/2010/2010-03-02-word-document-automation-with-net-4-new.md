---
layout: post
date: '2010-03-02T22:41:00.001-05:00'
categories:
- work
- technology
title: 'Word Document Automation with .NET 4: New Doc From Template'
---


With all the Word automation stuff I’ve been working through, it was nice to find something easy today. I wanted to create a base template and use it to start my docs from. So I created the template in Word as usual and saved it as a .dotx. 

Then, to start new docs from this, just include it in the <code>.Add()</code> call:  
```cs
WordApp = new Application();

// open the template as a new doc
var Doc = WordApp.Documents.Add(**PathToTemplateFile**);
```
 
Easy does it.