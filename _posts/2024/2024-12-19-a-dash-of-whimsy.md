---
layout: post
date: "2024-12-19"
categories:
  - code
title: A dash of whimsy with a tiny loading animation
---

It's neat how a teensy little animation can add a little whimsy to an otherwise [boring thing](https://vcfprinter.wassupy.com/) like loading a bunch of contact cards:

<video autoplay loop muted playsinline width="1866" height="1510">
  <source src="/assets/2024/vcf-whimsy.mp4" type="video/mp4">
  <source src="/assets/2024/vcf-whimsy.webm" type="video/webm">
  <source src="/assets/2024/vcf-whimsy.ogg" type="video/ogg">
  <img src="/assets/2024/vcf-whimsy.gif" loading="lazy" />
</video>

This is achieved with pretty much the most naive code you can imagine. I'm using JS to add the elements with  `opacity: 0`, and then schedule their reveal with a random delay:

```js
// ...
document.getElementById('output').appendChild(el);

setTimeout(() => {
    el.classList.add('show'); // sets `opacity: 1;`
}, Math.random() * 500);
```

This would work just as well for elements already in the DOM, too.