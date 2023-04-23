---
layout: post
date: '2012-04-13T14:45:00.001-04:00'
categories:
- database
- work
- code
- technology
title: How To Restore a Database With Active Connections
---


If you’ve ever tried to restore over top of an existing database in SQL Server, you may be familiar with messages like these:
<blockquote> 

Msg 5061, Level 16, State 1, Line 1 ALTER DATABASE failed because a lock could not be placed on database 'foo'. Try again later    <pre><code><font face="Trebuchet MS">Exclusive access could not be obtained because the database is in use.

RESTORE DATABASE is terminating abnormally.</font></code>
```

</blockquote>

<pre><font face="Trebuchet MS">What’s going on here is that you need exclusive access to the DB but someone’s already there. Here’s the simplest approach I know of to get in there and get busy:</font>
```


<pre><font face="Trebuchet MS">Figure out who should be kicked off the system:</font>
```


<blockquote>
  
```cs
EXEC sp_who2 
```

</blockquote>

<pre><font face="Trebuchet MS">![SNAG-00242.png](SNAG-00242.png)</a></font>
```



Copy down all the SPIDs associated with the DB you want to overwrite. Obviously your DB will be there instead of “OMS”—that’s mine, get your own!


Then fill those numbers into this script:

<blockquote>
  
```cs
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
    DISK = N'G:\MSSQL\MSSQL\BACKUP\Yourbackup.bak' WITH  FILE = 1,  
    MOVE N'OMS_Data' TO N'G:\MSSQL\MSSQL\Data\Data.MDF',  
    MOVE N'OMS_Log' TO N'G:\MSSQL\MSSQL\Data\Log.LDF',  
    NOUNLOAD,  REPLACE,  STATS = 1
GO

-- Put the DB back into multi-user mode so everyone can play
ALTER DATABASE YourDb SET Multi_User
GO
```

</blockquote>


That should do it.