---
date: '2013-09-09T10:03:00.001-04:00'
description: ''
published: true
slug: 2013-09-notify-new-relic-of-deployments-with
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- DevOps
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Notify New Relic of Deployments with Chef
---

<p>You can tell New Relic about your deployments and they’ll add vertical lines to the graphs at the corresponding times. This is <em>super </em>helpful as the (often dramatic) impact of a deployment becomes easy to grok.</p> <p>The documentation on the Events &gt; Deployments page is very helpful, but I still had to tinker with my message to New Relic’s API to get it to work. Here’s what I ended up with:</p> <p>At the end of my recipe, post to the API with the <a href="http://docs.opscode.com/resource_http_request.html">http_request</a> resource:</p><pre class="csharpcode">http_request <span class="str">"notify_new_relic"</span> do
  action :post
  url <span class="str">"https://rpm.newrelic.com/deployments.xml"</span>
  headers <span class="str">"x-api-key"</span> =&gt; <span class="str">"#{node["</span>newrelic<span class="str">"]["</span>apikey<span class="str">"]}"</span>
  message <span class="str">"application_id"</span> =&gt; <span class="str">"#{node["</span>newrelic<span class="str">"]["</span>appid<span class="str">"]}"</span>
end</pre>
<p>I’m loading the key and application id from attributes. And it works (this is dev…no traffic there :))!</p>
<p>![deployment-markers%25255B2%25255D.png](deployment-markers%25255B2%25255D.png)</p>
<p>This was crazy simple to do, though it might be better implemented as a report handler. If you go that route please share.</p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2013/09/notify-new-relic-of-deployments-with.html) on Blogger

**Unknown said on 2014-11-20**

Thanks for this, but the &quot;message&quot; parameter no longer accepts a hash, and the New Relic API has changed to use the URL &quot;https://api.newrelic.com/deployments.xml&quot; and the format of the parameters has changed. So you need something like:

message &quot;deployment[application_id]=#{app_id}&amp;deployment[revision]=#{sha}&quot; etc...

(I parse the Git SHA out of release_path, I'm sure there's a better way but Chef's sparse documentation bit me again)

Anyway thanks for getting me most of the way there :)

