---
date: '2012-04-13T14:45:00.001-04:00'
description: ''
published: true
slug: 2012-04-how-to-restore-database-with-active
tags:
- Database
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: How To Restore a Database With Active Connections
---

<p>If you’ve ever tried to restore over top of an existing database in SQL Server, you may be familiar with messages like these:</p>  <blockquote>   <p>Msg 5061, Level 16, State 1, Line 1 ALTER DATABASE failed because a lock could not be placed on database 'foo'. Try again later</p>    <pre><code><font face="Trebuchet MS">Exclusive access could not be obtained because the database is in use.<br />RESTORE DATABASE is terminating abnormally.</font></code></pre>
</blockquote>

<pre><font face="Trebuchet MS">What’s going on here is that you need exclusive access to the DB but someone’s already there. Here’s the simplest approach I know of to get in there and get busy:</font></pre>

<pre><font face="Trebuchet MS">Figure out who should be kicked off the system:</font></pre>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">EXEC</span> sp_who2 </pre>
</blockquote>

<pre><font face="Trebuchet MS"><a href="http://lh4.ggpht.com/-EZc6brv5Nf4/T4h0NIX7N4I/AAAAAAAAEaw/kDbP2vJ1XMg/s1600-h/SNAG-00242.png"><img alt="SNAG-0024" height="302" src="http://lh6.ggpht.com/-T4pdPPP1y8Q/T4h0N88aeqI/AAAAAAAAEa4/pEViw2LEw_0/SNAG-0024_thumb.png?imgmax=800" style="margin: 3px auto; display: block; float: none;" title="SNAG-0024" width="472" /></a></font></pre>

<p>Copy down all the SPIDs associated with the DB you want to overwrite. Obviously your DB will be there instead of “OMS”—that’s mine, get your own!</p>

<p>Then fill those numbers into this script:</p>

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

<p>That should do it.</p>