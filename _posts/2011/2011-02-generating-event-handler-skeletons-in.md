---
date: '2011-02-08T11:15:00.001-05:00'
description: ''
published: true
slug: 2011-02-generating-event-handler-skeletons-in
categories:
- Work
- Code
- Technology
time_to_read: 5
title: Generating Event Handler Skeletons in .NET
---


Here’s a trick I wish I’d learned much earlier in my career as a .NET developer. You can generate event handler skeletons via the dropdown list above the code window:

![image%5B38%5D.png](image%5B38%5D.png)

I don’t know what those dropdowns are called—let’s go with “object” on the left, and “event” on the right. In this case I want to implement the “Item Data Bound” event of a DataGrid object (I don’t much like webforms but this legacy component is full of them so don’t judge me). First choose the grid from the object dropdown:

![image%5B44%5D.png](image%5B44%5D.png)

And the editor inserts this lovely snippet (or takes you to it if it already exists):

![image%5B46%5D.png](image%5B46%5D.png)

This works with varying success outside of webforms, too.

Let’s do one more related tip I’m sure you already know about: generating skeletons for classes you inherit or interfaces you implement. Of course you get Intellisense:  

![image%5B50%5D.png](image%5B50%5D.png)

But after you choose the thing you want to inherit or implement, click on that little blue line (it’s easy to miss):  

![image%5B16%5D.png](image%5B16%5D.png)

And you’ll get a handy generator option:  

![image%5B19%5D.png](image%5B19%5D.png)

Which when activated, inserts a nice skeleton for you to fill in:  

![image%5B22%5D.png](image%5B22%5D.png)

By the way, the keyboard shortcut for activating that menu is <kbd>c</kbd>-<kbd>.</kbd>.

Happy coding!