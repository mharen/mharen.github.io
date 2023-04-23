---
layout: post
date: '2012-10-30T16:14:00.001-04:00'
categories:
- database
- work
- code
- technology
title: Catching Unique Key Constraint Violations with Entity Framework and SQL Server
---


Suppose you want to submit a model to your database with Entity Framework. It might look something like this:  
```cs
using(var db = new DatabaseContext()){
    // add object to context that already exists in DB
    // db.Whatever.AddObject(...)
    
    // save
    db.SaveChanges(); // BOOM
}
```



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


```cs
SELECT error, description
FROM master..sysmessages
WHERE msglangid = 1033 /* eng */
  AND description LIKE '%insert%duplicate%key%'
ORDER BY error
```


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


```cs
try {
    using(var db = new DatabaseContext()){
        // save
        db.SaveChanges(); // BOOM
    }
}
catch(UpdateException ex) {
    var sqlException = ex.InnerException as SqlException;
    
    if(sqlException != null && sqlException.Errors.OfType<SqlError>()
        .Any(se=>se.Number == 2601 || se.Number == 2627 /* PK/UKC violation */)) {
        
        // it's a dupe... do something about it
    }
    else {
        // it's something else...
        throw;
    }
}
```



First we make sure the inner exception is actually a SqlException, and then we confirm that it contains one the errors we want to handle.


Of course, this might be even prettier as an extension method that wraps the SaveChanges call (or a generic Func()) with all the ugly exception checking code…


**Note:** if you would prefer to actually check for duplicates before sending the insert, you can, but make sure you check atomically to avoid a concurrency issue. If you don’t, another transaction could insert a record which conflicts with yours between the command that checks for the duplicate and the command that inserts the row. 

---

## 1 comments captured from [original post](https://blog.wassupy.com/2012/10/catching-unique-key-constraint.html) on Blogger

**darichkid said on 2013-03-24**

Michael

This is even better than Entity Framework:

https://www.kellermansoftware.com/p-47-net-data-access-layer.aspx



