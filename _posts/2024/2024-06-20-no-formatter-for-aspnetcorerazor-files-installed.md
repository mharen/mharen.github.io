---
layout: post
date: '2024-06-20'
categories:
- technology
title: VSCode: There is no formatter for 'aspnetcorerazor' files installed
---

After years of using VSCode I suddenly got this error after an update:

> There is no formatter for 'aspnetcorerazor' files installed

Huh. It's an easy fix: reinstall the c# extension by:

1. Open the command palette (`cmd-shift-p` or `ctrl-shift-p`)
2. Choose "Developer: Reinstall Extension..."
3. Choose "C#"
4. Wait a minute and look for the reload prompt
