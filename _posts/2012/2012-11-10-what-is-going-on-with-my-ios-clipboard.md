---
layout: post
date: '2012-11-10T12:43:00.001-05:00'
categories:
- nablopomo 2012
- code
- technology
title: What is going on with my iOS clipboard in Safari?!
---


I [made a joke](https://twitter.com/mharen/status/267293420354154496) earlier that was based on a Taylor Swift lyric (don’t judge me) so I found myself on one of those awful song lyrics sites so I could copy the line I wanted. I highlighted the line I wanted and hit copy:  

![2012-11-10%2011.31.27%5B3%5D.png](2012-11-10%2011.31.27%5B3%5D.png)

Errr…what? I went back and tried copying again. Same thing. Weird.

So I loaded the same site on my desktop and immediately noticed strange behavior around text selection:  

[![selection_thumb%5B1%5D.gif](selection_thumb%5B1%5D.gif)](http://lh5.ggpht.com/-58OKSGyaWnQ/UJ6SK9Lr62I/AAAAAAAAFOw/G5w3XFzdDAg/s1600-h/selection%5B3%5D.gif)

The title in line one works fine, but the lyrics themselves won’t hold a selection. What’s doing that? Let’s take a peek at the page’s source. The first thing I noticed was an unusually large amount of HTML entities:

![image%5B11%5D.png](image%5B11%5D.png)

You normally use those codes to represent special characters. This site, however, is using them to obscuring the lyrics. (It’s hard to imagine that this is all that effective in protecting the content.) That’s not what I’m irritated by, though, so let’s keep looking. 

I’m assuming the weird selection behavior is triggered by a script so let’s just look for those by searching for “.js”:

![image%5B14%5D.png](image%5B14%5D.png)

(I find it amusing that the site attributes the lyrics to Sony but still puts in all this effort to “protecting” them…)

Bingo. 

That “protected-1.2.js” file looks like what we’re after. After it’s loaded, a bunch of mouse/selection/copy related events are bound to the various parts of the page. Let’s open that up to see if that’s where the site is messing with my clipboard:  <pre class="csharpcode">    <span class="rem">//limit text</span>
    <span class="kwrd">function</span> manageText(str){
        <span class="kwrd">if</span>(!allow(str)){
            <span class="kwrd">return</span> str;
        }<span class="kwrd">else</span>{
            <span class="kwrd">return</span> <span class="str">&quot;**Complete lyrics: **&quot;</span>+ document.location.href;
        }
    }

    copyEl.innerHTML = manageText(c.toString());

    document.body.insertBefore(copyEl, document.body.firstChild);
    a.selectAllChildren(copyEl);</pre>


There’s a lot more to it, but those are the key pieces that manipulated my clipboard. It’s actually pretty simple: this is all within the “noCopy” routine that’s bound to the “copy” event. When the browser tries to copy anything, it just throws some text into an element and selects *that* with [selectAllChildren](https://developer.mozilla.org/en-US/docs/DOM/Selection/selectAllChildren) instead of whatever was highlighted.


Mean. Let’s fix it with the developer tools (control-shift-I or F12):






Obviously I didn’t actually go to all this trouble to copy that one line. I was just curious how things were working under the covers :).

<hr />Credits/thanks: 

<ul>
  <li>Screencast recording via [Screenr](http://www.screenr.com/) </li>

  <li>Mp4 to Gif converter via [Online-Convert](http://www.online-convert.com/) </li>

  <li>Animated gif compression via [GifReducer](http://www.gifreducer.com) </li>
</ul>