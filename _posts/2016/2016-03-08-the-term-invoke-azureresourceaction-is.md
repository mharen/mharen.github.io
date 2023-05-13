---
layout: post
date: '2016-03-08T21:54:00.001-05:00'
categories: technology
title: The term 'Invoke-AzureResourceAction' is not recognized as the name of a cmdlet
---

In case you are getting this ungoogle-able error when using `Invoke-AzureResourceAction`:

> `Invoke-AzureResourceAction : The term 'Invoke-AzureResourceAction' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.`

You're might be using some out of date docs. Try `Invoke-AzureRmResourceAction` instead (add the "Rm").

Oh, and if you then get this (because you're automating things):

> `Invoke-AzureRmResourceAction : Windows PowerShell is in NonInteractive mode. Read and Prompt functionality is not available.`

Try adding `-Force` to run the command without prompting for interactive confirmation.