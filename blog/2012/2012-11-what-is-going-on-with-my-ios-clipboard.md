---
date: '2012-11-10T12:43:00.001-05:00'
description: ''
published: true
slug: 2012-11-what-is-going-on-with-my-ios-clipboard
tags:
- http://schemas.google.com/blogger/2008/kind#post
- NaBloPoMo 2012
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: What is going on with my iOS clipboard in Safari?!
---

<p>I <a href="https://twitter.com/mharen/status/267293420354154496">made a joke</a> earlier that was based on a Taylor Swift lyric (don’t judge me) so I found myself on one of those awful song lyrics sites so I could copy the line I wanted. I highlighted the line I wanted and hit copy:</p>  <p align="center"><img alt="2012-11-10 11.21.45" height="450" src="http://lh4.ggpht.com/-yCqHojYZGyY/UJ6SGyeqhnI/AAAAAAAAFOY/XYC1kdImceM/2012-11-10%25252011.21.45%25255B3%25255D.png?imgmax=800" style="margin: 3px 0px; display: inline;" title="2012-11-10 11.21.45" width="300" />&#160;</p>  <p align="left">But then something weird happened when I pasted the lyric into my Twitter client:</p>  <p align="center"><img alt="2012-11-10 11.31.23" height="450" src="http://lh4.ggpht.com/-1TgXiaKlcEA/UJ6SHqpfamI/AAAAAAAAFOg/-hwERUr8m7c/2012-11-10%25252011.31.23%25255B3%25255D.png?imgmax=800" style="margin: 3px 0px; display: inline;" title="2012-11-10 11.31.23" width="300" />&#160;<img alt="2012-11-10 11.31.27" height="450" src="http://lh6.ggpht.com/-EynGPmfNr5Y/UJ6SIoTFNgI/AAAAAAAAFOo/DcYfclgHQI0/2012-11-10%25252011.31.27%25255B3%25255D.png?imgmax=800" style="margin: 3px 0px; display: inline;" title="2012-11-10 11.31.27" width="300" /></p>  <p>Errr…what? I went back and tried copying again. Same thing. Weird.</p>  <p>So I loaded the same site on my desktop and immediately noticed strange behavior around text selection:</p>  <p align="center"><a href="http://lh5.ggpht.com/-58OKSGyaWnQ/UJ6SK9Lr62I/AAAAAAAAFOw/G5w3XFzdDAg/s1600-h/selection%25255B3%25255D.gif"><img alt="selection" height="240" src="http://lh5.ggpht.com/-KyhCIg_QCVs/UJ6SNyFb5BI/AAAAAAAAFO4/uizdOGeO10s/selection_thumb%25255B1%25255D.gif?imgmax=800" style="margin: 3px; display: inline;" title="selection" width="450" /></a></p>  <p>The title in line one works fine, but the lyrics themselves won’t hold a selection. What’s doing that? Let’s take a peek at the page’s source. The first thing I noticed was an unusually large amount of HTML entities:</p>  <p><img alt="image" height="237" src="http://lh6.ggpht.com/-uoAQ8lOPpLE/UJ6SPHBnJiI/AAAAAAAAFPA/QXRQKsgP8mQ/image%25255B11%25255D.png?imgmax=800" style="float: none; margin: 3px auto; display: block;" title="image" width="673" /></p>  <p>You normally use those codes to represent special characters. This site, however, is using them to obscuring the lyrics. (It’s hard to imagine that this is all that effective in protecting the content.) That’s not what I’m irritated by, though, so let’s keep looking. </p>  <p>I’m assuming the weird selection behavior is triggered by a script so let’s just look for those by searching for “.js”:</p>  <p><img alt="image" height="207" src="http://lh4.ggpht.com/-jYfwVJa4Z_8/UJ6SP5F-0zI/AAAAAAAAFPI/9LkT5eLTOlo/image%25255B14%25255D.png?imgmax=800" style="float: none; margin: 3px auto; display: block;" title="image" width="758" /></p>  <p>(I find it amusing that the site attributes the lyrics to Sony but still puts in all this effort to “protecting” them…)</p>  <p>Bingo. </p>  <p>That “protected-1.2.js” file looks like what we’re after. After it’s loaded, a bunch of mouse/selection/copy related events are bound to the various parts of the page. Let’s open that up to see if that’s where the site is messing with my clipboard:</p>  <pre class="csharpcode">    <span class="rem">//limit text</span>
    <span class="kwrd">function</span> manageText(str){
        <span class="kwrd">if</span>(!allow(str)){
            <span class="kwrd">return</span> str;
        }<span class="kwrd">else</span>{
            <span class="kwrd">return</span> <span class="str">&quot;<strong>Complete lyrics: </strong>&quot;</span>+ document.location.href;
        }
    }

    copyEl.innerHTML = manageText(c.toString());

    document.body.insertBefore(copyEl, document.body.firstChild);
    a.selectAllChildren(copyEl);</pre>

<p>There’s a lot more to it, but those are the key pieces that manipulated my clipboard. It’s actually pretty simple: this is all within the “noCopy” routine that’s bound to the “copy” event. When the browser tries to copy anything, it just throws some text into an element and selects <em>that</em> with <a href="https://developer.mozilla.org/en-US/docs/DOM/Selection/selectAllChildren">selectAllChildren</a> instead of whatever was highlighted.</p>

<p>Mean. Let’s fix it with the developer tools (control-shift-I or F12):</p>

<p align="center"></p>

<p>Obviously I didn’t actually go to all this trouble to copy that one line. I was just curious how things were working under the covers :).</p>

<hr />Credits/thanks: 

<ul>
  <li>Screencast recording via <a href="http://www.screenr.com/">Screenr</a> </li>

  <li>Mp4 to Gif converter via <a href="http://www.online-convert.com/">Online-Convert</a> </li>

  <li>Animated gif compression via <a href="http://www.gifreducer.com">GifReducer</a> </li>
</ul>