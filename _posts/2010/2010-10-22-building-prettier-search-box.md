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

<input /><input type="submit" />

It's boring, plain, and takes up a lot of space. But, the code is about as simple as it gets:

```html
<input />
<input type="submit" />
```

We can improve things a great deal by adding a shiny graphic:

> <input /><input src="/assets/2010/search-1.gif" type="image" />

That's most easily accomplished by changing the input type from "submit" to "image" like so (this could be accomplished in CSS with a bit [more effort](http://stackoverflow.com/q/195632/29)): 

```html
<input />
<input src="/assets/2010/search-1.gif" type="image" />
```

Now we're talking. Let's go a little further:

> <input style="padding-right: 20px" />
> <input style="position:relative; left: -20px; top:1px" src="/assets/2010/search-2.gif" type="image" />

Here we've overlaid the image with the box for a very clean effect. This uses the same HTML (I just added classes) but adds just a teenie bit of CSS:

```css
/* overlay search button on the actual box */
input.search-button { position:relative; left: -20px; top:1px; } 

/* pad out the input so a user's search won't go under the search button */
input.search-box { padding-right:20px; }
```

Clean and simple. 

It has one minor drawback in that it doesn't support CSS sprites. If you want that, you'll need to use one of the `background-image` tricks at the [link](http://stackoverflow.com/q/195632/29) I mentioned earlier.

Of course once Google's Instant Search sweeps the web this will all be a cow's opinion: moo.