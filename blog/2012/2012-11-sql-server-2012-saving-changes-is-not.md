---
date: '2012-11-14T16:30:00.001-05:00'
description: ''
published: true
slug: 2012-11-sql-server-2012-saving-changes-is-not
tags:
- Database
- http://schemas.google.com/blogger/2008/kind#post
- NaBloPoMo 2012
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: "SQL Server 2012: \u201CSaving changes is not permitted\u2026\u201D"
---

<p>Are you riding the new SQL Server 2012 HAWTNESS? Good for you. Did you try to make a table change in Management Studio that requires a table rebuild? Ouch. So you’ve seen this, then:</p>  <p><img alt="alter" height="531" src="http://lh4.ggpht.com/-PArYbehygE4/UKQNjGirySI/AAAAAAAAFRA/8mmbdNV9q2Q/alter%25255B2%25255D.png?imgmax=800" style="float: none; margin: 3px auto; display: block;" title="alter" width="625" /></p>  <blockquote>   <p>“Saving changes is not permitted. The changes you have made require the following tables to be dropped and re-created. You have either made changes to a table that can’t be re-created <strong>or enabled the option Prevent saving changes that require the table to be re-created.</strong>”</p> </blockquote>  <p>So the answer’s right there, but it’s at the end of a really long blob of text so you are forgiven if you missed it. Before you close your table change designer (and lose those precious table changes), just go uncheck that box in the options:</p>  <p><img alt="change options" height="437" src="http://lh6.ggpht.com/-HB2NTCb5hZ8/UKQNjglbhkI/AAAAAAAAFRI/bD31lhvZ0tM/change%252520options%25255B2%25255D.png?imgmax=800" style="float: none; margin: 3px auto; display: block;" title="change options" width="753" /></p>  <p>Now try saving again. Good to go? Cool.</p>  <p>Now it will revert to the behavior it used in SSMS 2008 where it will still warn you if it thinks scary things might happen:</p>  <p><img alt="warning" height="430" src="http://lh6.ggpht.com/-e9yJ1iHnJ1c/UKQNkcvABnI/AAAAAAAAFRQ/_vfEwhMe_-E/warning%25255B2%25255D.png?imgmax=800" style="float: none; margin: 3px auto; display: block;" title="warning" width="536" /></p>  <p>But it’ll let you continue.</p>

---

## 11 comments captured from [original post](https://blog.wassupy.com/2012/11/sql-server-2012-saving-changes-is-not.html) on Blogger

**Unknown said on 2013-06-11**

Thanks for helping us out.

**Jack said on 2013-09-06**

thank you so much

**Unknown said on 2014-01-07**

good stuff. thanks mate

**Unknown said on 2014-01-07**

good stuff. thanks mate

**Cliff_Mosdall said on 2014-01-13**

Big help - Thanks

**yohid said on 2014-02-03**

&quot;Terima Kasih&quot; from me in Indonesia.

**Fanny Adinda Syaf. said on 2014-02-14**

OMG! THANK YOU VERY MUCK! IT HELPED! T.T

**Kim Vigen said on 2014-02-27**

Mange mange TAK (DK)<br />(many many thanks)

**Unknown said on 2014-07-31**

Thanks for your help :)

**Unknown said on 2015-05-25**

thank thank thank a lot

**Unknown said on 2015-11-25**

very nice, thanks<br />

