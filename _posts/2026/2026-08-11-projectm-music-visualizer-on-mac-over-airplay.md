---
layout: post
date: "2026-08-11"
categories:
    - technology
    - code
title: Visualize Spotify on your TV with projectM, AirPlay, and a Mac
---

[projectM](https://github.com/projectM-visualizer/projectm) is an open source reimplementation of the old Winamp Milkdrop visualizer. It's free on [Steam](https://store.steampowered.com/app/1358800/projectM_Music_Visualizer/).

**The catch:** a visualizer needs to _hear_ the music, and macOS won't let an app tap whatever is playing out of your speakers. Worse, if you're AirPlaying Spotify to a TV, the audio isn't even going through your Mac's normal output. So the trick is to split the audio: send it to the TV _and_ to a virtual loopback device that projectM can listen to.

[BlackHole](https://github.com/ExistentialAudio/BlackHole) is that loopback device:

```sh
brew install blackhole-2ch
```

Reboot after installing—the installer adds a kernel-level audio driver and it won't show up until you do.

### Wire up the audio

1. Start AirPlaying to your TV, e.g. `Living Room TV`
2. Open **Audio MIDI Setup** and create a new **Multi-Output Device**. Check both
   your AirPlay device (`Living Room TV`) and `BlackHole 2ch`
3. Right click on **Multi-Output Device** and choose "Use this device for sound output"


<picture>
    <source srcset="/assets/2026/midi-device-dark.png" media="(prefers-color-scheme: dark)" />
    <img height="1184" width="1640" src="/assets/2026/midi-device-light.png" alt='a screenshot of the Audio MIDI Setup window with "Multi-Output Device" selected in the sidebar. Its Primary Device is "BlackHole 2ch" and in the device list both "BlackHole 2ch" and "Living Room TV" are checked under the "Use" column' />
</picture>

Now every sound your Mac makes goes to the TV and to BlackHole simultaneously.

### Point projectM at BlackHole

Install **[projectM Music Visualizer](https://store.steampowered.com/app/1358800/projectM_Music_Visualizer/)** from Steam and launch it. Press `cmd-i` to cycle through audio input devices until it lands on BlackHole—you'll know because the visualization starts reacting to the music instead of sitting there politely.

Enjoy some 90s vibes.


### Potential gotchas

When you reconnect to AirPlay in the future, recheck:

1. your midi output device still has your TV selected
2. your output device is still the primary output device