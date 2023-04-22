---
date: '2011-07-19T10:31:00.001-04:00'
description: ''
published: true
slug: 2011-07-reseeding-all-identity-values-in
tags:
- Database
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Reseeding *All* Identity Values in a Database
---


*(This post was written against SQL Server 2000. The concepts apply to more recent versions, but the batch script may not work on them.)*

If you work intimately with databases for very long, you might run into an issue where you can’t insert a record because of some weird duplicate primary key error:
<blockquote> 

<font color="#ff0000">Msg 2627, Level 14, State 1, Line whatever        

Violation of PRIMARY KEY constraint 'PK'. Cannot insert duplicate key in object '&lt;table&gt;'.</font>       

The statement has been terminated.
</blockquote>

“That’s strange,” you’ll say, because it’s failing on an identity column, which is supposed to auto-increment. Here’s a test case that demonstrates this behavior, and the fix:
<blockquote>   <pre class="csharpcode"><span class="kwrd">CREATE</span> <span class="kwrd">TABLE</span> IdentityTest (ID <span class="kwrd">INT</span> <span class="kwrd">IDENTITY</span> <span class="kwrd">PRIMARY</span> <span class="kwrd">KEY</span>)

<span class="rem">-- insert auto-incrementing values</span>
INSERT IdentityTest <span class="kwrd">DEFAULT</span> <span class="kwrd">VALUES</span> <span class="rem">-- 1</span>
INSERT IdentityTest <span class="kwrd">DEFAULT</span> <span class="kwrd">VALUES</span> <span class="rem">-- 2</span>
INSERT IdentityTest <span class="kwrd">DEFAULT</span> <span class="kwrd">VALUES</span> <span class="rem">-- 3</span>

<span class="kwrd">SELECT</span> * <span class="kwrd">FROM</span> IdentityTest <span class="rem">-- 1, 2, 3</span>

<span class="rem">-- reseed the identity column</span>
<span class="kwrd">DBCC</span> CHECKIDENT (IdentityTest, RESEED, -3)

<span class="rem">-- insert more auto-incrementing values (note, things *work*...for a while)</span>
INSERT IdentityTest <span class="kwrd">DEFAULT</span> <span class="kwrd">VALUES</span> <span class="rem">-- -2</span>
INSERT IdentityTest <span class="kwrd">DEFAULT</span> <span class="kwrd">VALUES</span> <span class="rem">-- -1</span>
INSERT IdentityTest <span class="kwrd">DEFAULT</span> <span class="kwrd">VALUES</span> <span class="rem">-- 0</span>
INSERT IdentityTest <span class="kwrd">DEFAULT</span> <span class="kwrd">VALUES</span> <span class="rem">-- <font color="#ff0000">BOOM</font></span>

<span class="kwrd">DBCC</span> CHECKIDENT (IdentityTest, RESEED) <span class="rem">-- fix!</span>
INSERT IdentityTest <span class="kwrd">DEFAULT</span> <span class="kwrd">VALUES</span> <span class="rem">-- phew!</span>

<span class="kwrd">SELECT</span> * <span class="kwrd">FROM</span> IdentityTest <span class="rem">-- 1, 2, 3, -2, -1, 0, 4</span>

<span class="kwrd">DROP</span> <span class="kwrd">TABLE</span> IdentityTest</pre>
</blockquote>


The easiest way to fix this is to reset (“reseed”) the table’s identity value:

<blockquote>
  <pre class="csharpcode"><span class="kwrd">DBCC</span> CHECKIDENT (IdentityTest, RESEED) -- fix!</pre>
</blockquote>


This script, pulled from [RedGate’s forums](http://bit.ly/plJNx2) (an awesome company, by the way), resets those identity values for every table in the database:

<blockquote>
  <pre class="csharpcode"><span class="rem">-- courtesy of RedGate forums http://bit.ly/plJNx2</span>
<span class="kwrd">DECLARE</span> @<span class="kwrd">table</span> NVARCHAR(4000), @<span class="kwrd">column</span> NVARCHAR(4000)

<span class="kwrd">DECLARE</span> <span class="kwrd">row</span> <span class="kwrd">CURSOR</span> <span class="kwrd">FOR</span>
  <span class="kwrd">SELECT</span> 
    a.name TableName, 
    b.name IdentityColumn
  <span class="kwrd">FROM</span> sysobjects a
  <span class="kwrd">JOIN</span> syscolumns b
  <span class="kwrd">ON</span> a.id = b.id
  <span class="kwrd">WHERE</span> COLUMNPROPERTY(a.id, b.name, <span class="str">'isIdentity'</span>) = 1
    <span class="kwrd">AND</span> OBJECTPROPERTY(a.id, <span class="str">'isTable'</span>) = 1
    <span class="kwrd">AND</span> a.xtype=<span class="str">'U'</span>
  <span class="kwrd">ORDER</span> <span class="kwrd">BY</span> a.name
<span class="kwrd">OPEN</span> <span class="kwrd">row</span>

<span class="kwrd">WHILE</span> 1=1
<span class="kwrd">BEGIN</span>
  <span class="kwrd">FETCH</span> <span class="kwrd">NEXT</span> <span class="kwrd">FROM</span> <span class="kwrd">row</span> <span class="kwrd">INTO</span> @<span class="kwrd">table</span>, @<span class="kwrd">column</span>
  <span class="kwrd">IF</span> <span class="preproc">@@FETCH_STATUS</span> = -1
     <span class="kwrd">BREAK</span>
  
  <span class="kwrd">PRINT</span> @<span class="kwrd">table</span>
  <span class="kwrd">EXEC</span> sp_executesql N<span class="str">'DBCC CHECKIDENT (@table, RESEED)'</span>, N<span class="str">'@table varchar(4000)'</span>, @<span class="kwrd">table</span> = @<span class="kwrd">table</span>   
  <span class="kwrd">PRINT</span> <span class="str">''</span>
<span class="kwrd">END</span>

<span class="kwrd">CLOSE</span> <span class="kwrd">row</span>
<span class="kwrd">DEALLOCATE</span> row</pre>
</blockquote>


This is handy to have in the toolbox when a data sync screws up a bunch of tables. In fact, that’s the primary reason I’m posting it here—so <strong>*I*</strong> can refer back to it in the future as needed.