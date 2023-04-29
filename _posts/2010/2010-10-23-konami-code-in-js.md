---
layout: post
date: '2010-10-23T23:24:00.001-04:00'
categories:
- easter-eggs
- code
- technology
title: The Konami Code In JS
---

**Goal:** detect the Konami code when entered and do something cool. If you're not familiar with the Konami, do [some research](http://en.wikipedia.org/wiki/Konami_Code). If you have no interest in code, you can enter the Konami code on this site, chuckle or balk, and go on about your day.

To implement this we’ll need two basic components: a sequence detector to figure out when the code has been entered, and the "something cool".  

#### Sequence Detector

First, we need to determine what sequence we're interested in in terms of [key codes](http://www.quirksmode.org/js/keys.html):

```js
var DesiredSequence = [
              38 // up
            , 38 // up
            , 40 // down
            , 40 // down
            , 37 // left
            , 39 // right
            , 37 // left
            , 39 // right
            , 66 // b
            , 65 // a
        ];
```

And then we need a very, very simple [state machine](http://en.wikipedia.org/wiki/Finite-state_machine) to keep track of where we are in the sequence:

```js
var SequenceIndex = -1;

$(document).keydown(function (e) {
    if (e.which == DesiredSequence[SequenceIndex + 1]) {
        SequenceIndex++;

        if (SequenceIndex == DesiredSequence.length - 1) {

            // do something cool (not shown yet) and reset the counter
            SequenceIndex = -1;
        }
    }
    else {
        // if user hit the first key, keep it, otherwise, start back at nothing
        SequenceIndex = e.which == DesiredSequence[0] ? 0 : -1;
    }
});
```

This is about as naïve as it gets and would not be appropriate for sequences with large repeating blocks. But we don’t have that so we’re good. (For example, if the user hits “up, up, up”, we could argue that the next key should be an “up” *or *a “down”, or even “up, up”, depending on how much history we consider. A serious state machine would take care of this but we do none of that here, because we’re not being very serious.)

So let's fill in that do-something-cool block.

#### Something Cool

A [lot of sites](http://konamicodesites.com/) do neat things for this code. My take on it will involve Ninja, just like Google Reader, but I'll put a different spin on it. Here's the code:
    
```js
if (SequenceIndex == DesiredSequence.length - 1) {
    SequenceIndex = -1;
            
    // replace all headers
    $('h1,h2,h3,h4').text('Konami Strikes!');
    $('body').css('background-color', '#E51E2B');

    // add shurikens
    $('<img/>')
                .appendTo('body')
                .attr('src', 'ninja.png')
                .css({
                    position: 'fixed',
                    left: '-126px',
                    top: '400px'
                })
                .animate({ left: '0px' });

    for (var i = 0; i < 20; i++) {
        $('<img/>')
                    .css({ position: 'fixed' })
                    .appendTo('body')
                    .attr('src', i % 2 == 0 
                        ? 'shuriken-1.gif' 
                        : 'shuriken-2.png')
                    .each(function () { DoFlyby(this); });
    }
}
```

That leverages this function, defined elsewhere:

```js
    function DoFlyby(elem) {
        var Depth = .25 + Math.random() * 5;

        $(elem).css({
            left: (-1 * Depth * 32) + 'px',
            // the ninja is centered at 308px, so this should be offset 
            // up by half the images width
            top: (308 - (.5 * 32 * Depth)) + 'px',
            width: 32 * Depth + 'px'
        })
        .animate({
            left: '2000px',
            top: -200 + Math.random() * 1200 + 'px' // end b/t [10,90]% of the screen
        },
            10000 / Depth, // big stars move faster than slow stars
            function () { DoFlyby(elem); }
        );
    }
```
 
Of course you could just give it a try on my site. (By the way, if you’re using a weaker browser like IE7, this might look awful.)

This is an [easter egg](http://en.wikipedia.org/wiki/Easter_egg_(media)#Software-based).