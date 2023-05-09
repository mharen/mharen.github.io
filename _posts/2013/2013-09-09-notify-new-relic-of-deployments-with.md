---
layout: post
date: '2013-09-09T10:03:00.001-04:00'
categories:
- work
- devops
- code
- technology
title: Notify New Relic of Deployments with Chef
---


You can tell New Relic about your deployments and they’ll add vertical lines to the graphs at the corresponding times. This is *super* helpful as the (often dramatic) impact of a deployment becomes easy to grok.

The documentation on the Events > Deployments page is very helpful, but I still had to tinker with my message to New Relic’s API to get it to work. Here’s what I ended up with:

At the end of my recipe, post to the API with the [http_request](http://docs.opscode.com/resource_http_request.html) resource:
```cs
http_request "notify_new_relic" do
  action :post
  url "https://rpm.newrelic.com/deployments.xml"
  headers "x-api-key" => "#{node["newrelic"]["apikey"]}"
  message "application_id" => "#{node["newrelic"]["appid"]}"
end
```

I’m loading the key and application id from attributes. And it works

This was crazy simple to do, though it might be better implemented as a report handler. If you go that route please share.

---

### 1 comment

**Unknown said on 2014-11-20**

Thanks for this, but the "message" parameter no longer accepts a hash, and the New Relic API has changed to use the URL `https://api.newrelic.com/deployments.xml` and the format of the parameters has changed. So you need something like:

    message "deployment[application_id]=#{app_id}&deployment[revision]=#{sha}"

(I parse the Git SHA out of release_path, I'm sure there's a better way but Chef's sparse documentation bit me again)

Anyway thanks for getting me most of the way there :)

