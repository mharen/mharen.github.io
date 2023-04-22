---
date: '2012-07-31T09:54:00.001-04:00'
description: ''
published: true
slug: 2012-07-running-visual-studio-or-any-program-as
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Windows
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: Running Visual Studio (or Any Program) As An Administrator Without Prompting
  for Elevation
---

<blockquote> 
<p><strong>Update:</strong> this fix hasn’t been as comprehensively effective as I hoped. Some things work well, but I’m still running into escalation issues. <em>Sigh…</em></p>
</blockquote>
<p>As a developer, I often find myself doing things that only administrators can do. This is especially true since I work primarily with web applications within IIS, since related activities require elevation.</p>
<p>For years, I have simply launched my Visual Studio instances from a “Run as Administrator”-decorated short cut on my task bar like this:</p>
<p>![SNAG-0051%25255B4%25255D.png](SNAG-0051%25255B4%25255D.png)</a></p>  <p align="center"><strong><font color="#ff0000">Keep reading—there’s a better way than this for frequently used programs!</font></strong></p>
<p>BUT—that eventually drove me crazy enough to try something better because:</p>  <ul>   <li>I constantly see the UAC elevation dialog </li>    <li>Because the app is running elevated, files that would normally open in it won’t open when double-clicked (solution/sln files, particularly) </li> </ul>
<p>Today I finally got tired of it and spent eight minutes figuring out how to do this better. I followed <a href="http://cybernetnews.com/helpful-tip-disable-uac-prompt-for-an-application/">these instructions</a> to add a compatibility fix to the app so that it always runs as the user invoking it, which is me, and I’m an admin. Here’s the gist (slight additions to the referenced instructions):</p>  <ol>   <li>Download this thing: <a href="http://www.microsoft.com/en-us/download/details.aspx?id=7352">Microsoft Application Compatibility Toolkit</a> </li>    <li>Run the 32-bit version of it (not 64-bit version—both are installed if you have a 64-bit machine) </li>    <li>Add the new &quot;application fix” to the custom database. Choose your app (devenv.exe for me) and give it the “run as invoker” fix </li>    <li><em>Instead</em> of opening a command prompt and installing it, just go to <strong>File &gt; Install</strong> </li> </ol>
<p>Then I removed the “Run as Administrator” changes I made years back and things work great; my complaints above are fixed.</p>
<p>Careful users will note that this fix will probably break if the program is changed since many of the executable’s attributes are used to identify the program for fixing:</p>
<p>![SNAG-0052%25255B2%25255D.png](SNAG-0052%25255B2%25255D.png)</a></p>
<p>You can customize those when you create the fix, but I’m sticking with the defaults, which seem very narrow. I prefer to update the rule if the executable changes than have a new executable automatically receive the special treatment available through the compatibility fix.</p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2012/07/running-visual-studio-or-any-program-as.html) on Blogger

**Unknown said on 2014-06-23**

Instead of &quot;Run as Invoker&quot;, try using ForceAdminAccess and this fixed issue for me.

