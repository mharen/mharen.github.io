---
date: '2009-08-02T15:11:00.001-04:00'
description: ''
published: true
slug: 2009-08-apache-reverse-proxy-implemented
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: Apache Reverse Proxy Implemented
---


Note to off-site viewers: this post has pictures. If you don’t see them, come to the site for a better view!

This is a follow-up on my <a href="../2009/2009-07-structuring-our-developer-tools-with.html">previous post</a> about the server architecture I setup to support my company’s developers. This was the goal:

&#160; ![image%5B11%5D.png](image%5B11%5D.png) 

Or in words: users inside and outside of the company need access to a bunch of tools (the green arrows). The proposed way of doing that uses a single server as a gatekeeper and router to other servers (the black arrows).

This design offers many benefits which I won’t repeat here—head over to the original post to read up on them. Instead, this follow up serves to document how this design was implemented. In many ways it was easier than expected but we hit a few hurdles I didn’t expect.

The first hurdle was expected: getting the reverse proxy working. A teammate tried to get this going with IIS7 for a while without success. I took a stab at it with <a href="http://www.apache.org/">Apache</a>—something I’m much more comfortable with—and got things working pretty quickly. While IIS required explicit rewrite rules with URLs, tags, etc., Apache seems better suited to the job and has a nice, clean configuration:
<blockquote>   <pre class="csharpcode">![image%5B62%5D.png](image%5B62%5D.png)ProxyPass /redmine/ http://rowlf/

<span class="kwrd">&lt;</span><span class="html">Location</span> /<span class="attr">redmine</span><span class="kwrd">/&gt;</span>
        ProxyPassReverse /redmine/
          Order Deny,Allow
          Allow from all
          Satisfy Any
        <span class="kwrd">&lt;/</span><span class="html">Limit</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">Location</span><span class="kwrd">&gt;</span>

ProxyPass /svn/ http://scooter/svn/
<span class="kwrd">&lt;</span><span class="html">Location</span> /<span class="attr">svn</span>/ <span class="kwrd">&gt;</span>
        ProxyPassReverse /svn/
        <span class="kwrd">&lt;</span><span class="html">Limit</span> <span class="attr">OPTIONS</span> <span class="attr">PROPFIND</span> <span class="attr">GET</span> <span class="attr">REPORT</span> <span class="attr">MKACTIVITY</span> <span class="attr">PROPPATCH</span> <span class="attr">PUT</span> <span class="attr">CHECKOUT</span> <span class="attr">MKCOL</span> <span class="attr">MOVE</span> <span class="attr">COPY</span> <span class="attr">DELETE</span> <span class="attr">LOCK</span> <span class="attr">UNLOCK</span> <span class="attr">MERGE</span><span class="kwrd">&gt;</span>
          Order Deny,Allow
          Allow from all
          Satisfy Any
        <span class="kwrd">&lt;/</span><span class="html">Limit</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">Location</span><span class="kwrd">&gt;</span>

ProxyPass /VaultService/ http://vincent/VaultService/
<span class="kwrd">&lt;</span><span class="html">Location</span> /<span class="attr">VaultService</span>/ <span class="kwrd">&gt;</span>
        ProxyPassReverse /VaultService/
          Order Deny,Allow
          Allow from all
          Satisfy Any
        <span class="kwrd">&lt;/</span><span class="html">Limit</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">Location</span><span class="kwrd">&gt;</span></pre>
</blockquote>


![image%5B73%5D.png](image%5B73%5D.png)<a href="http://www.redmine.org/">Redmine</a> was pretty easy to get going at first but had a path-root problem. It wasn’t liking that I was serving it out of a directory (/redmine) on kermit but was actually hosting it on a rwolf’s root (/). It complained by building resource links for things like css and js with an incorrect path. This was quickly remedied by adding this line to Redmine’s environment.rb file (it’s a Ruby on Rails app) as <a href="http://stackoverflow.com/questions/470961/configuring-ruby-on-rails-app-in-a-subdirectory-under-apache/470973#470973">noted here</a>:

<blockquote>
  <pre class="csharpcode"><span class="rem"># added to end of file C:\redmine\config\environment.rb</span>
ActionController::AbstractRequest.relative_url_root = <span class="str">&quot;/redmine&quot;</span></pre>
</blockquote>


![image%5B69%5D.png](image%5B69%5D.png) <a href="http://www.open.collab.net/products/subversion/">SVN</a> also took a little extra effort to realize it needed the extra verbs <a href="http://silmor.de/49">explicitly permitted</a> with a <a href="http://httpd.apache.org/docs/2.0/mod/core.html#limit">&lt;Limit&gt;</a> directive:

<blockquote>
  <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">Limit</span> <span class="attr">OPTIONS</span> <span class="attr">PROPFIND</span> <span class="attr">GET</span> <span class="attr">REPORT</span> <span class="attr">MKACTIVITY</span> <span class="attr">PROPPATCH</span> <span class="attr">PUT</span> <span class="attr">CHECKOUT</span> <span class="attr">MKCOL</span> <span class="attr">MOVE</span> <span class="attr">COPY</span> <span class="attr">DELETE</span> <span class="attr">LOCK</span> <span class="attr">UNLOCK</span> <span class="attr">MERGE</span><span class="kwrd">&gt;</span> </pre>
</blockquote>


By the time I got those two running, another teammate got <a href="http://www.sourcegear.com/vault/">Vault</a> running on Vincent so I wired that up easily, too. 


![image%5B63%5D.png](image%5B63%5D.png)I was most worried about Vault because it’s the only closed source system involved. I have nothing against closed-source software (it’s what I make every day), just that if SourceGear (Vault’s maker) didn’t plan or desire for Vault to work with a reverse proxy, I’d be pretty much SOL. But it worked most easily so props to <a href="http://sourcegear.com/">SourceGear</a>.


That’s it. Now I’ll just let it incubate for a week or two with a few people testing it occasionally to see that it holds up. When ready, I’ll just throw the switch and our existing users for svn and Redmine won’t even notice because their URLs won’t change. Vault users will need to use a new URL but hopefully for the last time…and maybe we can redirect the old URL to the new one transparently—I’ll need to look into that to see if the Vault client will follow a <a href="http://www.webconfs.com/how-to-redirect-a-webpage.php">301 redirect</a>…