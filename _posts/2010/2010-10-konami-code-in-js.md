---
date: '2010-10-23T23:24:00.001-04:00'
description: ''
published: true
slug: 2010-10-konami-code-in-js
categories:
- Easter Eggs
- Code
- Technology
time_to_read: 5
title: The Konami Code In JS
---


**Goal:** detect the Konami code when entered and do something cool. If you're not familiar with the Konami, do [some research](http://en.wikipedia.org/wiki/Konami_Code). If you have no interest in code, you can enter the Konami code on this site, chuckle or balk, and go on about your day.

To implement this we’ll need two basic components: a sequence detector to figure out when the code has been entered, and the &quot;something cool&quot;.  <h4>Sequence Detector</h4>

First, we need to determine what sequence we're interested in in terms of [key codes](http://www.quirksmode.org/js/keys.html):
<blockquote>   <pre class="csharpcode"><span class="kwrd">var</span> DesiredSequence = [
              38 <span class="rem">// up</span>
            , 38 <span class="rem">// up</span>
            , 40 <span class="rem">// down</span>
            , 40 <span class="rem">// down</span>
            , 37 <span class="rem">// left</span>
            , 39 <span class="rem">// right</span>
            , 37 <span class="rem">// left</span>
            , 39 <span class="rem">// right</span>
            , 66 <span class="rem">// b</span>
            , 65 <span class="rem">// a</span>
        ];</pre>
</blockquote>


And then we need a very, very simple [state machine](http://en.wikipedia.org/wiki/Finite-state_machine) to keep track of where we are in the sequence:

<blockquote>
  <pre class="csharpcode"><span class="kwrd">var</span> SequenceIndex = -1;

$(document).keydown(<span class="kwrd">function</span> (e) {
    <span class="kwrd">if</span> (e.which == DesiredSequence[SequenceIndex + 1]) {
        SequenceIndex++;

        <span class="kwrd">if</span> (SequenceIndex == DesiredSequence.length - 1) {

            <span class="rem">// do something cool (not shown yet) and reset the counter</span>
            SequenceIndex = -1;
        }
    }
    <span class="kwrd">else</span> {
        <span class="rem">// if user hit the first key, keep it, otherwise, start back at nothing</span>
        SequenceIndex = e.which == DesiredSequence[0] ? 0 : -1;
    }
});</pre>
</blockquote>


This is about as naïve as it gets and would not be appropriate for sequences with large repeating blocks. But we don’t have that so we’re good. (For example, if the user hits “up, up, up”, we could argue that the next key should be an “up” *or *a “down”, or even “up, up”, depending on how much history we consider. A serious state machine would take care of this but we do none of that here, because we’re not being very serious.)


So let's fill in that do-something-cool block.

<h4>Something Cool</h4>


A [lot of sites](http://konamicodesites.com/) do neat things for this code. My take on it will involve Ninja, just like Google Reader, but I'll put a different spin on it. Here's the code:

<blockquote>



    <pre class="csharpcode"><span class="kwrd">if</span> (SequenceIndex == DesiredSequence.length - 1) {
    SequenceIndex = -1;
            
    <span class="rem">// replace all headers</span>
    $(<span class="str">'h1,h2,h3,h4'</span>).text(<span class="str">'Konami Strikes!'</span>);
    $(<span class="str">'body'</span>).css(<span class="str">'background-color'</span>, <span class="str">'#E51E2B'</span>);

    <span class="rem">// add shurikens</span>
    $(<span class="str">'&lt;img/&gt;'</span>)
                .appendTo(<span class="str">'body'</span>)
                .attr(<span class="str">'src'</span>, <span class="str">'ninja.png'</span>)
                .css({
                    position: <span class="str">'fixed'</span>,
                    left: <span class="str">'-126px'</span>,
                    top: <span class="str">'400px'</span>
                })
                .animate({ left: <span class="str">'0px'</span> });

    <span class="kwrd">for</span> (<span class="kwrd">var</span> i = 0; i &lt; 20; i++) {
        $(<span class="str">'&lt;img/&gt;'</span>)
                    .css({ position: <span class="str">'fixed'</span> })
                    .appendTo(<span class="str">'body'</span>)
                    .attr(<span class="str">'src'</span>, i % 2 == 0 
                        ? <span class="str">'shuriken-1.gif'</span> 
                        : <span class="str">'shuriken-2.png'</span>)
                    .each(<span class="kwrd">function</span> () { DoFlyby(<span class="kwrd">this</span>); });
    }
}</pre>
  
</blockquote>


That leverages this function, defined elsewhere:

<pre class="csharpcode">    <span class="kwrd">function</span> DoFlyby(elem) {
        <span class="kwrd">var</span> Depth = .25 + Math.random() * 5;

        $(elem).css({
            left: (-1 * Depth * 32) + <span class="str">'px'</span>,
            <span class="rem">// the ninja is centered at 308px, so this should be offset </span>
            <span class="rem">// up by half the images width</span>
            top: (308 - (.5 * 32 * Depth)) + <span class="str">'px'</span>,
            width: 32 * Depth + <span class="str">'px'</span>
        })
        .animate({
            left: <span class="str">'2000px'</span>,
            top: -200 + Math.random() * 1200 + <span class="str">'px'</span> <span class="rem">// end b/t [10,90]% of the screen</span>
        },
            10000 / Depth, <span class="rem">// big stars move faster than slow stars</span>
            <span class="kwrd">function</span> () { DoFlyby(elem); }
        );
    }</pre>


Of course you could just give it a try on my site. (By the way, if you’re using a weaker browser like IE7, this might look awful.)


This is an [easter egg](http://en.wikipedia.org/wiki/Easter_egg_(media)#Software-based).