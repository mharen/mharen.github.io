---
layout: post
date: '2013-02-19T18:36:00.000-05:00'
categories:
- database
- mongodb
- work
- code
title: Automatically Connect to the Replica Set Primary with Mongo Shell
---


So you got your fancy MongoDB Replica Set running, did you, Mr. Fancypants? Before too long you might run into an issue: **how do you connect to the primary node when the primary can change? **

Luckily our applications don’t have this problem because their drivers are smart and automatically connect to the primary. The Mongo shell doesn’t do that, though.

Here’s a library to help with that. Throw this into a file called replicaSetConnector.js:
```cs
var ReplicaSetConnector = (function() { 
    var RSC = function(options) {
    
        // private method for handling the dirty work of connecting 
        // and authenticating to mongo
        var connectAndAuth = function(host) {
            if(options.debug){
                print("Connecting to " 
                    + host + "/" + options.database 
                    + " as " + options.username + ":" + options.password);
            }
            
            var connection = new Mongo(host);
            var database = connection.getDB(options.database);
            database.auth(options.username, options.password);    
            
            return database;    
        };
        
        this.connect = function() {
            // db needs to be a global variable for subsequent shell commands to work :)
            // connect to the given host, which could be any node of the replica set
            db = connectAndAuth(options.initialHost);
            
            // load some basic replica set information, which will tell us 
            // if we're on the primary, and if not where it is
            var rsInfo = db.isMaster();

            // if we're already on the primary, we're done. Otherwise, change our
            // connection to the primary
            if(!rsInfo.ismaster){
                if(options.debug) print("You're not on master...");
                db = connectAndAuth(rsInfo.primary);
                if(options.debug) print("...or are you ;)");
            }
        };
    };
        
    return RSC;
})();
```


That’s a library we’ll reuse bunches of times. Now make another file for your environment, e.g. prod.js with this in it:
```cs
(new ReplicaSetConnector({ 
    initialHost: 'one-of-your-replica-set-nodes:27017', 
    database: "database-name", 
    username: "user", 
    password: "secret...",
    debug: true})).connect();
```


And we’re finally read to connect with a mongo shell like so:
```cs
%> mongo --shell --nodb replicaSetConnector.js prod.js
MongoDB shell version: 2.2.2
type "help" for help
loading file: replicaSetConnector.js
loading file: prod.js
Connecting to one-of-your-replica-set-nodes:27017/database-name as user:secret...
<strong>You're not on master...
</strong>Connecting to another-one-of-your-replica-set-nodes:27017/database-name as user:secret
**...or are you ;)**
>
```


Yes, now you are on master and the <code>db</code> object is set for you to begin executing commands. If you want to be extra terse on the command line, you can [alias](http://tldp.org/LDP/abs/html/aliases.html) that command to something shorter, add the library to your [mongorc](http://docs.mongodb.org/manual/reference/mongo/#mongo-mongorc-file) file, or make Windows shortcut.

---

## 1 comments captured from [original post](https://blog.wassupy.com/2013/02/automatically-connect-to-replica-set.html) on Blogger

**Michael Haren said on 2013-04-10**

I don't know you could do that... :). I'll give it a try.

