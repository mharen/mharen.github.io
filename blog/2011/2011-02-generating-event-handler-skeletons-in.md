---
date: '2011-02-08T11:15:00.001-05:00'
description: ''
published: true
slug: 2011-02-generating-event-handler-skeletons-in
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Generating Event Handler Skeletons in .NET
---

<p>Here’s a trick I wish I’d learned much earlier in my career as a .NET developer. You can generate event handler skeletons via the dropdown list above the code window:</p>
<p><img alt="image" height="324" src="http://lh6.ggpht.com/_IKD9WtY5kxU/TVFr_iFmdGI/AAAAAAAABa8/sw3V-t2ueVc/image%5B38%5D.png" style="margin: 3px auto; display: block; float: none;" title="image" width="696" /></p>
<p>I don’t know what those dropdowns are called—let’s go with “object” on the left, and “event” on the right. In this case I want to implement the “Item Data Bound” event of a DataGrid object (I don’t much like webforms but this legacy component is full of them so don’t judge me). First choose the grid from the object dropdown:</p>
<p><img alt="image" height="334" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TVFsAPhn_LI/AAAAAAAABbA/zf7flpDDuXM/image%5B44%5D.png" style="margin: 3px auto; display: block; float: none;" title="image" width="680" /></p>
<p>And the editor inserts this lovely snippet (or takes you to it if it already exists):</p>
<p><img alt="image" height="425" src="http://lh4.ggpht.com/_IKD9WtY5kxU/TVFsAkYwu7I/AAAAAAAABbE/AJ5Px25OGkA/image%5B46%5D.png" style="margin: 3px auto; display: block; float: none;" title="image" width="690" /></p>
<p>This works with varying success outside of webforms, too.</p>
<p>Let’s do one more related tip I’m sure you already know about: generating skeletons for classes you inherit or interfaces you implement. Of course you get Intellisense:</p>  <p align="center"><img alt="image" height="282" src="http://lh6.ggpht.com/_IKD9WtY5kxU/TVFsA1rdqaI/AAAAAAAABbI/rhau-v90Ue4/image%5B50%5D.png" style="margin: 3px auto; display: block; float: none;" title="image" width="565" /></p>
<p>But after you choose the thing you want to inherit or implement, click on that little blue line (it’s easy to miss):</p>  <p align="center"><img alt="image" height="88" src="http://lh5.ggpht.com/_IKD9WtY5kxU/TVFsBEIrSGI/AAAAAAAABbM/8Z1u7CaiwcA/image%5B16%5D.png" style="margin: 3px auto; display: block; float: none;" title="image" width="446" /></p>
<p>And you’ll get a handy generator option:</p>  <p align="center"><img alt="image" height="109" src="http://lh6.ggpht.com/_IKD9WtY5kxU/TVFsB1uh5LI/AAAAAAAABbQ/GRV7vNVx1qk/image%5B19%5D.png" style="margin: 3px auto; display: block; float: none;" title="image" width="683" /></p>
<p>Which when activated, inserts a nice skeleton for you to fill in:</p>  <p align="center"><img alt="image" height="278" src="http://lh3.ggpht.com/_IKD9WtY5kxU/TVFsBx9ukoI/AAAAAAAABbU/Hd47GfVfWtI/image%5B22%5D.png" style="margin: 3px auto; display: block; float: none;" title="image" width="551" /></p>
<p>By the way, the keyboard shortcut for activating that menu is <kbd>c</kbd>-<kbd>.</kbd>.</p>
<p>Happy coding!</p>