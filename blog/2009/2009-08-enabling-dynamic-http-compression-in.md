---
date: '2009-08-14T10:15:00.001-04:00'
description: ''
published: true
slug: 2009-08-enabling-dynamic-http-compression-in
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Windows
- legacy-blogger
time_to_read: 5
title: Enabling Dynamic HTTP Compression in IIS7 on Windows Server 2008
---

<p>I’m not very familiar with the newer configuration screens in Windows Server 2008 so I pulled my hair out trying to update some settings. Apparently it’s just too obvious for Google to have been any help so I’m documenting it here for the next shmuck.</p>  <p>I wanted to enable dynamic http compression. I found the page to <em>enable</em> it but it wasn’t <em>installed</em>:</p>  <blockquote>   <p>“The dynamic content compression module is not installed.” (but we won’t tell you how to install it)</p> </blockquote>  <p>It turns out that installing it is very easy and didn’t require a reboot (for me, at least):</p>  <p><strong>Text only</strong></p>  <p>Install it:</p>  <ol>   <li>Open server manager</li>    <li>Roles &gt; Web Server (IIS)</li>    <li>Role Services (scroll down) &gt; Add Role Services</li>    <li>Add desired role (Web Server &gt; Performance &gt; Dynamic Content Compression)</li>    <li>Next, Install, Wait…Done!</li> </ol>  <p>Enable it:</p>  <ol>   <li>Open server manager</li>    <li>Roles &gt; Web Server (IIS) &gt; Internet Information Services (IIS) Manager</li>    <li>Next pane: Sites &gt; Default Web Site &gt; Your Web Site</li>    <li>Main pane: IIS &gt; Compression</li> </ol>  <p><strong>With perdy pictures</strong></p>  <p>Install it:</p>  <ol>   <li>Open server manager     <br /><a href="http://lh3.ggpht.com/_IKD9WtY5kxU/SoVu9t5XwII/AAAAAAAAAe8/ET0YIX9YDeU/0%20start%20server%20manager%5B2%5D.png?imgmax=800"><img alt="0 start server manager" border="0" height="51" src="http://lh3.ggpht.com/_IKD9WtY5kxU/SoVwI9YuQcI/AAAAAAAAAfA/nxgLdFWMoko/0%20start%20server%20manager_thumb.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="0 start server manager" width="212" /></a>      <br /></li>    <li>Roles &gt; Web Server (IIS)</li>    <li>Role Services (scroll down) &gt; Add Role Services     <br /><a href="http://lh4.ggpht.com/_IKD9WtY5kxU/SoVwKZ4BftI/AAAAAAAAAfE/rBQz1crywsY/s1600-h/SNAG-0000%5B10%5D.png"><img alt="SNAG-0000" border="0" height="391" src="http://lh6.ggpht.com/_IKD9WtY5kxU/SoVwLJKojoI/AAAAAAAAAfI/p05kFyp462U/SNAG-0000_thumb%5B6%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="SNAG-0000" width="644" /></a>      <br /></li>    <li>Add desired role (Web Server &gt; Performance &gt; Dynamic Content Compression)     <br /><a href="http://lh6.ggpht.com/_IKD9WtY5kxU/SoVwLbnjSPI/AAAAAAAAAfM/tw2kgJGE11o/s1600-h/SNAG-0001%5B3%5D.png"><img alt="SNAG-0001" border="0" height="126" src="http://lh6.ggpht.com/_IKD9WtY5kxU/SoVwLuYOtEI/AAAAAAAAAfQ/lgRIEWyhUsk/SNAG-0001_thumb%5B1%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="SNAG-0001" width="289" /></a>      <br /></li>    <li>Next, Install, Wait…Done!     <br /><a href="http://lh6.ggpht.com/_IKD9WtY5kxU/SoVwMWkzOcI/AAAAAAAAAfU/0nrUFvNdBWg/s1600-h/SNAG-0002%5B3%5D.png"><img alt="SNAG-0002" border="0" height="127" src="http://lh4.ggpht.com/_IKD9WtY5kxU/SoVwM3PbbiI/AAAAAAAAAfY/YjnWn_AnyCY/SNAG-0002_thumb%5B1%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="SNAG-0002" width="430" /></a></li> </ol>  <p>Enable it:</p>  <ol>   <li>Open server manager</li>    <li>Roles &gt; Web Server (IIS) &gt; Internet Information Services (IIS) Manager     <br /><a href="http://lh3.ggpht.com/_IKD9WtY5kxU/SoVwNM19vlI/AAAAAAAAAfc/QKLitvzy6LA/SNAG-0003%5B2%5D.png?imgmax=800"><img alt="SNAG-0003" border="0" height="92" src="http://lh5.ggpht.com/_IKD9WtY5kxU/SoVwOfEiu8I/AAAAAAAAAfg/EMuaWDP3sFU/SNAG-0003_thumb.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="SNAG-0003" width="175" /></a>      <br /></li>    <li>Next pane: Sites &gt; Default Web Site &gt; Your Web Site</li>    <li>Main pane: IIS &gt; Compression     <br /><a href="http://lh3.ggpht.com/_IKD9WtY5kxU/SoVwO-RukqI/AAAAAAAAAfk/r_R9KWbZix4/SNAG-0004%5B3%5D.png?imgmax=800"><img alt="SNAG-0004" border="0" height="484" src="http://lh4.ggpht.com/_IKD9WtY5kxU/SoVxaZL5hwI/AAAAAAAAAfo/N3tih3uVqT4/SNAG-0004_thumb%5B1%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="SNAG-0004" width="529" /></a>      <br />      <br /><a href="http://lh6.ggpht.com/_IKD9WtY5kxU/SoVxa4H5_HI/AAAAAAAAAfs/eHOMIrqNd2A/s1600-h/SNAG-0005%5B3%5D.png"><img alt="SNAG-0005" border="0" height="164" src="http://lh4.ggpht.com/_IKD9WtY5kxU/SoVxbVs91lI/AAAAAAAAAfw/-MS1wQpjN_M/SNAG-0005_thumb%5B1%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="SNAG-0005" width="418" /></a> </li> </ol>  <p></p>  <p></p>  <p></p>  <p></p>  <p></p>  <p></p>  <p>You might be wondering why you’d want to compress content in the first place. <a href="http://weblogs.asp.net/owscott/archive/2009/02/22/iis-7-compression-good-bad-how-much.aspx">This site</a> has a nice analysis of the practice as well as detailed information regarding what compression level you should use (and how to set it).</p>

