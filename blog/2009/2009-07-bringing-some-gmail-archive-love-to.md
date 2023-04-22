---
date: '2009-07-11T09:26:00.001-04:00'
description: ''
published: true
slug: 2009-07-bringing-some-gmail-archive-love-to
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Usability
- Code
- Technology
- legacy-blogger
time_to_read: 5
title: Bringing some Gmail-Archive Love to Outlook
---


I love Gmail's archive feature. It frees me from organizing my mail by depending on search instead. If you’re unfamiliar, here’s the Google approach to mail:  <ol>   <li>New mail shows up in your inbox</li>    <li>When you’re done with an email, you “archive” it, which basically moves it into a giant folder</li>    <li>When you need to find an old message again, you *search* for it by keyword, sender, date, etc. You *do not *organize mail by folder (though you can if you must)</li> </ol>

I’ve been using a similar approach in Outlook at work for a long time. Encouraged by a [GTD idea](http://getitdone.quickanddirtytips.com/inbox-zero.aspx) (cool podcast, btw), I created this structure:  

![image%5B55%5D.png](image%5B55%5D.png) 



This mimics the Gmail approach pretty well and means that I can often get to a zero-message inbox. I use a slightly more complex approach at work by adding two extra archive folders (Later and Waiting). These hold mail that is not yet actionable.

This process has worked wonders for me—really! So now my problem is this: I’m in the office after some paternity leave and I have hundreds of messages to run through. This leaves me missing gmail’s shortcut key for archiving. With a quick press of the “y” key, I can archive messages in gmail and I wanted that in Outlook, too! Here’s how I did it.

First, create a certificate so you can sign the macro we’re about to create. Do this by following [these instructions](http://grok.lsu.edu/Article.aspx?articleId=593) (this is my abbreviated version):
<blockquote> 

Open *Start &gt; All Programs &gt; Microsoft Office &gt; MS Office Tools &gt; Digital Certificate for VBA Projects*
</blockquote>

Enter a name for the certificate and click *OK*:  

![image%5B46%5D.png](image%5B46%5D.png)&#160;

Next, open up Outlook and go to *Tools &gt; Macro &gt; Visual Basic Editor*:  

&#160;![image%5B47%5D.png](image%5B47%5D.png) 

Next, enter this code under *Project1 &gt; Microsoft Office Outlook &gt; ThisOutlookSession* (thanks to [Richard](http://richarddingwall.name/2007/11/15/adding-gmails-archive-button-to-microsoft-outlook/) for this code!):
<blockquote>   <pre class="csharpcode"><span class="kwrd">Option</span> Explicit

<span class="kwrd">Public</span> <span class="kwrd">Sub</span> ArchiveSelectedItems()
    MoveSelectedItemsToFolder <span class="str"><strong><font color="#ff0000">&quot;1_Archive&quot;</font></strong></span>
<span class="kwrd">End</span> <span class="kwrd">Sub</span>

<span class="rem">'http://richarddingwall.name/2007/11/15/adding-gmails-archive-button-to-microsoft-outlook/</span>
<span class="kwrd">Private</span> <span class="kwrd">Sub</span> MoveSelectedItemsToFolder(FolderName <span class="kwrd">As</span> <span class="kwrd">String</span>)
    <span class="kwrd">On</span> <span class="kwrd">Error</span> <span class="kwrd">GoTo</span> ErrorHandler

    <span class="kwrd">Dim</span> <span class="kwrd">Namespace</span> <span class="kwrd">As</span> Outlook.<span class="kwrd">Namespace</span>
    <span class="kwrd">Set</span> <span class="kwrd">Namespace</span> = Application.GetNamespace(<span class="str">&quot;MAPI&quot;</span>)

    <span class="kwrd">Dim</span> Inbox <span class="kwrd">As</span> Outlook.MAPIFolder
    <span class="kwrd">Set</span> Inbox = <span class="kwrd">Namespace</span>.GetDefaultFolder(olFolderInbox)

    <span class="kwrd">Dim</span> Folder <span class="kwrd">As</span> Outlook.MAPIFolder
    <span class="kwrd">Set</span> Folder = Inbox.Folders(FolderName)

    <span class="kwrd">If</span> Folder <span class="kwrd">Is</span> <span class="kwrd">Nothing</span> <span class="kwrd">Then</span>
        MsgBox <span class="str">&quot;The '&quot;</span> &amp; FolderName &amp; <span class="str">&quot;' folder doesn't exist!&quot;</span>, _
            vbOKOnly + vbExclamation, <span class="str">&quot;Invalid Folder&quot;</span>
    <span class="kwrd">End</span> <span class="kwrd">If</span>

    <span class="kwrd">Dim</span> Item <span class="kwrd">As</span> <span class="kwrd">Object</span>
    <span class="kwrd">For</span> <span class="kwrd">Each</span> Item <span class="kwrd">In</span> Application.ActiveExplorer.Selection
        <span class="kwrd">If</span> Item.UnRead <span class="kwrd">Then</span> Item.UnRead = <span class="kwrd">False</span>
        Item.Move Folder
    <span class="kwrd">Next</span>

    <span class="kwrd">Exit</span> <span class="kwrd">Sub</span>

ErrorHandler:
    MsgBox <span class="kwrd">Error</span>(Err)

<span class="kwrd">End</span> <span class="kwrd">Sub</span></pre>
</blockquote>



![image%5B49%5D.png](image%5B49%5D.png)</a> 





Create the folder in red (*1_Archive*) under your inbox or change the code to refer to your folder of choice.


Sign the certificate by choosing *Tools &gt; Digital Signature &gt; Choose*:



![image%5B50%5D.png](image%5B50%5D.png) 



![image%5B51%5D.png](image%5B51%5D.png) 


Save and close the VBA window. Restart Outlook (choose *Yes *to save anything if prompted).


Next, let’s create a button for our new Macro with *Tools &gt; Customize*:



![image%5B52%5D.png](image%5B52%5D.png) 


Choose the *Macros *category and drag the Archive macro to your toolbar:



![image%5B53%5D.png](image%5B53%5D.png) 


Then, with the customize window still open, right click on the button you just created and give it a better name and set it to *Text Only*:



![image%5B54%5D.png](image%5B54%5D.png) 


I named mine *&amp;Quick Archive*. The ampersand sets the hotkey to the letter that follows it (denoted by the underlined letter in the toolbar). In this case, it will be *Alt-Q*.























Now all I need to do is click this button or press *Alt-Q* and whatever messages are highlighted will be archived. The first time you do it, you should get a warning about using macros. I suggest you instruct outlook to always trust macros signed by you to avoid the nagging prompts in the future. You could also skip the whole signing step and enable unsigned macros…but I wouldn’t.


All set!