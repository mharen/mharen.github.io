---
date: '2012-10-30T16:14:00.001-04:00'
description: ''
published: true
slug: 2012-10-catching-unique-key-constraint
tags:
- Database
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Catching Unique Key Constraint Violations with Entity Framework and SQL Server
---


Suppose you want to submit a model to your database with Entity Framework. It might look something like this:  <pre class="csharpcode"><span class="kwrd">using</span>(var db = <span class="kwrd">new</span> DatabaseContext()){
    <span class="rem">// add object to context that already exists in DB</span>
    <span class="rem">// db.Whatever.AddObject(...)</span>
    
    <span class="rem">// save</span>
    db.SaveChanges(); <span class="rem">// BOOM</span>
}</pre>


Now suppose your database has a unique key constraint to prevent you from inserting duplicate data. If you do, your insert will bomb with an UpdateException:

<blockquote>


An error occurred while updating the entries. See the inner exception for details.
</blockquote>


The inner exception is more helpful:

<blockquote>


Cannot insert duplicate key row in object '%.*ls' with unique index '%.*ls'. The duplicate key value is %ls.
</blockquote>


We can catch that and display a nice message to the user, but first we should make sure you’re handling the right thing. We only want to catch the exception if we know that it’s a duplication issue (not any other db-related issue). 


Digging into the exception reveals that its inner exception is a SqlException, which itself has a SqlErrorCollection. Nice!


The SqlErrorCollection is populated by the SQL Server itself. What could it contain? I’m glad you asked! This query can help:

<pre class="csharpcode"><span class="kwrd">SELECT</span> error, description
<span class="kwrd">FROM</span> master..sysmessages
<span class="kwrd">WHERE</span> msglangid = 1033 /* eng */
  <span class="kwrd">AND</span> description <span class="kwrd">LIKE</span> <span class="str">'%insert%duplicate%key%'</span>
<span class="kwrd">ORDER</span> <span class="kwrd">BY</span> error</pre>

<table border="0" cellpadding="2" cellspacing="0"><tbody>
    <tr>
      <th valign="top">Error</th>

      <th valign="top">Description</th>
    </tr>

    <tr>
      <td valign="top">2601</td>

      <td valign="top">Cannot insert duplicate key row in object '%.*ls' with unique index '%.*ls'. The duplicate key value is %ls.</td>
    </tr>

    <tr>
      <td valign="top">2627</td>

      <td valign="top">Violation of %ls constraint '%.*ls'. Cannot insert duplicate key in object '%.*ls'. The duplicate key value is %ls.</td>
    </tr>
  </tbody></table>


So those are just the errors we want to check for, and if you want to handle something else, check that sysmessages table for your other options (it will give you all the error numbers, severities, descriptions, etc.). 


Here’s how:

<pre class="csharpcode"><span class="kwrd">try</span> {
    <span class="kwrd">using</span>(var db = <span class="kwrd">new</span> DatabaseContext()){
        <span class="rem">// save</span>
        db.SaveChanges(); <span class="rem">// BOOM</span>
    }
}
<span class="kwrd">catch</span>(UpdateException ex) {
    var sqlException = ex.InnerException <span class="kwrd">as</span> SqlException;
    
    <span class="kwrd">if</span>(sqlException != <span class="kwrd">null</span> &amp;&amp; sqlException.Errors.OfType&lt;SqlError&gt;()
        .Any(se=&gt;se.Number == 2601 || se.Number == 2627 <span class="rem">/* PK/UKC violation */</span>)) {
        
        <span class="rem">// it's a dupe... do something about it</span>
    }
    <span class="kwrd">else</span> {
        <span class="rem">// it's something else...</span>
        <span class="kwrd">throw</span>;
    }
}</pre>


First we make sure the inner exception is actually a SqlException, and then we confirm that it contains one the errors we want to handle.


Of course, this might be even prettier as an extension method that wraps the SaveChanges call (or a generic Func()) with all the ugly exception checking code…


<strong>Note:</strong> if you would prefer to actually check for duplicates before sending the insert, you can, but make sure you check atomically to avoid a concurrency issue. If you don’t, another transaction could insert a record which conflicts with yours between the command that checks for the duplicate and the command that inserts the row. 

---

## 1 comments captured from [original post](https://blog.wassupy.com/2012/10/catching-unique-key-constraint.html) on Blogger

**darichkid said on 2013-03-24**

Michael

This is even better than Entity Framework:

https://www.kellermansoftware.com/p-47-net-data-access-layer.aspx



