---
date: '2010-03-05T11:59:00.001-05:00'
description: ''
published: true
slug: 2010-03-htmljs-progressive-enhancement
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Code
- legacy-blogger
time_to_read: 5
title: 'HTML/JS: Progressive Enhancement'
---

<p>The great thing about a semantic approach to web development is how nice and easy it can be to make progressive enhancements.</p>  <p>For example, suppose I have a “what’s this” help link beside some potentially confusing statement:</p>  <p>&#160;<img alt="image" border="0" height="538" src="http://lh4.ggpht.com/_IKD9WtY5kxU/S5E4apdc-xI/AAAAAAAAAqg/P7sivkWjM7M/image%5B11%5D.png?imgmax=800" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="771" /> </p>  <p></p>  <p>Nothing fancy here—just a link with a _blank target (<a href="http://jsbin.com/unuqo/3/edit">source</a>, <a href="http://jsbin.com/unuqo/3">demo</a>):</p>  <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">p</span><span class="kwrd">&gt;</span>Hello World 
  <span class="kwrd">&lt;</span><span class="html">a</span> <span class="attr">href</span><span class="kwrd">=&quot;/help/tips&quot;</span>
     <span class="attr">target</span><span class="kwrd">=&quot;_blank&quot;</span> 
     <span class="attr">title</span><span class="kwrd">=&quot;Hello World Help&quot;</span>
     <span class="attr">class</span><span class="kwrd">=&quot;help-link&quot;</span><span class="kwrd">&gt;</span>(what's this?)<span class="kwrd">&lt;/</span><span class="html">a</span><span class="kwrd">&gt;&lt;/</span><span class="html">p</span><span class="kwrd">&gt;</span></pre>

<p>It’s not very pretty but it gets the job done without any Javascript. Let’s make it sexy:</p>

<p><img alt="image" border="0" height="538" src="http://lh3.ggpht.com/_IKD9WtY5kxU/S5E4bK5JP8I/AAAAAAAAAqk/zV6hHkZYPOE/image%5B8%5D.png?imgmax=800" style="border-right-width: 0px; display: block; float: none; border-top-width: 0px; border-bottom-width: 0px; margin-left: auto; border-left-width: 0px; margin-right: auto;" title="image" width="771" /> </p>

<p>Here we’ve augmented the help link with a nice <a href="http://jqueryui.com/home">jQuery UI</a> <a href="http://jqueryui.com/demos/dialog/">dialog</a> instead of a browser popup (<a href="http://jsbin.com/unuqo/4/edit">source</a>, <a href="http://jsbin.com/unuqo/4">demo</a>):</p>

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

<p>This doesn’t require any changes to the HTML/CSS—it uses existing attributes like <code>href</code> and <code>title</code> to wire itself up to the link. And, if JS is disabled or broken, <em>the link will still work</em>. </p>

<p>By applying incremental enhancements in this fashion, we can easily maintain decent support for less-capable browsers while keeping our code clean and elegant.</p>

<p>You might notice, too, that this JS snippet is looking at a class (<code>help-link</code>), not an <code>id</code>. Since it infers everything it needs to show the dialog from the link itself, this snippet will work on <strong>any</strong> link in the page tagged with the <code>help-link</code> class. Nice, right?</p>