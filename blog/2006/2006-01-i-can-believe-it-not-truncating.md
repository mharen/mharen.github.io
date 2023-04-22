---
date: '2006-01-25T09:44:00.000-05:00'
description: ''
published: true
slug: 2006-01-i-can-believe-it-not-truncating
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: I can't believe it's not truncating!
---

This is for developers only. If you are not a developer but keep reading, you will just think this is dumb--my wife certainly did.

I have always been taught that integer arithmetic yielded truncated results. For example, 10+0.9 = 10. The reason for this is that 10 is an integer and thus 0.9 is converted to an integer before the addition takes place. This conversion is performed by truncated the fractional part (.9), leaving just 0. 10+0=10.

Trust me, as a computer engineering student, this is hammered home over and over again.

Fast forward to the jobsite. I am using real technologies now like VB.Net. I am using a method that returns a double/float and really need the integer part. So, I use good old CINT(double). I am shocked when my results appear to be rounded! Holy crap!

This is huge. CINT(1.6) = 2, not 1! So I look up the <a href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/script56/html/38eee725-da5b-469b-b3f7-c818a74037c1.asp">documentation</a> and sure enough:

<blockquote>Note: CInt differs from the Fix and Int functions, which truncate, rather than round, the fractional part of a number. When the fractional part is exactly 0.5, the CInt function always rounds it to the nearest even number. For example, 0.5 rounds to 0, and 1.5 rounds to 2.<br /></blockquote>

 I'll be damn. You might notice something even more crazy--it doesn't just round .5 up, it rounds to the nearest even number. Holy crap times two. I have not used this style of rounding since chemistry class in college when we had to mess with significant digits and such. This means that CINT(2.5) = 2...and...CINT(1.5) = 2. Yes, they both equal 2.

OK, I know you are thinking that the madness must be over...it's not. The documentation suggests that you use INT or FIX instead. Now skeptical of all things, I lookup INT. It seems that this has its quarks, too. INT always rounds DOWN--even for negative numbers! That is, INT(1.9) = 1, INT(-1.1) = -2.

It turns out that FIX is the function of choice for good old fashioned integer truncation. Go figure.

It should be noted that as far as I can tell, integer casting in C/C++ works like FIX...like everyone I know expected.