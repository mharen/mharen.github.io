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

RESTORE DATABASE is terminating abnormally.</font></code></pre>
</blockquote>

<pre><font face="Trebuchet MS">What’s going on here is that you need exclusive access to the DB but someone’s already there. Here’s the simplest approach I know of to get in there and get busy:</font></pre>

<pre><font face="Trebuchet MS">Figure out who should be kicked off the system:</font></pre>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">EXEC</span> sp_who2 </pre>
</blockquote>

<pre><font face="Trebuchet MS">![SNAG-00242.png](SNAG-00242.png)</a></font></pre>


Copy down all the SPIDs associated with the DB you want to overwrite. Obviously your DB will be there instead of “OMS”—that’s mine, get your own!


Then fill those numbers into this script:

<blockquote>
  <pre class="csharpcode"><span class="rem">-- Lookup users on YourDb with ‘sp_who2’, then kill their SPIDs like this:</span>
<span class="kwrd">KILL</span> 51   
<span class="kwrd">KILL</span> 52
<span class="kwrd">KILL</span> 58   
<span class="kwrd">KILL</span> 59   
<span class="kwrd">KILL</span> 60   
<span class="kwrd">KILL</span> 61   

<span class="rem">-- put database in single user mode so others can't get in and block the restore</span>
<span class="kwrd">ALTER</span> <span class="kwrd">DATABASE</span> YourDb <span class="kwrd">SET</span> Single_User <span class="kwrd">WITH</span> <span class="kwrd">ROLLBACK</span> <span class="kwrd">IMMEDIATE</span>
<span class="kwrd">GO</span>

<span class="rem">-- TIP: you can generate this restore command from the &quot;Restore&quot; dialog!</span>
<span class="rem">-- TIP: change &quot;STATS = 10&quot; to &quot;STATS = 1&quot; for more feedback on long restores</span>
<span class="kwrd">RESTORE</span> <span class="kwrd">DATABASE</span> YourDb <span class="kwrd">FROM</span>  
    <span class="kwrd">DISK</span> = N<span class="str">'G:\MSSQL\MSSQL\BACKUP\Yourbackup.bak'</span> <span class="kwrd">WITH</span>  <span class="kwrd">FILE</span> = 1,  
    MOVE N<span class="str">'OMS_Data'</span> <span class="kwrd">TO</span> N<span class="str">'G:\MSSQL\MSSQL\Data\Data.MDF'</span>,  
    MOVE N<span class="str">'OMS_Log'</span> <span class="kwrd">TO</span> N<span class="str">'G:\MSSQL\MSSQL\Data\Log.LDF'</span>,  
    NOUNLOAD,  REPLACE,  STATS = 1
<span class="kwrd">GO</span>

<span class="rem">-- Put the DB back into multi-user mode so everyone can play</span>
<span class="kwrd">ALTER</span> <span class="kwrd">DATABASE</span> YourDb <span class="kwrd">SET</span> Multi_User
GO</pre>
</blockquote>


That should do it.