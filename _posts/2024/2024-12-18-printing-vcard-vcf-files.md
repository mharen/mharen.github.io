---
layout: post
date: "2024-12-18"
categories:
    - technology
    - code
title: "Printing vcard/vcf files for holiday cards"
---

Apple's Contacts app is surprisingly weak, especially when it comes to printing, and I'm reminded of it every December
when I begin to send Christmas cards. All I want is a simple, printed list so that I can hand-address a bunch of cards
and cross them off my list as I go. The default (and only) output is _poor_ for this purpose so I made [a
page](https://vcfprinter.wassupy.com) that does a much better job:

<picture>
    <source height="1358" width="1980" srcset="/assets/2024/vcf-dark.png" media="(prefers-color-scheme: dark)" />
    <img height="1270" width="1892 " src="/assets/2024/vcf-light.png" alt='a screenshot of a web page that shows a bunch of contact cards' />
</picture>

And if you use a browser [other than Safari](https://bugs.webkit.org/show_bug.cgi?id=15546), it does a nice job with print layout, too, which was the whole point :):

<picture>
    <source height="1756" width="1862" srcset="/assets/2024/vcf-print-dark.png" media="(prefers-color-scheme: dark)" />
    <img height="1668" width="1774" src="/assets/2024/vcf-print-light.png" alt='a screenshot of a web page that shows a bunch of contact cards, print-preview mode' />
</picture>

The processing is all _in the browser_, so it's quick and private (your VCF file never leaves your device).
