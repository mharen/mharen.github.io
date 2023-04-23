---
layout: post
date: '2012-11-14T16:30:00.001-05:00'
categories:
- database
- nablopomo 2012
- code
- technology
title: "SQL Server 2012: \u201CSaving changes is not permitted\u2026\u201D"
---


Are you riding the new SQL Server 2012 HAWTNESS? Good for you. Did you try to make a table change in Management Studio that requires a table rebuild? Ouch. So you’ve seen this, then:

![alter%5B2%5D.png](alter%5B2%5D.png)
<blockquote> 

“Saving changes is not permitted. The changes you have made require the following tables to be dropped and re-created. You have either made changes to a table that can’t be re-created **or enabled the option Prevent saving changes that require the table to be re-created.**”
</blockquote>

So the answer’s right there, but it’s at the end of a really long blob of text so you are forgiven if you missed it. Before you close your table change designer (and lose those precious table changes), just go uncheck that box in the options:

![change%20options%5B2%5D.png](change%20options%5B2%5D.png)

Now try saving again. Good to go? Cool.

Now it will revert to the behavior it used in SSMS 2008 where it will still warn you if it thinks scary things might happen:

![warning%5B2%5D.png](warning%5B2%5D.png)

But it’ll let you continue.

---

### 11 comments

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

"Terima Kasih" from me in Indonesia.

**Fanny Adinda Syaf. said on 2014-02-14**

OMG! THANK YOU VERY MUCK! IT HELPED! T.T

**Kim Vigen said on 2014-02-27**

Mange mange TAK (DK)

(many many thanks)

**Unknown said on 2014-07-31**

Thanks for your help :)

**Unknown said on 2015-05-25**

thank thank thank a lot

**Unknown said on 2015-11-25**

very nice, thanks



