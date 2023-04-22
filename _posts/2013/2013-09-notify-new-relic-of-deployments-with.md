---
date: '2013-09-09T10:03:00.001-04:00'
description: ''
published: true
slug: 2013-09-notify-new-relic-of-deployments-with
categories:
- Work
- DevOps
- Code
- Technology
time_to_read: 5
title: Notify New Relic of Deployments with Chef
---


You can tell New Relic about your deployments and they’ll add vertical lines to the graphs at the corresponding times. This is *super *helpful as the (often dramatic) impact of a deployment becomes easy to grok.

The documentation on the Events &gt; Deployments page is very helpful, but I still had to tinker with my message to New Relic’s API to get it to work. Here’s what I ended up with:

At the end of my recipe, post to the API with the [http_request](http://docs.opscode.com/resource_http_request.html) resource:<pre class="csharpcode">http_request <span class="str">"notify_new_relic"</span> do
  action :post
  url <span class="str">"https://rpm.newrelic.com/deployments.xml"</span>
  headers <span class="str">"x-api-key"</span> =&gt; <span class="str">"#{node["</span>newrelic<span class="str">"]["</span>apikey<span class="str">"]}"</span>
  message <span class="str">"application_id"</span> =&gt; <span class="str">"#{node["</span>newrelic<span class="str">"]["</span>appid<span class="str">"]}"</span>
end</pre>

I’m loading the key and application id from attributes. And it works (this is dev…no traffic there :))!

![deployment-markers%5B2%5D.png](deployment-markers%5B2%5D.png)

This was crazy simple to do, though it might be better implemented as a report handler. If you go that route please share.

---

## 1 comments captured from [original post](https://blog.wassupy.com/2013/09/notify-new-relic-of-deployments-with.html) on Blogger

**Unknown said on 2014-11-20**

Thanks for this, but the &quot;message&quot; parameter no longer accepts a hash, and the New Relic API has changed to use the URL &quot;https://api.newrelic.com/deployments.xml&quot; and the format of the parameters has changed. So you need something like:

message &quot;deployment[application_id]=#{app_id}&amp;deployment[revision]=#{sha}&quot; etc...

(I parse the Git SHA out of release_path, I'm sure there's a better way but Chef's sparse documentation bit me again)

Anyway thanks for getting me most of the way there :)

