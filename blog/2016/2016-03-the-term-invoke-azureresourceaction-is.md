---
date: '2016-03-08T21:54:00.001-05:00'
description: ''
published: true
slug: 2016-03-the-term-invoke-azureresourceaction-is
tags:
- http://schemas.google.com/blogger/2008/kind#post
- legacy-blogger
time_to_read: 5
title: The term 'Invoke-AzureResourceAction' is not recognized as the name of a cmdlet
---

In case you are getting this ungoogle-able error when using "<span style="font-family: Courier New, Courier, monospace;">Invoke-AzureResourceAction</span>":<div>
<blockquote class="tr_bq">
<span style="color: #666666; font-family: Courier New, Courier, monospace;">Invoke-AzureResourceAction : The term 'Invoke-AzureResourceAction' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.</span></blockquote>
<div>
You're might be using some out of date docs. Try "<span style="font-family: Courier New, Courier, monospace;">Invoke-Azure<u>Rm</u>ResourceAction</span>" instead (add the "Rm").</div>
<div>
<br /></div>
<div>
Oh, and if you then get this (because you're automating things):</div>
<div>
<blockquote class="tr_bq">
<span style="color: #666666; font-family: Courier New, Courier, monospace;">Invoke-AzureRmResourceAction : Windows PowerShell is in NonInteractive mode. Read and Prompt functionality is not available.</span></blockquote>
</div>
<div>
Try adding "<span style="font-family: Courier New, Courier, monospace;">-Force</span>" to run the command without prompting for interactive confirmation.</div>
</div>