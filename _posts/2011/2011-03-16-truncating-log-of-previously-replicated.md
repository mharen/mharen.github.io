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

Even if you restore the database *without* “KEEP REPLICATION”, which would imply all the replication bits would be cleaned up for you, the transaction log will still have a replication marker that prevents it from being truncated.&#160; **This means the log file, even in “simple” mode, will grow unbounded (not good!).**

I’m always reminded of this when I try to clean up an ever-growing log with this command:
<blockquote>   <pre class="csharpcode"><span class="kwrd">BACKUP</span> LOG yourdb <span class="kwrd">WITH</span> TRUNCATE_ONLY</pre>
</blockquote>


and I get this error:

<blockquote>


The log was not truncated because records at the beginning of the log are pending replication. Ensure the Log Reader Agent is running or use sp_repldone to mark transactions as distributed 
    


</blockquote>


Not one to ignore the advice of error messages, I then try running the following commands:

<blockquote>
  <pre class="csharpcode"><span class="rem">-- see what's going on</span>
<span class="kwrd">DBCC</span> OPENTRAN

<span class="rem">-- not too much? just clear the replication marker</span>
<span class="kwrd">EXEC</span> sp_repldone @xactid = <span class="kwrd">NULL</span>, 
                 @xact_seqno = <span class="kwrd">NULL</span>, 
                 @numtrans = 0, 
                 @time = 0, 
                 @reset = 1</pre>
</blockquote>


Unfortunately, this fails with the following error:

<blockquote>


The database is not published.
</blockquote>


OK, so *part *of SQL Server knows it’s not being replicated, I guess that’s good. A lot of sites suggest physically removing the log file by detaching the database, renaming or deleting the log file, and reattaching the database. There’s a much [simpler, gentler way](http://www.sqlmag.com/Forums/tabid/426/aff/72/aft/83960/afv/topic/Default.aspx):

<blockquote>
  <pre class="csharpcode"><span class="rem">-- publish database (this doesn't actually create </span>
<span class="rem">-- a snapshot--it only takes a cople seconds)</span>
sp_replicationdboption <span class="str">'yourdb'</span>,<span class="str">'publish'</span>,<span class="str">'true'</span>

<span class="rem">-- clear that replicaton marker (yourdb should be selected)</span>
<span class="kwrd">EXEC</span> sp_repldone @xactid = <span class="kwrd">NULL</span>, @xact_seqno = <span class="kwrd">NULL</span>, @numtrans = 0, @<span class="kwrd">time</span> = 0, @reset = 1

<span class="rem">-- unpublish database</span>
sp_replicationdboption <span class="str">'yourdb'</span>,<span class="str">'publish'</span>,<span class="str">'false'</span></pre>
</blockquote>


Yes, you simply enable replication long enough to clear the marker. This only takes a few seconds as it doesn’t actually generate a new snapshot or anything expensive like that. **Now you’re free to truncate the log!**