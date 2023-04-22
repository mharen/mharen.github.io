---
date: '2010-10-20T22:01:00.001-04:00'
description: ''
published: true
slug: 2010-10-first-look-at-nupack-vs-integrated
categories:
- Technology
time_to_read: 5
title: 'First Look at NuPack: A VS-Integrated Package Management Tool'
---

<h4>Installation</h4>

Couldn’t be easier:  <ul>   <li>![image2.png](image2.png)[<u><font color="#0066cc">http://nupack.codeplex.com/</font></u>](http://nupack.codeplex.com/) </li>    <li>Download </li>    <li>Go </li> </ul>  <h4>First Run</h4>

Fire up Visual Studio 2010 and open the Package Manager Console under View &gt; Other Windows &gt; Package Manager Console (or press C-W, C-Z):

![image23.png](image23.png)

From here you get a nice, friendly command line window:
<blockquote>   <pre><code>
PM&gt;</code></pre>
</blockquote>


This is a PowerShell console so the standard pattern of commands is available with the “-package” suffix. For example, to see what’s available, try List-Package:

<blockquote>
  <pre>  <pre>PM&gt; **List-Package**</pre>
Id Version Description 

-- ------- ----------- 

Adam.JSGenerator 1.1.0.0 Adam.JSGenerator helps producing snippets...

Agatha-rrsl      1.2.0 Request/Response Service Layer for .NET 

AntiXSS          4.0.1 AntiXSS is an encoding library which uses...

Antlr            3.1.1 ANother Tool for Language Recognition...

Antlr            3.1.3 ANother Tool for Language Recognition... </pre>

  <pre>&lt;snip&gt; </pre>
</blockquote>

<blockquote>


PM&gt; 
</blockquote>


Nice! OK, Let’s open up a new ASP.NET MVC App:


![image22.png](image22.png)


And throw together a simple MVC app:


Model:

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


Controller:

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


View:

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


Output:


![image26.png](image26.png)


It works! Now let’s improve that view code by trying out that fancy [T4MVC](http://mvccontrib.codeplex.com/wikipage?title=T4MVC) stuff I’ve [heard](http://channel9.msdn.com/blogs/jongalloway/jon-takes-five-with-david-ebbo-on-t4mvc) so much about:

<blockquote>
  <pre><code>
PM&gt; **Add-Package t4mvc**     

Successfully added 'T4MVC 2.6.30' to TechTalk7 


PM&gt; </code></pre>
</blockquote>


That was easy. But what just happened? It looks like some files were added:



![image13.png](image13.png)


Sweet! Now I have T4MVC all ready to go and can do neat things like this:

<blockquote>
  <pre class="csharpcode">    <span class="kwrd">&lt;</span><span class="html">ol</span><span class="kwrd">&gt;</span>
    <span class="asp">&lt;%</span> <span class="kwrd">foreach</span> (TechTalk7.Models.Idea I <span class="kwrd">in</span> Model)
       { <span class="asp">%&gt;</span>

       <span class="kwrd">&lt;</span><span class="html">li</span><span class="kwrd">&gt;</span>
        <span class="rem">&lt;!-- *old way*, without T4--&gt;</span>
<strong>        <span class="asp">&lt;%</span>=Html.ActionLink(I.Name, <span class="str">&quot;Details&quot;</span>, <span class="kwrd">new</span> { ID = I.ID }) <span class="asp">%&gt;</span>
</strong>
        <span class="rem">&lt;!--new way, *with* T4--&gt;</span>
**        <span class="asp">&lt;%</span>=Html.ActionLink(I.Name, MVC.Idea.Details(1)) <span class="asp">%&gt;</span>**
       <span class="kwrd">&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>

    <span class="asp">&lt;%</span>} <span class="asp">%&gt;</span>
    <span class="kwrd">&lt;/</span><span class="html">ol</span><span class="kwrd">&gt;</span></pre>
</blockquote>


Better. No more typo-prone strings, clunky object initializers, and it’s even a little shorter.


Soon I’ll be checking out the Spark View Engine, too. With that, my code above could be replaced with something like this:

<blockquote>
  <pre class="csharpcode"><span class="kwrd">&lt;</span><span class="html">viewdata</span> <span class="attr">Ideas</span><span class="kwrd">=&quot;List[[TechTalk7.Models.Idea]]&quot;</span><span class="kwrd">/&gt;</span>
<span class="kwrd">&lt;</span><span class="html">h2</span><span class="kwrd">&gt;</span>Index<span class="kwrd">&lt;/</span><span class="html">h2</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;</span><span class="html">ol</span><span class="kwrd">&gt;</span>
    <span class="kwrd">&lt;</span><span class="html">li</span> <span class="attr">each</span><span class="kwrd">=&quot;var I in Ideas&quot;</span><span class="kwrd">&gt;</span>
        ${Html.ActionLink(I.Name, MVC.Idea.Details(1))}
    <span class="kwrd">&lt;/</span><span class="html">li</span><span class="kwrd">&gt;</span>
<span class="kwrd">&lt;/</span><span class="html">ol</span><span class="kwrd">&gt;</span></pre>
</blockquote>


*That *looks pretty nice. 