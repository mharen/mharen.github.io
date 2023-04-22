---
date: '2007-07-04T17:07:00.000-04:00'
description: ''
published: true
slug: 2007-07-programmers-thatprogram
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Technology
- legacy-blogger
time_to_read: 5
title: Programmers That...Program?
---

As a software guy, <a href="http://www.codinghorror.com/blog/archives/000781.html">this article</a> made me very sad. The basic gist is that a lot of software grads these days can't actually write simple programs. I'm talking about really simple programs that I am confident both my wife and brother could implement with their single introductory programming class.

The example from the article, is an application that prints a list of numbers from 1-10. A slightly less ridiculously easy version is to:<br /><blockquote>Write a program that prints the numbers from 1 to 100. But for multiples of three print ?Fizz? instead of the number and for the multiples of five print ?Buzz?. For numbers which are multiples of both three and five print ?FizzBuzz?.</blockquote><br />Any programmer should be able to implement these "programs" in a half-dozen languages in under five minutes. It's tough to convey to non-programmers just how easy this should be--this is something that a programmer should be able to do in <em>any</em> language with 2 minutes of googling. We're talking like Hello World, part 2 type stuff here.

Here's my wife's implementation (with only a little help):<br /><pre>(while n<100)<br />{<br />n++;<br />{<br />if (n Mod 15 == 0)<br />{<br />print "FizzBizz";<br />}<br />elseif (n Mod 3 == 0)<br />{<br />print "Fizz";<br />}<br />elseif (n Mod 5 == 0)<br />{<br />print "Bizz";<br />}<br />else<br />{<br />print n;<br />}<br />}<br />}</pre>