---

## 11 comments captured from [original post](https://blog.wassupy.com/2009/08/enabling-dynamic-http-compression-in.html) on Blogger

**Michael Haren said on 2009-08-22**

@Anonymous(2): oh don't worry, it's riveting.

@Patrick: Work and babies, I guess. And &quot;The Wire&quot;.

**Hetal said on 2010-01-05**

Thanks for screen by screen process. It was pretty easy in windows 2003 even.

**Baldy said on 2010-07-01**

Thanks for the help.

**Matt Whitfield said on 2010-08-13**

Thanks - helpful post sorted me out a treat!

**Unknown said on 2011-01-03**

or you can go to Add\Remove programs&gt;Turn windows features On or off&gt;IIS&gt;WWW Services&gt;Performance features

**etymon technologies said on 2011-02-17**

Thanks for help :)

**Unknown said on 2011-03-04**

Thank You, Thank You! I have been looking for this solution for some time now.

**Etienne Dupuis said on 2011-03-15**

Thanks for the help!

“The dynamic content compression module is not installed.” 

(but we won’t tell you how to install it) &lt;-- ahah i tought the same thing, pretty classic from Microsoft.

**ahsar said on 2011-04-12**

Thanks, it came in handy!

**pmarsh said on 2014-03-12**

Thanks man, you rock.  A little confused how Enable Dynamic Content Compression is checked and grayed out.  An info bubble in Alerts tells me the Role is not installed.  So does this mean IIS has been trying to compress content but it had no means how to do it?

**Yendor Nemingha said on 2015-03-24**

thanks heaps - helped solve a nasty problem. After our server reboot Dynamic compression was enabled for the web site but not installed as a feature! Installing it and turning off/on fixed one problem. Now for the next hurdle :-)

