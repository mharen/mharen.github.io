---
date: '2010-10-07T19:31:00.001-04:00'
description: ''
published: true
slug: 2010-10-infinite-scroll-is-best-thing-since
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Usability
- Technology
- legacy-blogger
time_to_read: 5
title: Infinite Scroll Is The Best Thing Since XmlHttpRequest
---


If you don’t know what [XmlHttpRequest](http://en.wikipedia.org/wiki/XMLHttpRequest) is—forget it—doesn’t matter. Just assume I said something about [bread](http://twitter.com/#!/rssj/status/25563675734).

Infinite scroll is something you might not have even noticed. It’s the slick effect a website employs when they have a lot of content to show you but aren’t sure how much to show you. That is, they load two or three screens of content, then wait for you to scroll down before loading more.

The trick is that they load more *before *you need it so you never notice it happening. It’s like when the waiter brings you a refill when you’ve still got a couple sips to go. Good stuff.

![image%5B21%5D.png](image%5B21%5D.png)

This design pattern replaces paging. Remember paging? That’s what this blog does. When you get to the bottom, there’s a button that says “Older Posts”. When clicked, this starts you anew at the top of the page, but with a different set of seven posts. If, instead of this button, new posts just kept appearing at the bottom (probably without you even realizing it), it’d be infinite scroll.

[Google Images](http://images.google.com/images?&amp;q=puppies) employs a sort of hybrid approach where they load all the boxes of 19 pages worth of images, but don’t actually download the images until you scroll near them. You can verify this by skipping to the end and seeing them fill in. You can then click “Show More Results” to have 19 more pages appended to the current screen. It’s infinite in the sense that you probably aren’t going to go beyond page 19, and if you do it’s all inline. [Bing’s approach](http://www.bing.com/images/search?q=puppies) is more pure to the technique I’m describing.

I really like the full on approach where you don’t have to click anything and the content just keeps on coming. Like Facebook. In Facebook, the news feed keeps loading as you scroll until you get pretty far back. Only when you go back pretty far does it require you to actually click a button to show more. 

Twitter does this, too. You can see when I first load the page that the scroll bar shows I have about four or five screens worth of material:  

![image%5B18%5D.png](image%5B18%5D.png)

Pay attention to the scroll bar. It starts up top (1), then I move it down (2). And if I move it just a hair farther, it jumps back up (3), signaling that a bunch of new content has loaded beyond where I’ve scrolled. If I scroll very quickly, I can actually see it loading:

![SNAG-0028%5B2%5D.png](SNAG-0028%5B2%5D.png)

Pretty handy, eh? Now that I’ve grown accustomed to this, I’m completely unsatisfied by the old style of paging. This approach is intuitive, extremely effective, and fast. Old-school paging disrupts my train of thought and is usually painfully slow.

By the way, I tried to build a quick and dirty animation to show this off a little better but couldn’t compress it down to a reasonable level so you’ll have to settle [for this](http://www.youtube.com/watch?v=oHg5SJYRHA0) instead (but [seriously, folks](http://www.youtube.com/watch?v=wDs5nAccjeY#t=3m45s)).