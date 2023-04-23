---
layout: post
date: '2009-08-02T15:11:00.001-04:00'
categories:
- work
- technology
title: Apache Reverse Proxy Implemented
---


Note to off-site viewers: this post has pictures. If you don’t see them, come to the site for a better view!

This is a follow-up on my [previous post](../2009/2009-07-structuring-our-developer-tools-with.html) about the server architecture I setup to support my company’s developers. This was the goal:

&#160; ![image%5B11%5D.png](image%5B11%5D.png) 

Or in words: users inside and outside of the company need access to a bunch of tools (the green arrows). The proposed way of doing that uses a single server as a gatekeeper and router to other servers (the black arrows).

This design offers many benefits which I won’t repeat here—head over to the original post to read up on them. Instead, this follow up serves to document how this design was implemented. In many ways it was easier than expected but we hit a few hurdles I didn’t expect.

The first hurdle was expected: getting the reverse proxy working. A teammate tried to get this going with IIS7 for a while without success. I took a stab at it with [Apache](http://www.apache.org/)—something I’m much more comfortable with—and got things working pretty quickly. While IIS required explicit rewrite rules with URLs, tags, etc., Apache seems better suited to the job and has a nice, clean configuration:
<blockquote>   
```cs
![image%5B62%5D.png](image%5B62%5D.png)ProxyPass /redmine/ http://rowlf/

<Location /redmine/>
        ProxyPassReverse /redmine/
          Order Deny,Allow
          Allow from all
          Satisfy Any
        </Limit>
</Location>

ProxyPass /svn/ http://scooter/svn/
<Location /svn/ >
        ProxyPassReverse /svn/
        <Limit OPTIONS PROPFIND GET REPORT MKACTIVITY PROPPATCH PUT CHECKOUT MKCOL MOVE COPY DELETE LOCK UNLOCK MERGE>
          Order Deny,Allow
          Allow from all
          Satisfy Any
        </Limit>
</Location>

ProxyPass /VaultService/ http://vincent/VaultService/
<Location /VaultService/ >
        ProxyPassReverse /VaultService/
          Order Deny,Allow
          Allow from all
          Satisfy Any
        </Limit>
</Location>
```

</blockquote>


![image%5B73%5D.png](image%5B73%5D.png)[Redmine](http://www.redmine.org/) was pretty easy to get going at first but had a path-root problem. It wasn’t liking that I was serving it out of a directory (/redmine) on kermit but was actually hosting it on a rwolf’s root (/). It complained by building resource links for things like css and js with an incorrect path. This was quickly remedied by adding this line to Redmine’s environment.rb file (it’s a Ruby on Rails app) as [noted here](http://stackoverflow.com/questions/470961/configuring-ruby-on-rails-app-in-a-subdirectory-under-apache/470973#470973):

<blockquote>
  
```cs
# added to end of file C:\redmine\config\environment.rb
ActionController::AbstractRequest.relative_url_root = "/redmine"
```

</blockquote>


![image%5B69%5D.png](image%5B69%5D.png) [SVN](http://www.open.collab.net/products/subversion/) also took a little extra effort to realize it needed the extra verbs [explicitly permitted](http://silmor.de/49) with a [<Limit>](http://httpd.apache.org/docs/2.0/mod/core.html#limit) directive:

<blockquote>
  
```cs
<Limit OPTIONS PROPFIND GET REPORT MKACTIVITY PROPPATCH PUT CHECKOUT MKCOL MOVE COPY DELETE LOCK UNLOCK MERGE> 
```

</blockquote>


By the time I got those two running, another teammate got [Vault](http://www.sourcegear.com/vault/) running on Vincent so I wired that up easily, too. 


![image%5B63%5D.png](image%5B63%5D.png)I was most worried about Vault because it’s the only closed source system involved. I have nothing against closed-source software (it’s what I make every day), just that if SourceGear (Vault’s maker) didn’t plan or desire for Vault to work with a reverse proxy, I’d be pretty much SOL. But it worked most easily so props to [SourceGear](http://sourcegear.com/).


That’s it. Now I’ll just let it incubate for a week or two with a few people testing it occasionally to see that it holds up. When ready, I’ll just throw the switch and our existing users for svn and Redmine won’t even notice because their URLs won’t change. Vault users will need to use a new URL but hopefully for the last time…and maybe we can redirect the old URL to the new one transparently—I’ll need to look into that to see if the Vault client will follow a [301 redirect](http://www.webconfs.com/how-to-redirect-a-webpage.php)…