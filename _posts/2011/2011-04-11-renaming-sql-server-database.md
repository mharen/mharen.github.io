---
layout: post
date: '2011-04-11T13:04:00.001-04:00'
categories:
- database
- code
- technology
title: Renaming a SQL Server Database
---

If a search brought you here, chance are that you can’t rename your database because SQL Server threw up an error about it being locked or active. This makes sense—obviously you can’t rename it if it’s being used by another user or application. But what if you want to rename it anyway?

Here’s how:  

1. Take the database into single-user mode (i.e. you)
2. Rename it
3. Return the database back to multi-user mode

This script does just that for SQL Server 2000:
   
```sql
ALTER DATABASE orig_db_name SET SINGLE_USER WITH ROLLBACK IMMEDIATE
EXEC sp_renamedb 'orig_db_name', 'new_db_name'
ALTER DATABASE new_db_name SET MULTI_USER
```

SQL Server 2005+ should use this slightly different version:

```sql
ALTER DATABASE orig_db_name SET SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE orig_db_name MODIFY NAME = new_db_name
ALTER DATABASE new_db_name SET MULTI_USER
```

If you want to rename the actual files on disk, too, [this article](http://www.mssqltips.com/tip.asp?tip=1891) does a fantastic job with that topic.

If you’re curious what `ROLLBACK IMMEDIATE` does, [this is a great explanation](http://itknowledgeexchange.techtarget.com/sql-server/understanding-what-the-with-rollback-immediate-does/). In short, it rolls back *other* transactions if they are blocking the desired operation. Without this statement, the `ALTER DATABASE` command may take as long as *forever* to run.

---

### 1 comment

**Unknown said on 2012-06-17**

If an old name looks like:

`C:\USERS\MBLOME\..\DATA\NORTHWND.MDF` (which is the fact with MS) then don't forget to surround the name with brackets `[C:\USERS\MBLOME\..\DATA\NORTHWND.MDF]`

Comments closed
{: .comments-closed }