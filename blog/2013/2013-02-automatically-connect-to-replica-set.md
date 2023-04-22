---
date: '2013-02-19T18:36:00.000-05:00'
description: ''
published: true
slug: 2013-02-automatically-connect-to-replica-set
tags:
- Database
- MongoDB
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Code
- legacy-blogger
time_to_read: 5
title: Automatically Connect to the Replica Set Primary with Mongo Shell
---

<p>So you got your fancy MongoDB Replica Set running, did you, Mr. Fancypants? Before too long you might run into an issue: <strong>how do you connect to the primary node when the primary can change? </strong></p> <p>Luckily our applications don’t have this problem because their drivers are smart and automatically connect to the primary. The Mongo shell doesn’t do that, though.</p> <p>Here’s a library to help with that. Throw this into a file called replicaSetConnector.js:</p><pre class="csharpcode"><span class="kwrd">var</span> ReplicaSetConnector = (<span class="kwrd">function</span>() { 
    <span class="kwrd">var</span> RSC = <span class="kwrd">function</span>(options) {
    
        <span class="rem">// private method for handling the dirty work of connecting </span>
        <span class="rem">// and authenticating to mongo</span>
        <span class="kwrd">var</span> connectAndAuth = <span class="kwrd">function</span>(host) {
            <span class="kwrd">if</span>(options.debug){
                print(<span class="str">"Connecting to "</span> 
                    + host + <span class="str">"/"</span> + options.database 
                    + <span class="str">" as "</span> + options.username + <span class="str">":"</span> + options.password);
            }
            
            <span class="kwrd">var</span> connection = <span class="kwrd">new</span> Mongo(host);
            <span class="kwrd">var</span> database = connection.getDB(options.database);
            database.auth(options.username, options.password);    
            
            <span class="kwrd">return</span> database;    
        };
        
        <span class="kwrd">this</span>.connect = <span class="kwrd">function</span>() {
            <span class="rem">// db needs to be a global variable for subsequent shell commands to work :)</span>
            <span class="rem">// connect to the given host, which could be any node of the replica set</span>
            db = connectAndAuth(options.initialHost);
            
            <span class="rem">// load some basic replica set information, which will tell us </span>
            <span class="rem">// if we're on the primary, and if not where it is</span>
            <span class="kwrd">var</span> rsInfo = db.isMaster();

            <span class="rem">// if we're already on the primary, we're done. Otherwise, change our</span>
            <span class="rem">// connection to the primary</span>
            <span class="kwrd">if</span>(!rsInfo.ismaster){
                <span class="kwrd">if</span>(options.debug) print(<span class="str">"You're not on master..."</span>);
                db = connectAndAuth(rsInfo.primary);
                <span class="kwrd">if</span>(options.debug) print(<span class="str">"...or are you ;)"</span>);
            }
        };
    };
        
    <span class="kwrd">return</span> RSC;
})();</pre>
<p>That’s a library we’ll reuse bunches of times. Now make another file for your environment, e.g. prod.js with this in it:</p><pre class="csharpcode">(<span class="kwrd">new</span> ReplicaSetConnector({ 
    initialHost: <span class="str">'one-of-your-replica-set-nodes:27017'</span>, 
    database: <span class="str">"database-name"</span>, 
    username: <span class="str">"user"</span>, 
    password: <span class="str">"secret..."</span>,
    debug: <span class="kwrd">true</span>})).connect();</pre>
<p>And we’re finally read to connect with a mongo shell like so:</p><pre class="csharpcode">%&gt; mongo --shell --nodb replicaSetConnector.js prod.js
MongoDB shell version: 2.2.2
type "help" for help
loading file: replicaSetConnector.js
loading file: prod.js
Connecting to one-of-your-replica-set-nodes:27017/database-name as user:secret...
<strong>You're not on master...
</strong>Connecting to another-one-of-your-replica-set-nodes:27017/database-name as user:secret
<strong>...or are you ;)</strong>
&gt;</pre>
<p>Yes, now you are on master and the <code>db</code> object is set for you to begin executing commands. If you want to be extra terse on the command line, you can <a href="http://tldp.org/LDP/abs/html/aliases.html">alias</a> that command to something shorter, add the library to your <a href="http://docs.mongodb.org/manual/reference/mongo/#mongo-mongorc-file">mongorc</a> file, or make Windows shortcut.</p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2013/02/automatically-connect-to-replica-set.html) on Blogger

**Michael Haren said on 2013-04-10**

I don't know you could do that... :). I'll give it a try.

