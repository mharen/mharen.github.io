---
layout: post
date: '2010-03-04T15:11:00.001-05:00'
categories: technology
title: Class Inheritance Throw Back
---


Another question I answered recently took me way back to my college classes on programming language theory. In those classes we studied the internals of languages in greater detail than I’d care to remember. We also build a [Scheme](http://en.wikipedia.org/wiki/Scheme_(programming_language)) scanner, parser, printer, too, which was fun.

Anyway, the question today was: given a base class “Animal” and a derived class “Dog”, in what order are the constructors and destructors called when the child class is instantiated and destroyed?

![image%5B2%5D.png](image%5B2%5D.png) 

I haven’t touched C++ for a long time but after thinking about it for a few seconds, this is what would make sense to me:

new Dog():   <ol>   <li>Animal()</li>    <li>Dog()</li> </ol>

delete Dog():  <ol>   <li>Dog()</li>    <li>Animal()</li> </ol>

The constructor part is the [same in C#](http://www.yoda.arachsys.com/csharp/constructors.html) (my current language of choice) so that was obvious, but we don’t really have destructors in C# (we have IDisposable) so i had to think about that logically a bit. 

The gist is: **constructors are executed top down, and destructors are executed bottom up**. I like digging into the details and the nuances of these things…