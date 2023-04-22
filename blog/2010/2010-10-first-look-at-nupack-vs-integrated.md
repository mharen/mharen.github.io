---
date: '2010-10-20T22:01:00.001-04:00'
description: ''
published: true
slug: 2010-10-first-look-at-nupack-vs-integrated
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Technology
- legacy-blogger
time_to_read: 5
title: 'First Look at NuPack: A VS-Integrated Package Management Tool'
---

<h4>Installation</h4>
<p>Couldn’t be easier:</p>  <ul>   <li><img align="right" alt="image" height="39" src="http://lh4.ggpht.com/_IKD9WtY5kxU/TL-e-DoYxuI/AAAAAAAABGk/qFsUj1uElA4/image2.png" style="margin: 0px; display: inline;" title="image" width="210" /><a href="http://nupack.codeplex.com/"><u><font color="#0066cc">http://nupack.codeplex.com/</font></u></a> </li>    <li>Download </li>    <li>Go </li> </ul>  <h4>First Run</h4>
<p>Fire up Visual Studio 2010 and open the Package Manager Console under View &gt; Other Windows &gt; Package Manager Console (or press C-W, C-Z):</p>
<p><img alt="image" height="514" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TL-e_Dzx-KI/AAAAAAAABGo/NLDGuzKcu9E/image23.png" style="margin: 0px auto; display: block; float: none;" title="image" width="600" /></p>
<p>From here you get a nice, friendly command line window:</p>
<blockquote>   <pre><code><p>PM&gt;</p></code></pre>
</blockquote>

<p>This is a PowerShell console so the standard pattern of commands is available with the “-package” suffix. For example, to see what’s available, try List-Package:</p>

<blockquote>
  <pre>  <pre>PM&gt; <strong>List-Package</strong></pre>
Id Version Description <br />-- ------- ----------- <br />Adam.JSGenerator 1.1.0.0 Adam.JSGenerator helps producing snippets...<br />Agatha-rrsl      1.2.0 Request/Response Service Layer for .NET <br />AntiXSS          4.0.1 AntiXSS is an encoding library which uses...<br />Antlr            3.1.1 ANother Tool for Language Recognition...<br />Antlr            3.1.3 ANother Tool for Language Recognition... </pre>

  <pre>&lt;snip&gt; </pre>
</blockquote>

<blockquote>

<p>PM&gt; </p>
</blockquote>

<p>Nice! OK, Let’s open up a new ASP.NET MVC App:</p>

<p><img height="374" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TL-e_9PQR7I/AAAAAAAABGs/POLes1wu5do/image22.png" width="650" /></p>

<p>And throw together a simple MVC app:</p>

