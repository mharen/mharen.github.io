---
date: '2010-10-16T15:12:00.001-04:00'
description: ''
published: true
slug: 2010-10-restyling-website-with-user-styles-in
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Sarah
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Restyling A Website With User Styles in Chrome
---

<p>Designing a new theme for a website can be a pretty big undertaking if the process isn’t already in place. That is, unless a staging area—a test site—already exists that you can tinker with, building a new theme for the live site requires a trick: user styles.</p>
<p>User styles are small bits of CSS—the code that describes what a webpage looks like—that live in your browser, not actually on the webpage. All I need to do is add my CSS changes so only <em>my</em> view of the site is affected. I can do this for <em>any</em> site, too, not just sites I control.</p>
<p>There is of course one major downside to this approach: I can’t change the site’s structure—its HTML. Hopefully, though, if I’ve implemented the HTML properly, with a good <a href="http://en.wikipedia.org/wiki/HTML#Semantic_HTML">semantic design</a>, the styling should be straight forward without HTML changes.</p>
<p>Today, I’ll walk you through an actual process of this as I restyle Sarah’s blog.</p>  <h4>Before</h4>
<p>Here’s what the blog looks like today:</p>
<p>![image%5B5%5D.png](image%5B5%5D.png)</p>
<p>Today’s refresh will be pretty light. I’ll update the graphics and colors but leave the layout almost entirely alone. We’re repainting—not moving any walls or furniture.</p>
<p>My browser of choice is Google Chrome, because it’s friggin’ amazing as you will soon discover.</p>  <h4>Background Image</h4>
<p>I’m going for a fall theme so I did an image search for leaves. I want a repeating pattern for the background image so I added a size constraint, guessing that whoever made a repeating leaves pattern would do so at a standard dimension of 512px square (or some other multiple of 128). Success:</p>
<p>![image%5B9%5D.png](image%5B9%5D.png)</p>
<p>So then I just need to know what element of the existing site to apply this to. It is probably the body tag but let’s check. In Chrome, I bring up the site and hit Control-Shift-I to open up the debugger. If you work on websites and have not used this before, you are welcome. This thing will change your life.</p>
<p>![image%5B18%5D.png](image%5B18%5D.png)</p>
<p>Here we see the structure of the page on the left and the selected element’s styles on the right. And there we see the background-image property. That’s what I will override in my user style via the Chrome Extension <a href="https://chrome.google.com/extensions/detail/fjnbnpbmkenffdnngjfgmeleoegfcffe">Stylish</a>:</p>
<p>![image%5B17%5D.png](image%5B17%5D.png)</p>
<p>Once I hit save, the other window is immediately updated (no refresh required):</p>
<p>![image%5B23%5D.png](image%5B23%5D.png)</p>  <h4>Masthead Flowers</h4>
<p>Next, the two flowers on each side of the masthead. I need to identify them in code so I can refer to them in my user style. Do this by clicking the magnifying glass and then the flower to tell Chrome to show me the code for the flower:</p>
<p>![image%5B28%5D.png](image%5B28%5D.png)</p>
<p>Let’s override that CSS, and the second flower as well:</p>
<p>![image%5B45%5D.png](image%5B45%5D.png)</p>    
<p>Pow:</p>
<p>![image%5B50%5D.png](image%5B50%5D.png)</p>  <h4>Colors</h4>
<p>I’ll tweak the header color (purple) and image border color (pink) next.</p>
<p>![image%5B54%5D.png](image%5B54%5D.png)</p>    
<p>Bam:</p>
<p>![image%5B59%5D.png](image%5B59%5D.png)</p>  <h4>Navigation Bar</h4>
<p>We’re almost done. Next I’ll replace those tiny flowers across the top of the window (I realize container is spelled wrong, but it’s coded so I can’t fix it now).</p>
<p>![image%5B68%5D.png](image%5B68%5D.png)</p>
<p>Result:</p>
<p>![image%5B64%5D.png](image%5B64%5D.png)</p>    <h4>Masthead</h4>
<p>The final piece is the actual site logo—the baby face. Sarah might put her own together, but until then I’ll use this:</p>
<p>![image%5B73%5D.png](image%5B73%5D.png)</p>
<p>That is far, <em>far</em> too busy for my taste, but I think Sarah will like it. If I find some time, I might add a soft glow effect around the logo image to help it stand off from the background. To do that efficiently, though, I’ll probably need to update the structure of the page which I don’t want to do right now.</p>
<p>My complete user style (includes many tweaks not captured above):</p>
<blockquote>   <pre class="csharpcode">body { 
  background-image:url(http://lh6.ggpht.com/_IKD9WtY5kxU/TK8ysmokPoI/AAAAAAAABAc/MDUoIh2d0lE/AutumnLeaves2.jpg);
}

div#header-bg {
  background-image:url(http://lh4.ggpht.com/_IKD9WtY5kxU/TK89wWAHSII/AAAAAAAABBE/Fyp4rTBN78w/fall-leaf-left-ds.png);
  width: 243px;
  height: 207px;
  top: 320px;
  left: -170px;
}

a#header-bg2 {
  right: -50px;
}

a#header-bg2 img { 
  background-image:url(http://lh5.ggpht.com/_IKD9WtY5kxU/TK89wgPDDGI/AAAAAAAABBI/jLN3xd0JsBU/fall-leaf-top-ds.png);
  width: 153px;
  height: 182px;
}

a:link, a:active, a:visited, a:hover {
  color: #770602; /* matches leaf */
}

img.bordered, .post img, div.post, .blog-pager, .post-feeds, .comments, div#header2, .nav-details, #buttons-containter { 
  border-color: #770602 
}

div#buttons-containter {
  background-color: #7F462C;
}

#buttons a {
  color: #ddd;
}<br />
.bullet-0, .bullet-1, .bullet-2, .bullet-3, .bullet-4, .bullet-5 { 
  background-image: url(http://lh5.ggpht.com/_IKD9WtY5kxU/TLnlyrgFoXI/AAAAAAAABCU/Mc8UP6ZcIJM/pumpkin.png);
}

div#header2 {
  background-image: url(http://lh4.ggpht.com/_IKD9WtY5kxU/TLnv-tDoWeI/AAAAAAAABCY/3nINZ-3HykQ/Masthead-fall2010.jpg);
  height: 425px;
}</pre>
</blockquote>

<p>Now I wait for a list of changes from the Mrs. and start thinking about some more dramatic changes for the Winter theme to land just after Thanksgiving.</p>

---

## 1 comments captured from [original post](https://blog.wassupy.com/2010/10/restyling-website-with-user-styles-in.html) on Blogger

**Sarah said on 2010-10-16**

Thanks, honey :)  I am already planning the winter theme in my head :D

