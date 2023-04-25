---
layout: post
date: '2008-01-05T18:03:00.000-05:00'
categories: technology
title: Pick a Number, Any Number
---

As most of you probably know, I like numbers. As an engineer, I don't really have a choice in the matter. This is probably one fundamental difference between engineering and math or science: we actually use numbers. My brother just graduated with a math degree and commented that he hasn't seen numbers in his upper level math courses for a while.

This should be a pretty simple post about a concept that I find pretty interesting: unique numbers. Specifically, universally unique identifiers or globally unique identifiers.

How about some context? Think about ID numbers that you are familiar with like your credit card number or social security number. It is important that these types of numbers be strictly unique. We can't have two people with the same SSN or credit card number--that'd be bad.

Now consider how these are assigned to you. At birth, you're given a social security number. But where do *they* get the number? In all honesty, I have no idea. I presume they are distributed to the state/county/hospital in blocks. That is, Licking Memorial Hospital might be assigned a block of numbers each month to use for new babies. These would be assigned by the federal government who would ensure that no one else used the numbers assigned to Licking Memorial. (note: since writing this Maya was born and I now know that these are not issued by the hospital.)

What if you don't have a central authority to distribute numbers? A lot of software applications depend on unique numbers to identify records for sales, employees, timecards, etc. If an application exists in one location this is as easy as counting (1, 2, 3, 4...). If the application resides in multiple sites, it gets a little trickier. One method is to associate the site with the number. e.g., site 1 numbers always start with 001 while site 2 numbers always start with 002 and so on. Sometimes this isn't an option. One case is where you have a bunch of sites but don't know how many or have any reasonable way to build such a fact into your number (think of the millions of computers on the net...). Ah, but some smart people have already provided a good solution to this problem. From [Wikipedia](http://en.wikipedia.org/wiki/Universally_Unique_Identifier):

<blockquote>The intent of UUIDs is to enable distributed systems to uniquely identify information without significant central coordination. Thus, anyone can create a UUID and use it to identify something with reasonable confidence that the identifier will never be unintentionally used by anyone for anything else.</blockquote>

What if we had the ability to generate a number that is pretty much guaranteed to be unique when tested against all other numbers in the whole world? How would you do that?! It could make for a good game...

<blockquote> "What number are you thinking of, Jerry?"

"You'll never guess. No, seriously, you are statistically not able to guess my number. Ever."</blockquote>

OK, some explanation is probably needed. What I'm talking about is called a universally unique identifier (UUID) or globally unique identifier (GUID). In spite of my terrible examples, these things are actually pretty useful, and actually really easy to create. A GUID (pronounced Gwid, rhymes with squid) is just a 128 bit string, generally represented in hexadecimal. Jigawha? Without getting into the ugly details of bits, binary, strings, hex, etc. I'll simplify a bit (har-har!) here. Think of a guid as a long row of letters (a-f) and numbers (0-9), 32 characters long. For example, these are GUIDs (the dashes are simply convention):



	* 15f197e0-546d-4074-bfb9-368fd2aae06a

	* d7a6a3e9-8e90-4422-9a86-6e84ba0d1575

	* 6662a8b9-22b3-47ba-89d6-08700b431fe0

	* 0a249bf8-9c03-4794-a327-66e9b9c90d37

	* 1908a5ad-5812-48ee-9fbf-4b1d357c7ff2




Not such a big deal, right? Not convinced that these are practically guaranteed to be random? Think about the lotto. The odds of winning a pick 5 mega millions lotto odds of winning the jackpot are 1 in 175,711,536. The odds of generating the same GUID twice are 1 in 2<sup>128</sup>. Now I realize that 2<sup>128</sup> doesn't seem that big so let me try to illustrate (again, borrowing from Wikipedia here):



	* 1 in 2<sup>128</sup>

	* 1 in 340 undecillion (don't worry, undecillion is not on the quiz)

	* 1 in 3.4 × 10<sup>38</sup>

	* 1 in 340,000,000,000,000,000,000,000,000,000,000,000,000




How about that last one? Holy crap! In order to list all possibilities, you would have to generate a trillion GUIDs every *nano*second for ten billion years.

---

### 1 comment

**Michael Haren said on 2010-03-04**

While doing some research for another post, I discovered some grave inaccuracies in how I presented Guids. The math is all good and everything but I definitely missed the intent of a guid. They *are not* random. They are intended to be unique but really contain very little in the way of random bits. 

It is therefore evident to me that they could likely be predictable given past values.

For more on what makes up a Guid on modern windows platforms, check out http://blogs.msdn.com/oldnewthing/archive/2008/06/27/8659071.aspx