<p>Model:</p>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">namespace</span> TechTalk7.Models
{
    <span class="kwrd">public</span> <span class="kwrd">class</span> Idea
    {
        <span class="kwrd">public</span> <span class="kwrd">int</span> ID { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">string</span> Name { get; set; }
    }
}</pre>
</blockquote>

<p>Controller:</p>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">namespace</span> TechTalk7.Controllers
{

    <span class="kwrd">public</span> <span class="kwrd">partial</span> <span class="kwrd">class</span> IdeaController : Controller
    {
        <span class="kwrd">private</span> <span class="kwrd">static</span> List&lt;Idea&gt; Ideas = <span class="kwrd">new</span> List&lt;Idea&gt;();

        <span class="kwrd">public</span> IdeaController()
        {
            Ideas = <span class="kwrd">new</span> List&lt;Idea&gt;() { 
                <span class="kwrd">new</span> Idea() { ID = 1, Name = <span class="str">&quot;Brush your teeth&quot;</span> }, 
                <span class="kwrd">new</span> Idea() { ID = 2, Name = <span class="str">&quot;Study hard&quot;</span> } 
            };
        }

        <span class="kwrd">public</span> <span class="kwrd">virtual</span> ActionResult Index()
        {
            <span class="kwrd">return</span> View(Ideas);
        }
    }
}</pre>
</blockquote>

<p>View:</p>

<blockquote>
  <pre class="csharpcode">    &lt;h2&gt;Index&lt;/h2&gt;
    &lt;ol&gt;
    &lt;% <span class="kwrd">foreach</span> (TechTalk7.Models.Idea I <span class="kwrd">in</span> Model)
       { %&gt;

       &lt;li&gt;
        &lt;!--old way, without T4
        &lt;%=Html.ActionLink(I.Name, <span class="str">&quot;Details&quot;</span>, <span class="kwrd">new</span> { ID = I.ID }) %&gt; --&gt;
       &lt;/li&gt;

    &lt;%} %&gt;
    &lt;/ol&gt;</pre>
</blockquote>

<p>Output:</p>

<p><img alt="image" height="219" src="http://lh6.ggpht.com/_IKD9WtY5kxU/TL-fANsSwMI/AAAAAAAABGw/gMv2X9aeQ_k/image26.png" style="margin: 0px auto; display: block; float: none;" title="image" width="214" /></p>

<p>It works! Now let’s improve that view code by trying out that fancy <a href="http://mvccontrib.codeplex.com/wikipage?title=T4MVC">T4MVC</a> stuff I’ve <a href="http://channel9.msdn.com/blogs/jongalloway/jon-takes-five-with-david-ebbo-on-t4mvc">heard</a> so much about:</p>

<blockquote>
  <pre><code><p>PM&gt; <strong>Add-Package t4mvc</strong>     <br />Successfully added 'T4MVC 2.6.30' to TechTalk7 
<br />PM&gt; </p></code></pre>
</blockquote>

<p>That was easy. But what just happened? It looks like some files were added:</p>

<p align="center"><img height="304" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TL-fAWoQrKI/AAAAAAAABG0/2nc5pRrFWQs/image13.png" style="margin: 3px;" width="192" /></p>

<p>Sweet! Now I have T4MVC all ready to go and can do neat things like this:</p>

<blockquote>
  <pre class="csharpcode">    <span class="kwrd">&lt;</span><span class="html">ol</span><span class="kwrd">&gt;</span>
    <span class="asp">&lt;%</span> <span class="kwrd">foreach</span> (TechTalk7.Models.Idea I <span class="kwrd">in</span> Model)
       { <span class="asp">%&gt;</span>

       <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>
        <span class="rem">&lt;!-- <em>old way</em>, without T4--&gt;</span>
<strong>        <span class="asp">&lt;%</span>=Html.ActionLink(I.Name, <span class="str">&quot;Details&quot;</span>, <span class="kwrd">new</span> { ID = I.ID }) <span class="asp">%&gt;</span>
</strong>
        <span class="rem">&lt;!--new way, *with* T4--&gt;</span>
<strong>        <span class="asp">&lt;%</span>=Html.ActionLink(I.Name, MVC.Idea.Details(1)) <span class="asp">%&gt;</span></strong>
       <span class="kwrd">&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>

    <span class="asp">&lt;%</span>} <span class="asp">%&gt;</span>
    <span class="kwrd">&lt;/</span><span class="html">ol</span><span class="kwrd">&gt;</span></pre>
</blockquote>

<p>Better. No more typo-prone strings, clunky object initializers, and it’s even a little shorter.</p>

<p>Soon I’ll be checking out the Spark View Engine, too. With that, my code above could be replaced with something like this:</p>

<blockquote>
  <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">viewdata</span> <span class="attr">Ideas</span><span class="kwrd">=&quot;List[[TechTalk7.Models.Idea]]&quot;</span><span class="kwrd">/&gt;</span>
<span class="kwrd">&lt;</span><span class="html">h2</span><span class="kwrd">&gt;</span>Index<span class="kwrd">&lt;/</span><span class="html">h2</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">ol</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span> <span class="attr">each</span><span class="kwrd">=&quot;var I in Ideas&quot;</span><span class="kwrd">&gt;</span>
        ${Html.ActionLink(I.Name, MVC.Idea.Details(1))}
    <span class="kwrd">&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">ol</span><span class="kwrd">&gt;</span></pre>
</blockquote>

<p><em>That </em>looks pretty nice. </p>