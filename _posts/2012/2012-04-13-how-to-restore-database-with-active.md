---
layout: post
date: '2012-04-13T14:45:00.001-04:00'
categories:
- database
- code
- technology
title: How To Restore a Database With Active Connections
---

If you’ve ever tried to restore over top of an existing database in SQL Server, you may be familiar with messages like these:

Msg 5061, Level 16, State 1, Line 1 ALTER DATABASE failed because a lock could not be placed on database 'foo'. Try again later    

```
Exclusive access could not be obtained because the database is in use.

RESTORE DATABASE is terminating abnormally.
```

What’s going on here is that you need exclusive access to the DB but someone’s already there. Here’s the simplest approach I know of to get in there and get busy:
  
```sql
EXEC sp_who2 
```

Copy down all the SPIDs associated with the DB you want to overwrite. Obviously your DB will be there instead of `YourDb` mine, get your own!

Then fill those numbers into this script:
  
```sql
-- Lookup users on YourDb with ‘sp_who2’, then kill their SPIDs like this:
KILL 51   
KILL 52
KILL 58   
KILL 59   
KILL 60   
KILL 61   

-- put database in single user mode so others can't get in and block the restore
ALTER DATABASE YourDb SET Single_User WITH ROLLBACK IMMEDIATE
GO

-- TIP: you can generate this restore command from the "Restore" dialog!
-- TIP: change "STATS = 10" to "STATS = 1" for more feedback on long restores
RESTORE DATABASE YourDb FROM  
    DISK = N'G:\MSSQL\MSSQL\BACKUP\YourDbbackup.bak' WITH  FILE = 1,  
    MOVE N'YourDb_Data' TO N'G:\MSSQL\MSSQL\Data\Data.MDF',  
    MOVE N'YourDb_Log' TO N'G:\MSSQL\MSSQL\Data\Log.LDF',  
    NOUNLOAD,  REPLACE,  STATS = 1
GO

-- Put the DB back into multi-user mode so everyone can play
ALTER DATABASE YourDb SET Multi_User
GO
```

That should do it.