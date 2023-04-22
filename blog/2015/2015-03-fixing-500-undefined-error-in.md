---
date: '2015-03-24T09:16:00.001-04:00'
description: ''
published: true
slug: 2015-03-fixing-500-undefined-error-in
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: 'Fixing "500 : undefined" error in Swashbuckle/Swagger'
---

Suppose you include XML docs to make your Swagger/<a href="https://github.com/domaindrivendev/Swashbuckle">Swashbuckle</a> docs even better via the option:<br />
<br />
<pre>  c.IncludeXmlComments(Path.Combine(HttpRuntime.BinDirectory, "Das Docs.xml"));
</pre>
<br />
And things work great locally. But then you publish to a webserver, an Azure Website, etc. and you get an error like this:<br />
<br />
<pre>  500 : undefined http://your-site:80/swagger/docs/v1</pre>
<br />
You probably already enabled the generation of the XML documentation file, but <b>did you do it for the Release configuration</b>? Since you're here, probably not. Fix that and you'll be all set.<br />
<br />
<div class="separator" style="clear: both; text-align: center;">
<img border="0" height="511" src="http://4.bp.blogspot.com/-RrUwBDpYtuY/VRFb-_-6tGI/AAAAAAAAGiY/ZUWGq4WYORA/s1600/project-dialog.png" width="640" /></div>