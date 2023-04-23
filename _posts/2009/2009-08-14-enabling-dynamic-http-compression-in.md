---
layout: post
date: '2009-08-14T10:15:00.001-04:00'
categories: windows
title: Enabling Dynamic HTTP Compression in IIS7 on Windows Server 2008
---


I’m not very familiar with the newer configuration screens in Windows Server 2008 so I pulled my hair out trying to update some settings. Apparently it’s just too obvious for Google to have been any help so I’m documenting it here for the next shmuck.

I wanted to enable dynamic http compression. I found the page to *enable* it but it wasn’t *installed*:
<blockquote> 

“The dynamic content compression module is not installed.” (but we won’t tell you how to install it)
</blockquote>

It turns out that installing it is very easy and didn’t require a reboot (for me, at least):

**Text only**

Install it:  <ol>   <li>Open server manager</li>    <li>Roles > Web Server (IIS)</li>    <li>Role Services (scroll down) > Add Role Services</li>    <li>Add desired role (Web Server > Performance > Dynamic Content Compression)</li>    <li>Next, Install, Wait…Done!</li> </ol>

Enable it:  <ol>   <li>Open server manager</li>    <li>Roles > Web Server (IIS) > Internet Information Services (IIS) Manager</li>    <li>Next pane: Sites > Default Web Site > Your Web Site</li>    <li>Main pane: IIS > Compression</li> </ol>

**With perdy pictures**

Install it:  <ol>   <li>Open server manager     

![SNAG-0002%5B3%5D.png](SNAG-0002%5B3%5D.png)</a></li> </ol>

Enable it:  <ol>   <li>Open server manager</li>    <li>Roles > Web Server (IIS) > Internet Information Services (IIS) Manager     

![SNAG-0005%5B3%5D.png](SNAG-0005%5B3%5D.png)</a> </li> </ol>













You might be wondering why you’d want to compress content in the first place. [This site](http://weblogs.asp.net/owscott/archive/2009/02/22/iis-7-compression-good-bad-how-much.aspx) has a nice analysis of the practice as well as detailed information regarding what compression level you should use (and how to set it).

---

## 11 comments captured from [original post](https://blog.wassupy.com/2009/08/enabling-dynamic-http-compression-in.html) on Blogger

**Michael Haren said on 2009-08-22**

@Anonymous(2): oh don't worry, it's riveting.

@Patrick: Work and babies, I guess. And "The Wire".

**Hetal said on 2010-01-05**

Thanks for screen by screen process. It was pretty easy in windows 2003 even.

**Baldy said on 2010-07-01**

Thanks for the help.

**Matt Whitfield said on 2010-08-13**

Thanks - helpful post sorted me out a treat!

**Unknown said on 2011-01-03**

or you can go to Add\Remove programs>Turn windows features On or off>IIS>WWW Services>Performance features

**etymon technologies said on 2011-02-17**

Thanks for help :)

**Unknown said on 2011-03-04**

Thank You, Thank You! I have been looking for this solution for some time now.

**Etienne Dupuis said on 2011-03-15**

Thanks for the help!

“The dynamic content compression module is not installed.” 

(but we won’t tell you how to install it) <-- ahah i tought the same thing, pretty classic from Microsoft.

**ahsar said on 2011-04-12**

Thanks, it came in handy!

**pmarsh said on 2014-03-12**

Thanks man, you rock.  A little confused how Enable Dynamic Content Compression is checked and grayed out.  An info bubble in Alerts tells me the Role is not installed.  So does this mean IIS has been trying to compress content but it had no means how to do it?

**Yendor Nemingha said on 2015-03-24**

thanks heaps - helped solve a nasty problem. After our server reboot Dynamic compression was enabled for the web site but not installed as a feature! Installing it and turning off/on fixed one problem. Now for the next hurdle :-)

