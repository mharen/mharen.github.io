---
layout: post
date: '2011-02-11T10:22:00.001-05:00'
categories:
- database
- technology
title: "Recovering from SQL Server Error: \u201CSyntax Error in TextHeader\u201D"
---

After years of working with SQL Server, I thought I’d seen it all. Here’s a humbling reminder that I haven’t:

{% imagesize /assets/2011/sql-error-text-header.png:img %}

This occurred when I tried to script out a stored procedure so I could change it. Not a good sign. Fortunately I can fallback to good old `sp_helptext` to recover the procedure:
   
```sql
sp_helptext 'procname'
-- Results in the procedure’s code
```

Nifty, right? But **why did this happen**? It seems SQL Server Management Studio or whatever it uses to script out objects objects to nested comments in the script header. This is what I had, which is a no-no:
  
```sql
/*  example execution:
EXEC procName
  @intParm1=3 explanation  
 ,@intParm2=null explanation  
*/

ALTER PROCEDURE [dbo].procName  
/* proc definition*/
```

What I was trying to do was include a sample call to the procedure to aid future development.** This was easily fixed by using the single-line comment syntax instead**:


  
```sql
/*  example execution:
EXEC procName
  @intParm1=3 explanation  
 ,@intParm2=null explanation  
*/

ALTER PROCEDURE [dbo].procName  
/* proc definition*/
```

(Hopefully it’s obvious that I don’t normally write procedures with obscure names and parameters like I have above.)

---

### 5 comments

**Andrew Johns said on 2012-06-06**

Just came across this myself for the first time in 12 years of development, had to google to find out WTF it meant, and came across this post.  Problem explained and solved.  Thanks :)

**Unknown said on 2013-06-14**

Same here, sp_helptext was a whole lot better than what I was about to do -- restore a backup!

**ThomasHoff said on 2013-08-05**

Awesome... saved my butt.  Thanks a ton!

**Logan said on 2014-06-19**

Thanks for the help. This was exactly my issue!

**Unknown said on 2015-11-24**

but how you modify or correct it ?

Comments closed
{: .comments-closed }