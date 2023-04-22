---
layout: post
date: '2010-03-08T13:38:00.001-05:00'
categories:
title: Creating/Submitting a Patch to a Subversion Repo
---


I’ve been told that these programming posts are not interesting or funny. For those that have no interest in programming, I offer the following jokes:
<blockquote> 

“I don't think I could stab somebody, cause I'm really bad at a Capri Sun.”  

“I hope God speaks English. If I get up to heaven and have to point at a menu, I'm gonna be pissed.”  

“I hope we find a cure for every major disease, because I'm tired of walking 5K. I'm pretty sure I don't have to sweat for cancer. I'll write a check.”   

–[Daniel Tosh](http://www.danieltosh.com/) ([via](http://en.wikiquote.org/wiki/Daniel_Tosh))
</blockquote>

Now would be a good time for you to stop reading.  <hr />

I use Subversion as my primary version control system. It’s awesome. I have a few users that have read-only rights to this repo and only occasionally make changes themselves. In these cases, I can’t provide commit rights to the repo so what are we to do? Patches.

A patch is basically a change set wrapped up into a single tidy file. The patch can be created by one dev and sent to another to be applied to the VCS. SVN, like most VCSs has very good support for patches. This post describes how to create one.

First, you should update your working directory if possible with “SVN Update”:

![image%5B2%5D.png](image%5B2%5D.png) 

Normally you would go to the Commit screen to apply your changes. Since you don’t have commit access, this won’t work, so instead right-click and go to “TortoiseSVN” &gt; “Create Patch”:

![image%5B5%5D.png](image%5B5%5D.png) 

A dialog will show you all the changes it has detected; you can double click each file to diff it. Choose the changes you want included in the patch and click “OK”:

![image%5B8%5D.png](image%5B8%5D.png) 

Save the patch somewhere handy:

![image%5B11%5D.png](image%5B11%5D.png) 

Send the patch file off to your committer and you’re done! Go ahead and open it up in a text editor if you want to see how these work. It’s basically a snippet of each of the pieces of code you changed, all bundled up into a nice text file.  <h3>Applying a Patch to a Subversion Repo</h3>

Of course the process of applying patches is simple, too. Right-click on the patch file and choose “TortoiseSVN” &gt; “Apply Patch”:

![image%5B14%5D.png](image%5B14%5D.png) 

Choose the SVN working directory to which the patch should be applied:

![image%5B17%5D.png](image%5B17%5D.png) 







You’ll see a list of the patched files and have the opportunity to review each change:

![image%5B20%5D.png](image%5B20%5D.png) 

Then right click to apply some or all of the changes into the working directory you chose.

The patch has now been applied to your working directory—now would be a good time to commit it via normal means (right-click &gt;&#160; “SVN Commit”):

![image%5B23%5D.png](image%5B23%5D.png) 

It might seem a little complicated at first, but after you do it once or twice it’ll click as a convenient and effective way to share change sets.