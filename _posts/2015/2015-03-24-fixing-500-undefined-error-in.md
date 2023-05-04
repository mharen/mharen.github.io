---
layout: post
date: '2015-03-24T09:16:00.001-04:00'
categories: technology
title: 'Fixing "500 : undefined" error in Swashbuckle/Swagger'
---

Suppose you include XML docs to make your Swagger/[Swashbuckle](https://github.com/domaindrivendev/Swashbuckle) docs even better via the option:

```cs
c.IncludeXmlComments(Path.Combine(HttpRuntime.BinDirectory, "Das Docs.xml"));
```

And things work great locally. But then you publish to a webserver, an Azure Website, etc. and you get an error like this:

    500 : undefined http://your-site:80/swagger/docs/v1

You probably already enabled the generation of the XML documentation file, **but did you do it for the Release configuration**? Since you're here, probably not. Fix that and you'll be all set.

![project dialog]({{ "/assets/2015/project-dialog.png" | relative_url }})