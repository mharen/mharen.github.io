---
layout: post
date: "2025-01-05"
categories:
    - technology
    - code
    - homelab
    - family
title: Simple looping video with play/pause
---

### Including a video like a gif

Gifs are easy to include because they just go into a regular `img` tag. The `video` tag is unfortunately more complicated and requires careful preparation of the file. I use something like this:

```html
<video autoplay loop muted playsinline width="1280" height="720" aria-label="A looping video that shows...">
    <source src='av1.mp4' type='video/mp4; codecs=av01.0.00M.08'>
    <source src='vp9.webm' type='video/webm; codecs="vp9"'>
    <source src="h265.mp4" type="video/mp4">
    <source src="h264.mp4" type="video/mp4">
    <img src="video-or-animation.gif" loading="lazy" />
</video>
```

The browser will play the first video it supports from that list so I put them in order from best to worst in terms of quality and size.

Even if I know the codec string to set for the H265 video, I leave it off because Safari doesn't like it.

Theoretically you could set a codec for that `h264` video, too, but it's tough to figure out, and that's our last video anyway 🤷.


### Why use videos instead of gifs?

They're generally higher quality in a smaller payload.

My blog posts feature occasional animations or short videos—the sorts of things that animated gifs are great for. But really the only thing good about gifs is their universal support. In most cases, they have terrible quality and massive file sizes. On the modern web, we can use video instead.

Here's a gif next to a much nicer (and smaller) video [from a recent post][1]:

<video autoplay loop muted playsinline width="1280" height="720" aria-label="A looping video that shows a light plugged into a wall. Initially the light is red. Then the camera pulls back to show an open dog food container with an open/close sensor installed in the lid. Then the container is closed and the light turns green.">
    <source src="/assets/2025/dog-food-light.mp4" type="video/mp4">
    <source src="/assets/2025/dog-food-light.webm" type="video/webm">
    <source src="/assets/2025/dog-food-light.ogg" type="video/ogg">
    <img src="/assets/2025/dog-food-light.gif" loading="lazy" />
</video>

<img width="100%" src="/assets/2025/dog-food-light.gif" loading="lazy" alt="A looping video that shows a light plugged into a wall. Initially the light is red. Then the camera pulls back to show an open dog food container with an open/close sensor installed in the lid. Then the container is closed and the light turns green." />

The video looks decent at 720p@30fps and costs 1-1.4MB (depending on what format your device requests). The gif looks worse at 360p@10fps and costs ~3x as much (3.6MB).

If you make a gif small enough that it fits into the same ~1MB payload, it looks like this (480p@5fps, 1.2MB):

<img width="100%" src="/assets/2025/dog-food-light-1mb.gif" loading="lazy" alt="A looping video that shows a light plugged into a wall. Initially the light is red. Then the camera pulls back to show an open dog food container with an open/close sensor installed in the lid. Then the container is closed and the light turns green." />


Yuck.

[1]: /2025/01/dog-food-status-light.html "Dog food status light"