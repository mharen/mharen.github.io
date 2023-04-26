---
layout: post
date: '2010-10-22T23:50:00.001-04:00'
categories:
- usability
- code
- technology
title: Building a Prettier Search Box
---


Note: if you’re reading this off-site (feed reader, facebook, etc.) and it looks funny, click through for a better view.

Let's take a quick look at a typical search box:
<blockquote> 

<input /><input type="submit" />
</blockquote>

It's boring, plain, and takes up a lot of space. But, the code is about as simple as it gets:
<blockquote>   
```cs
<input <span class="kwrd">/>

<</span>input type="submit" <span class="kwrd">/>

</span>
```

</blockquote>


We can improve things a great deal by adding a shiny graphic:

<blockquote>


<input /><input src="http://lh4.ggpht.com/_IKD9WtY5kxU/TMJXvFRpXzI/AAAAAAAABG4/DU79z1bP4WU/search.gif" type="image" />
</blockquote>


That's most easily accomplished by changing the input type from "submit" to "image" like so (this could be accomplished in CSS with a bit [more effort](http://stackoverflow.com/q/195632/29)): 

<blockquote>
  
```cs
<input <span class="kwrd">/>

<</span>input src="search.gif" type="image" />
```

</blockquote>


Now we're talking. Let's go a little further:

<blockquote>


<input class="post-example-input" /><input class="post-example-go" src="http://www.bing.com/siteowner/s/siteowner/Spyglass_16x16.gif" type="image" />
</blockquote>


Here we've overlaid the image with the box for a very clean effect. This uses the same HTML (I just added classes) but adds just a teenie bit of CSS:

<blockquote>
  
```cs
/* overlay search button on the actual box */
input.search-button { position:relative; left: -20px; top:1px } 

/* pad out the input so a user's search won't go under the search button */
input.search-box { padding-right:20px; }
```

</blockquote>


Clean and simple. 


It has one minor drawback in that it doesn't support CSS sprites. If you want that, you'll need to use one of the `background-image` tricks at the [link](http://stackoverflow.com/q/195632/29) I mentioned earlier.


Of course once Google's Instant Search sweeps the web this will all be a cow's opinion: moo.