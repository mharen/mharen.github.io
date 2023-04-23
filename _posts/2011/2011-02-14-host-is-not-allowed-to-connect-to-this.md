---
layout: post
date: '2011-02-14T12:09:00.001-05:00'
categories:
- database
- technology
title: "\u201CHost is not allowed to connect to this mysql server\u201D [Solved]"
---

Depending on your setup, MySql may be locked down pretty tight. This is good. However, today I needed to connect to a database from another host. Googling eventually yielded the appropriate commands but to document the solution for my future self, I’m logging them here.


The issue is that MySql, when properly configured, only allows connections from a very limited set of hosts. Often this is simply “localhost”, which satisfies the very common case of apps/db all on one machine. If you need to access the system from another machine you need to do two things:


<ol>
<li>Enable MySql to listen on an address (typically TCP/IP port 3306) </li>
<li>Enable a remote user/host to connect with some privileges </li>
</ol>
Item 1 is covered elsewhere in depth, and in my case is configurable through the MySQL Server Instance Config Wizard. Done.


The solution to item 2 however, was surprisingly difficult to uncover. Here’s the error that probably brought you here:


<blockquote>
<pre>$ <strong>telnet mysql_server 3306
</strong>
Host: ‘urmachine.domain.com’ is not allowed to connect to this MySQL server

Connection to host lost.
```

</blockquote>
When the connection *works* you get a handshake request, which fails unless you speak MySQL but the point is you *can *connect.


What you need to do is enable the host listed in the error message to connect as a particular user. Login to your MySQL server and open a local connection:


<blockquote>
<pre>$ <strong>mysql -uroot -p
</strong>Enter password: <strong>************************
</strong>Welcome to the....

mysql> 
```

</blockquote>
To see who's already enabled, run this query:


<blockquote>
<pre>mysql> **select host, user from user;**
+--------------------+---------+
| host               | user    |
+--------------------+---------+
| 127.0.0.1          | root    |
| localhost          |         |
| localhost          | foobar  |
| localhost          | root    |
+--------------------+---------+
4 rows in set (0.00 sec)
```

</blockquote>
Now we need to add a new record. I'm interested in simply reading data from my remote host so I'm granting "select" privilges. If you need more, adjust the command accordingly, up to giving the host everything with the "all" keyword: 




<blockquote>
<pre>mysql> **grant select on urDatabase.* to urUser@'urMachine.domain.com' identified by 'urPassword';**
Query OK, 0 rows affected (0.00 sec)

mysql> <strong>flush privileges;
</strong>Query OK, 0 rows affected (0.05 sec)
```

</blockquote>
And now we're in the user list:


<blockquote>
<pre>mysql> <strong>select host, user from user;
</strong>+-----------------------+---------+
| host                  | user    |
+-----------------------+---------+
| 127.0.0.1             | root    |
| localhost             |         |
| localhost             | redmine |
| localhost             | root    |
| <span style="background-color: yellow;">urMachine.domain.com</span>  | <span style="background-color: yellow;">urUser</span>  |
+-----------------------+---------+
5 rows in set (0.00 sec)
```

</blockquote>
The above applies to MySQL 5, and is probably adaptable to other nearby versions.

---

## 4 comments captured from [original post](https://blog.wassupy.com/2011/02/host-is-not-allowed-to-connect-to-this.html) on Blogger

**Sourabh said on 2012-07-22**

Thanx.... Really helped me....

**Michael said on 2014-03-19**

Thanks. It helped a lot.

**Unknown said on 2014-04-02**

Thanks bro! Very good!

**sk said on 2014-08-08**

hello ... very good post; thank you VERY much. 

Clean crisp **and** explanatory. 

Keep these kind of posts coming 

- sanjiv singh

