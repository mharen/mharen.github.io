---
layout: post
date: '2011-03-16T10:38:00.001-04:00'
categories:
- database
- work
- code
- technology
title: Truncating the log of a previously replicated database
---

(The following is specific to **SQL Server 2000** and might not apply to more recent versions.)

I occasionally restore production databases to a test system. Normally I just flip the recovery model from full and simple and I’m good to go. Unfortunately, if the database was being replicated it’s not so easy.

Even if you restore the database *without* “KEEP REPLICATION”, which would imply all the replication bits would be cleaned up for you, the transaction log will still have a replication marker that prevents it from being truncated. **This means the log file, even in “simple” mode, will grow unbounded (not good!).**

I’m always reminded of this when I try to clean up an ever-growing log with this command:
   
```sql
BACKUP LOG yourdb WITH TRUNCATE_ONLY
```

and I get this error:

The log was not truncated because records at the beginning of the log are pending replication. Ensure the Log Reader Agent is running or use sp_repldone to mark transactions as distributed 

Not one to ignore the advice of error messages, I then try running the following commands:
  
```sql
-- see what's going on
DBCC OPENTRAN

-- not too much? just clear the replication marker
EXEC sp_repldone @xactid = NULL, 
                 @xact_seqno = NULL, 
                 @numtrans = 0, 
                 @time = 0, 
                 @reset = 1
```

Unfortunately, this fails with the following error:

The database is not published

OK, so *part* of SQL Server knows it’s not being replicated, I guess that’s good. A lot of sites suggest physically removing the log file by detaching the database, renaming or deleting the log file, and reattaching the database. There’s a much [simpler, gentler way](http://www.sqlmag.com/Forums/tabid/426/aff/72/aft/83960/afv/topic/Default.aspx):
  
```sql
-- publish database (this doesn't actually create 
-- a snapshot--it only takes a cople seconds)
sp_replicationdboption 'yourdb','publish','true'

-- clear that replicaton marker (yourdb should be selected)
EXEC sp_repldone @xactid = NULL, @xact_seqno = NULL, @numtrans = 0, @time = 0, @reset = 1

-- unpublish database
sp_replicationdboption 'yourdb','publish','false'
```

Yes, you simply enable replication long enough to clear the marker. This only takes a few seconds as it doesn’t actually generate a new snapshot or anything expensive like that. **Now you’re free to truncate the log!**