---
layout: post
date: '2011-02-08T11:15:00.001-05:00'
categories:
- work
- code
- technology
title: Generating Event Handler Skeletons in .NET
---

Here’s a trick I wish I’d learned much earlier in my career as a .NET developer. You can generate event handler skeletons via the dropdown list above the code window:

![image-event-38.png](/assets/2011/image-event-38.png)

I don’t know what those dropdowns are called—let’s go with “object” on the left, and “event” on the right. In this case I want to implement the “Item Data Bound” event of a DataGrid object (I don’t much like webforms but this legacy component is full of them so don’t judge me). First choose the grid from the object dropdown:

![image-event-44.png](/assets/2011/image-event-44.png)

And the editor inserts this lovely snippet (or takes you to it if it already exists):

![image-event-46.png](/assets/2011/image-event-46.png)

This works with varying success outside of webforms, too.

Let’s do one more related tip I’m sure you already know about: generating skeletons for classes you inherit or interfaces you implement. Of course you get Intellisense:  

![image-event-50.png](/assets/2011/image-event-50.png)

But after you choose the thing you want to inherit or implement, click on that little blue line (it’s easy to miss):  

![image-event-16.png](/assets/2011/image-event-16.png)

And you’ll get a handy generator option:  

![image-event-19.png](/assets/2011/image-event-19.png)

Which when activated, inserts a nice skeleton for you to fill in:  

![image-event-22.png](/assets/2011/image-event-22.png)

By the way, the keyboard shortcut for activating that menu is `ctrl-.`.

Happy coding!