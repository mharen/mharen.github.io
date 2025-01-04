---
layout: post
date: "2025-01-03"
categories:
    - technology
    - photography
title: The Adobe Lightroom backup story is terrible
---

Backing up an Adobe Lightroom catalog is a bit of a pain. If you have local storage large enough to hold all your photos
then you can tell Lightroom to save a copy of every photo there, and then you can backup that location. That's better
than nothing. But when you don't have enough space (largely thanks to Apple's exorbinate storage upgrade prices),
backing up everything, including what gets offloaded to Adobe's cloud is difficult. As far as I can tell, there's no
straightforward way to do this, especially not repeatedly.

**To be clear:** the cloud storage Adobe uses for Lightroom is exceptionally convenient, but it is not a backup. I want
a backup that will survive account compromise, loss of access, or a major technical issue with the provider.

*It'd be nice* if I could restore the backup without much disruption, but I'll settle for an inconvenient, incomplete copy of
everything.

Here's what I settled on:

1. Get a large external USB hard drive ($99)
2. Use the Adobe Lightroom Downloader to download all the photos to it (25 hours)
3. Repeat periodically

<picture>
    <source srcset="/assets/2025/lightroom-downloader-dark.png" media="(prefers-color-scheme: dark)" />
    <img height="1360" width="960" src="/assets/2025/lightroom-downloader-light.png" alt='a screenshot of an app titled "Lightroom Downloader", showing image files being downloaded and a progress bar at 17%. There is a button at the bottom labeled "Pause Download"' />
</picture>

I'm disappointed that this doesn't give me the high-fidelity backup I want, and that I have to manually do it every
month or two, and that it's wildly inefficient to re-download all the photos every time, but it's all I have.

### Things I wish I could do instead

I wish I could use a web service to automatically backup photos to a 3rd party, e.g. Google Photos, S3, B2, etc.

I wish I could run a script or service on my home Linux server to download just the changes periodically and
automatically.

I wish the Lightroom Downloader had a "sync" feature so it didn't have to download all 125k+ photos every time.

I wish the backup options didn't lose so much data along the way, e.g. album strcuture, and I wish backups could be
easily restored.