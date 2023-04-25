---
layout: post
date: '2011-07-19T10:31:00.001-04:00'
categories:
- database
- work
- code
- technology
title: Reseeding *All* Identity Values in a Database
---

*(This post was written against SQL Server 2000. The concepts apply to more recent versions, but the batch script may not work on them.)*

If you work intimately with databases for very long, you might run into an issue where you can’t insert a record because of some weird duplicate primary key error:

```
Msg 2627, Level 14, State 1, Line whatever        
Violation of PRIMARY KEY constraint 'PK'. Cannot insert duplicate key in object '<table>'.
The statement has been terminated.
```

“That’s strange,” you’ll say, because it’s failing on an identity column, which is supposed to auto-increment. Here’s a test case that demonstrates this behavior, and the fix:

```sql
CREATE TABLE IdentityTest (ID INT IDENTITY PRIMARY KEY)

-- insert auto-incrementing values
INSERT IdentityTest DEFAULT VALUES -- 1
INSERT IdentityTest DEFAULT VALUES -- 2
INSERT IdentityTest DEFAULT VALUES -- 3

SELECT * FROM IdentityTest -- 1, 2, 3

-- reseed the identity column
DBCC CHECKIDENT (IdentityTest, RESEED, -3)

-- insert more auto-incrementing values (note, things *work*...for a while)
INSERT IdentityTest DEFAULT VALUES -- -2
INSERT IdentityTest DEFAULT VALUES -- -1
INSERT IdentityTest DEFAULT VALUES -- 0
INSERT IdentityTest DEFAULT VALUES -- <font color="#ff0000">BOOM</font>

DBCC CHECKIDENT (IdentityTest, RESEED) -- fix!
INSERT IdentityTest DEFAULT VALUES -- phew!

SELECT * FROM IdentityTest -- 1, 2, 3, -2, -1, 0, 4

DROP TABLE IdentityTest
```

The easiest way to fix this is to reset (“reseed”) the table’s identity value:

  
```sql
DBCC CHECKIDENT (IdentityTest, RESEED) -- fix!
```

This script, pulled from [RedGate’s forums](http://bit.ly/plJNx2) (an awesome company, by the way), resets those identity values for every table in the database:

```sql
-- courtesy of RedGate forums http://bit.ly/plJNx2
DECLARE @table NVARCHAR(4000), @column NVARCHAR(4000)

DECLARE row CURSOR FOR
  SELECT 
    a.name TableName, 
    b.name IdentityColumn
  FROM sysobjects a
  JOIN syscolumns b
  ON a.id = b.id
  WHERE COLUMNPROPERTY(a.id, b.name, 'isIdentity') = 1
    AND OBJECTPROPERTY(a.id, 'isTable') = 1
    AND a.xtype='U'
  ORDER BY a.name
OPEN row

WHILE 1=1
BEGIN
  FETCH NEXT FROM row INTO @table, @column
  IF @@FETCH_STATUS = -1
     BREAK
  
  PRINT @table
  EXEC sp_executesql N'DBCC CHECKIDENT (@table, RESEED)', N'@table varchar(4000)', @table = @table   
  PRINT ''
END

CLOSE row
DEALLOCATE row
```

This is handy to have in the toolbox when a data sync screws up a bunch of tables. In fact, that’s the primary reason I’m posting it here—so ***I*** can refer back to it in the future as needed.