---
date: '2011-04-11T13:04:00.001-04:00'
description: ''
published: true
slug: 2011-04-renaming-sql-server-database
tags:
- Database
- http://schemas.google.com/blogger/2008/kind#post
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Renaming a SQL Server Database
---

<p>If a search brought you here, chance are that you can’t rename your database because SQL Server threw up an error about it being locked or active. This makes sense—obviously you can’t rename it if it’s being used by another user or application. But what if you want to rename it anyway?</p>  <p>Here’s how:</p>  <ol>   <li>Take the database into single-user mode (i.e. you) </li>    <li>Rename it </li>    <li>Return the database back to multi-user mode </li> </ol>  <p>This script does just that for SQL Server 2000:</p>  <blockquote>   <pre class="csharpcode"><span class="kwrd">ALTER</span> <span class="kwrd">DATABASE</span> orig_db_name <span class="kwrd">SET</span> SINGLE_USER WITH ROLLBACK IMMEDIATE
<span class="kwrd">EXEC</span> sp_renamedb <span class="str">'orig_db_name'</span>, <span class="str">'new_db_name'</span>
<span class="kwrd">ALTER</span> <span class="kwrd">DATABASE</span> new_db_name <span class="kwrd">SET</span> MULTI_USER</pre>
</blockquote>

<p>SQL Server 2005+ should use this slightly different version:</p>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">ALTER</span> <span class="kwrd">DATABASE</span> orig_db_name <span class="kwrd">SET</span> SINGLE_USER WITH ROLLBACK IMMEDIATE
<span class="kwrd">ALTER</span> <span class="kwrd">DATABASE</span> orig_db_name <span class="kwrd">MODIFY</span> NAME = new_db_name
<span class="kwrd">ALTER</span> <span class="kwrd">DATABASE</span> new_db_name <span class="kwrd">SET</span> MULTI_USER</pre>
</blockquote>

<p>If you want to rename the actual files on disk, too, <a href="http://www.mssqltips.com/tip.asp?tip=1891">this article</a> does a fantastic job with that topic.</p>

<p>If you’re curious what <code>ROLLBACK IMMEDIATE</code> does, <a href="http://itknowledgeexchange.techtarget.com/sql-server/understanding-what-the-with-rollback-immediate-does/">this is a great explanation</a>. In short, it rolls back <em>other </em>transactions if they are blocking the desired operation. Without this statement, the <code>ALTER DATABASE</code> command may take as long as <em>forever</em> to run.</p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2011/04/renaming-sql-server-database.html) on Blogger

**Unknown said on 2012-06-17**

If an old name looks like:<br />C:\USERS\MBLOME\..\DATA\NORTHWND.MDF (wich is the fact with MS) then don't forget to surround the name with brackets<br />[C:\USERS\MBLOME\..\DATA\NORTHWND.MDF]

