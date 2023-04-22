---
date: '2005-04-24T20:00:00.001-04:00'
description: ''
published: true
slug: 2005-04-perl-huh
categories:
- Code
- Technology
time_to_read: 5
title: Perl - huh?
---

Perl is a scripting language that's been around a long time. Its claim to fame is its incredible ability to process text. I've been told that perl gurus can code up a perl script that will parse a set of input files, do a bunch of processing, and generate an output file, in less then 10 lines, less than 5 if they're sloppy. And it'll be damn fast, too.

So I'm doing a quick project for CSE694-DataMining and the instructor suggested we use perl. Not to step down from the great joys of learning another language, I started hacking away. It's like learning a foreign language, except you don't have to speak it and the vocab test only covers about 25 words. And everything's a cognate. And like the old languages you already know, it's in English, too. OK, so it's not really like a foreign language.

Moving on, we had to parse 20 files, each were about 2.5 mb. Each file consisted of articles. The total number of articles was about 2,100. Instead of parsing 20 files, which could be accomplished by a good ol' for loop, I used 'cat' to--get this--concatenate them into one giant 50 mb file.

Then using about 30 lines of perl (i'm not a perl guru) I read in the entire thing--bad for memory, good for performance. I do a bunch of processing and output a bunch of stuff that totals about 100 mb.

I mentioned speed earlier...the first pass takes about 10 seconds while the second pass takes about 20 minutes. That's pretty damn fast. The second pass does some weird algorithm stuff that runs something like an O(n^3) algorithm--terrible, i know. However, since I'm only doing this once, there isn't a huge need to make this optimal ;).

After my first experience with perl I immediately see that it is very similar to PHP and C++, both of which I am very familiar with. It has a few interesting syntaxes that PHP didn't adopt that threw me but I'd have to say that I'm a big fan. It definately is well deserving of its fame.

So, of the two or three people who read my blog, one of you might not be interested in this at all. And if you're still reading, I've got good news and bad news. Bad news: there's no upshot for you, this is the end. Good news: I just saved a bunch of money on my car insurance.