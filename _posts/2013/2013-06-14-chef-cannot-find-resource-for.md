---
layout: post
date: '2013-06-14T09:45:00.001-04:00'
categories:
- chef
- windows
- code
- technology
title: 'Chef: Cannot find a resource for powershell on windows version 6.1.7600 (solved)'
---


While working on some deployment stuff I ran into this error:

> `Cannot find a resource for powershell on windows version 6.1.7600`

The [solution](http://community.opscode.com/chat/chef/2012-11-06#id-228600) turned out to be pretty obvious, and easy: **include the powershell cookbook**. For some reason I assumed it came in as part of the windows cookbook, but no. So just include it in your metadata.rb file like so:

```ruby
name             '...'
maintainer       '...'
maintainer_email '...'
description      '...'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          'windows'
depends          'powershell'
```

Of course, if you’re using Chef Solo, you’ll want to download your dependent cookbooks, too.
