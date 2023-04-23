---
layout: post
date: '2013-06-14T09:45:00.001-04:00'
categories:
- chef
- windows
- work
- code
- technology
title: 'Chef: Cannot find a resource for powershell on windows version 6.1.7600 (solved)'
---


While working on some deployment stuff I ran into this error: <blockquote>

*Cannot find a resource for powershell on windows version 6.1.7600*</blockquote>

The [solution](http://community.opscode.com/chat/chef/2012-11-06#id-228600) turned out to be pretty obvious, and easy: **include the powershell cookbook**. For some reason I assumed it came in as part of the windows cookbook, but no. So just include it in your metadata.rb file like so: <blockquote>
```cs
name             '...'
maintainer       '...'
maintainer_email '...'
description      '...'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
depends          'windows'
**<font style="background-color: #ffff00;">depends          'powershell'</font>**
```
</blockquote>

Of course, if you’re using Chef Solo, you’ll want to download your dependent cookbooks, too.

---

### 2 comments

**seema said on 2014-01-08**

Hi,

I have facing the error

"cannot find a resource for windows_package on windows version 6.1.7601"

during executing cookbook.

Please give me the solution.

**Unknown said on 2014-04-01**

You have to add dependency in metadata.rb .

Add following lines at the end of file metadata.rb

1.%w{ windows }.each do |dep|

2.        depends dep

3.end



