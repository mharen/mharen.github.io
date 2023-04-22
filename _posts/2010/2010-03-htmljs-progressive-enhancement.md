---
date: '2010-03-05T11:59:00.001-05:00'
description: ''
published: true
slug: 2010-03-htmljs-progressive-enhancement
categories:
- Code
time_to_read: 5
title: 'HTML/JS: Progressive Enhancement'
---


The great thing about a semantic approach to web development is how nice and easy it can be to make progressive enhancements.

For example, suppose I have a “what’s this” help link beside some potentially confusing statement:

&#160;![image%5B11%5D.png](image%5B11%5D.png) 



Nothing fancy here—just a link with a _blank target ([source](http://jsbin.com/unuqo/3/edit), [demo](http://jsbin.com/unuqo/3)):  <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">p</span><span class="kwrd">&gt;</span>Hello World 
  <span class="kwrd">&lt;</span><span class="html">a</span> <span class="attr">href</span><span class="kwrd">=&quot;/help/tips&quot;</span>
     <span class="attr">target</span><span class="kwrd">=&quot;_blank&quot;</span> 
     <span class="attr">title</span><span class="kwrd">=&quot;Hello World Help&quot;</span>
     <span class="attr">class</span><span class="kwrd">=&quot;help-link&quot;</span><span class="kwrd">&gt;</span>(what's this?)<span class="kwrd">&lt;/</span><span class="html">a</span><span class="kwrd">&gt;&lt;/</span><span class="html">p</span><span class="kwrd">&gt;</span></pre>


It’s not very pretty but it gets the job done without any Javascript. Let’s make it sexy:


![image%5B8%5D.png](image%5B8%5D.png) 


Here we’ve augmented the help link with a nice [jQuery UI](http://jqueryui.com/home) [dialog](http://jqueryui.com/demos/dialog/) instead of a browser popup ([source](http://jsbin.com/unuqo/4/edit), [demo](http://jsbin.com/unuqo/4)):

<pre class="csharpcode">$(<span class="kwrd">function</span>(){
  
  $(<span class="str">'.help-link'</span>).click(<span class="kwrd">function</span>(){
    
    $(<span class="str">'&lt;div&gt;&lt;/div&gt;'</span>)
      .attr(<span class="str">'title'</span>, <span class="kwrd">this</span>.title)
      .load(<span class="kwrd">this</span>.href)
      .dialog({
        modal: <span class="kwrd">true</span>,
        buttons: {
          Ok: <span class="kwrd">function</span> () {
            $(<span class="kwrd">this</span>).dialog(<span class="str">'close'</span>);
          }
        },
        width: 600,
        height: 350    
      });
    
    <span class="kwrd">return</span> <span class="kwrd">false</span>;
  });
  
});​</pre>


This doesn’t require any changes to the HTML/CSS—it uses existing attributes like <code>href</code> and <code>title</code> to wire itself up to the link. And, if JS is disabled or broken, *the link will still work*. 


By applying incremental enhancements in this fashion, we can easily maintain decent support for less-capable browsers while keeping our code clean and elegant.


You might notice, too, that this JS snippet is looking at a class (<code>help-link</code>), not an <code>id</code>. Since it infers everything it needs to show the dialog from the link itself, this snippet will work on **any** link in the page tagged with the <code>help-link</code> class. Nice, right?