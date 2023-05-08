---
layout: post
date: '2010-10-20T22:01:00.001-04:00'
categories: technology
title: 'First Look at NuPack: A VS-Integrated Package Management Tool'
---

#### Installation

Couldn’t be easier: 
* [http://nupack.codeplex.com/](http://nupack.codeplex.com/) 
* Download 
* Go  
  
#### First Run

Fire up Visual Studio 2010 and open the Package Manager Console under View > Other Windows > Package Manager Console (or press C-W, C-Z):

{% imagesize /assets/2010/nupack-23.png:img %}

From here you get a nice, friendly command line window:

```sh
PM>
```

This is a PowerShell console so the standard pattern of commands is available with the “-package” suffix. For example, to see what’s available, try List-Package:

```sh
PM> List-Package

Id                Version  Description 
--                -------  ----------- 
Adam.JSGenerator  1.1.0.0  Adam.JSGenerator helps producing snippets...
Agatha-rrsl       1.2.0    Request/Response Service Layer for .NET 
AntiXSS           4.0.1    AntiXSS is an encoding library which uses...
Antlr             3.1.1    ANother Tool for Language Recognition...
Antlr             3.1.3    ANother Tool for Language Recognition... 

PM> 
```

Nice! OK, Let’s open up a new ASP.NET MVC App:


{% imagesize /assets/2010/nupack-22.png:img %}

And throw together a simple MVC app:

Model:

```cs
namespace TechTalk7.Models
{
    public class Idea
    {
        public int ID { get; set; }
        public string Name { get; set; }
    }
}
```

Controller:
  
```cs
namespace TechTalk7.Controllers
{
    public partial class IdeaController : Controller
    {
        private static List<Idea> Ideas = new List<Idea>();

        public IdeaController()
        {
            Ideas = new List<Idea>() { 
                new Idea() { ID = 1, Name = "Brush your teeth" }, 
                new Idea() { ID = 2, Name = "Study hard" } 
            };
        }

        public virtual ActionResult Index()
        {
            return View(Ideas);
        }
    }
}
```

View:
  
```cs
<h2>Index</h2>
<ol>
<% foreach (TechTalk7.Models.Idea I in Model)
    { %>

    <li>
    <!--old way, without T4
    <%=Html.ActionLink(I.Name, "Details", new { ID = I.ID }) %> -->
    </li>

<%} %>
</ol>
```

Output:

{% imagesize /assets/2010/nupack-26.png:img %}


It works! Now let’s improve that view code by trying out that fancy [T4MVC](http://mvccontrib.codeplex.com/wikipage?title=T4MVC) stuff I’ve [heard](http://channel9.msdn.com/blogs/jongalloway/jon-takes-five-with-david-ebbo-on-t4mvc) so much about:

```
PM> Add-Package t4mvc
Successfully added 'T4MVC 2.6.30' to TechTalk7

PM>
```

That was easy. But what just happened? It looks like some files were added:

{% imagesize /assets/2010/nupack-13.png:img %}

Sweet! Now I have T4MVC all ready to go and can do neat things like this:

```cs
<ol>
<% foreach (TechTalk7.Models.Idea I in Model) { %>
    <li>
        <!-- *old way*, without T4-->
        <%=Html.ActionLink(I.Name, "Details", new { ID = I.ID }) %>
        <!--new way, *with* T4-->
        <%=Html.ActionLink(I.Name, MVC.Idea.Details(1)) %>
    </li>
<%} %>
</ol>
```

Better. No more typo-prone strings, clunky object initializers, and it’s even a little shorter.

Soon I’ll be checking out the Spark View Engine, too. With that, my code above could be replaced with something like this:

```cs
<viewdata Ideas="List[[TechTalk7.Models.Idea]]"/>
<h2>Index</h2>
<ol>
    <li each="var I in Ideas">
        ${Html.ActionLink(I.Name, MVC.Idea.Details(1))}
    </li>
</ol>
```

*That* looks pretty nice. 