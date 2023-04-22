---
date: '2013-02-05T16:56:00.001-05:00'
description: ''
published: true
slug: 2013-02-chef-on-windows-error-tar-cannot-fork
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Chef
- Work
- DevOps
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: 'Chef on Windows Error: tar: Cannot fork: Function not implemented (Solved)'
---


I’m [diving into](http://wiki.opscode.com/display/chef/Workstation+Setup+for+Windows) the fun world of [Chef](http://www.opscode.com/chef/). But I’m doing it on Windows, which has been…not smooth. Here’s my latest error:<pre style="padding-bottom: 10px; padding-left: 10px; padding-right: 10px; padding-top: 10px;">C:\Users\mharen\Code\chef-repo&gt;<strong>knife cookbook site install getting-started</strong>
Installing getting-started to C:/Users/mharen/Code/chef-repo/cookbooks
Checking out the master branch.
Pristine copy branch (chef-vendor-getting-started) exists, switching to it.
Downloading getting-started from the cookbooks site at version 0.4.0 to C:/Users/mharen/Code/chef-repo/cookbooks/getting-started.tar.gz
Cookbook saved: C:/Users/mharen/Code/chef-repo/cookbooks/getting-started.tar.gz
Removing pre-existing version.
Uncompressing getting-started version 0.4.0.
ERROR: Mixlib::ShellOut::ShellCommandFailed: <strong>Expected process to exit with [0], but received '2'</strong>
---- Begin output of tar zxvf C:/Users/mharen/Code/chef-repo/cookbooks/getting-started.tar.gz ----
STDOUT:
STDERR: <strong>tar: Cannot fork: Function not implemented
</strong>tar: Error is not recoverable: exiting now
---- End output of tar zxvf C:/Users/mharen/Code/chef-repo/cookbooks/getting-started.tar.gz ----
Ran tar zxvf C:/Users/mharen/Code/chef-repo/cookbooks/getting-started.tar.gz returned 2
</pre>

Lame. After wasting an embarrassingly large amount of time on this issue, I figured it out: I had multiple installs of the `tar` command:<pre style="padding-bottom: 10px; padding-left: 10px; padding-right: 10px; padding-top: 10px;">C:\Users\mharen\Code\chef-repo&gt;<strong>which -a tar</strong>
C:\Program Files (x86)\Gow\bin\tar.EXE
C:\chef\bin\tar.EXE
c:\Git\bin\tar.EXE
</pre>

And apparently some of them [suck](http://sourceforge.net/p/gnuwin32/discussion/74807/thread/c73aced2/). Hard. Since I’m playing with Chef, let’s just use that one—it probably works. This was as easy as updating my PATH variable to place `c:\chef\bin` at the beginning instead of the end (really just before the others found by `which`):

![image%25255B3%25255D.png](image%25255B3%25255D.png)</a>

Once you fix the path, close and reopen your cmd window and try the command again:<pre style="padding-bottom: 10px; padding-left: 10px; padding-right: 10px; padding-top: 10px;">C:\Users\mharen\Code\chef-repo&gt;<strong>which -a tar
C:\chef\bin\tar.EXE
</strong>c:\Git\bin\tar.EXE
C:\Program Files (x86)\Gow\bin\tar.EXE

C:\Users\mharen\Code\chef-repo&gt;<strong>knife cookbook site install getting-started
</strong>Installing getting-started to C:/Users/mharen/Code/chef-repo/cookbooks
Checking out the master branch.
Pristine copy branch (chef-vendor-getting-started) exists, switching to it.
Downloading getting-started from the cookbooks site at version 0.4.0 to C:/Users/mharen/Code/chef-repo/cookbooks/getting-started.tar.gz
Cookbook saved: C:/Users/mharen/Code/chef-repo/cookbooks/getting-started.tar.gz
Removing pre-existing version.
Uncompressing getting-started version 0.4.0.
removing downloaded tarball
1 files updated, committing changes
Creating tag cookbook-site-imported-getting-started-0.4.0
Checking out the master branch.
Updating b5a1d0d..42a8168
Fast-forward
 cookbooks/getting-started/README.rdoc              |  4 +++
 cookbooks/getting-started/attributes/default.rb    |  1 +
 cookbooks/getting-started/metadata.json            | 29 ++++++++++++++++++++++
 cookbooks/getting-started/metadata.rb              |  6 +++++
 cookbooks/getting-started/recipes/default.rb       | 23 +++++++++++++++++
 .../templates/default/chef-getting-started.txt.erb |  5 ++++
 6 files changed, 68 insertions(+)
 create mode 100644 cookbooks/getting-started/README.rdoc
 create mode 100644 cookbooks/getting-started/attributes/default.rb
 create mode 100644 cookbooks/getting-started/metadata.json
 create mode 100644 cookbooks/getting-started/metadata.rb
 create mode 100644 cookbooks/getting-started/recipes/default.rb
 create mode 100644 cookbooks/getting-started/templates/default/chef-getting-started.txt.erb
Cookbook getting-started version 0.4.0 successfully installed

C:\Users\mharen\Code\chef-repo&gt;</pre>

<strong>All fixed :)</strong>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2013/02/chef-on-windows-error-tar-cannot-fork.html) on Blogger

**John said on 2013-07-16**

Great post! Thanks!

