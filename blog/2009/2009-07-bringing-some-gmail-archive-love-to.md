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

<p>I love Gmail's archive feature. It frees me from organizing my mail by depending on search instead. If you’re unfamiliar, here’s the Google approach to mail:</p>  <ol>   <li>New mail shows up in your inbox</li>    <li>When you’re done with an email, you “archive” it, which basically moves it into a giant folder</li>    <li>When you need to find an old message again, you <em>search</em> for it by keyword, sender, date, etc. You <em>do not </em>organize mail by folder (though you can if you must)</li> </ol>  <p>I’ve been using a similar approach in Outlook at work for a long time. Encouraged by a <a href="http://getitdone.quickanddirtytips.com/inbox-zero.aspx">GTD idea</a> (cool podcast, btw), I created this structure:</p>  <p align="center"><img alt="image" border="0" height="76" src="http://lh6.ggpht.com/_IKD9WtY5kxU/SliS0C3tpWI/AAAAAAAAAVg/v2s6xqDnGrw/image%5B55%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="159" /> </p>  <p></p>  <p>This mimics the Gmail approach pretty well and means that I can often get to a zero-message inbox. I use a slightly more complex approach at work by adding two extra archive folders (Later and Waiting). These hold mail that is not yet actionable.</p>  <p>This process has worked wonders for me—really! So now my problem is this: I’m in the office after some paternity leave and I have hundreds of messages to run through. This leaves me missing gmail’s shortcut key for archiving. With a quick press of the “y” key, I can archive messages in gmail and I wanted that in Outlook, too! Here’s how I did it.</p>  <p>First, create a certificate so you can sign the macro we’re about to create. Do this by following <a href="http://grok.lsu.edu/Article.aspx?articleId=593">these instructions</a> (this is my abbreviated version):</p>  <blockquote>   <p>Open <em>Start &gt; All Programs &gt; Microsoft Office &gt; MS Office Tools &gt; Digital Certificate for VBA Projects</em></p> </blockquote>  <p>Enter a name for the certificate and click <em>OK</em>:</p>  <p align="center"><img alt="image" border="0" height="338" src="http://lh3.ggpht.com/_IKD9WtY5kxU/SliS0aHxwDI/AAAAAAAAAUc/xogFgka9Nb0/image%5B46%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="422" />&#160;</p>  <p>Next, open up Outlook and go to <em>Tools &gt; Macro &gt; Visual Basic Editor</em>:</p>  <p align="center">&#160;<img alt="image" border="0" height="427" src="http://lh4.ggpht.com/_IKD9WtY5kxU/SliTFPpv7yI/AAAAAAAAAUg/GINrb8NDKQ4/image%5B47%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="659" /> </p>  <p>Next, enter this code under <em>Project1 &gt; Microsoft Office Outlook &gt; ThisOutlookSession</em> (thanks to <a href="http://richarddingwall.name/2007/11/15/adding-gmails-archive-button-to-microsoft-outlook/">Richard</a> for this code!):</p>  <blockquote>   <pre class="csharpcode"><span class="kwrd">Option</span> Explicit

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

<p align="center"><a href="http://lh6.ggpht.com/_IKD9WtY5kxU/SliTTmcD1lI/AAAAAAAAAUk/NjgMxdFrFEM/s1600-h/image%5B49%5D.png"><img alt="image" border="0" height="438" src="http://lh5.ggpht.com/_IKD9WtY5kxU/SliTFltKQiI/AAAAAAAAAUs/bC0LH0NsAkE/image_thumb%5B22%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="600" /></a> </p>

<p></p>

<p>Create the folder in red (<em>1_Archive</em>) under your inbox or change the code to refer to your folder of choice.</p>

<p>Sign the certificate by choosing <em>Tools &gt; Digital Signature &gt; Choose</em>:</p>

<p align="center"><img alt="image" border="0" height="228" src="http://lh5.ggpht.com/_IKD9WtY5kxU/SliTGET8mPI/AAAAAAAAAUw/Dp1sh3121do/image%5B50%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="577" /> </p>

<p align="center"><img alt="image" border="0" height="453" src="http://lh6.ggpht.com/_IKD9WtY5kxU/SliTGTisOHI/AAAAAAAAAU4/6GTo60LY1f8/image%5B51%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="473" /> </p>

<p>Save and close the VBA window. Restart Outlook (choose <em>Yes </em>to save anything if prompted).</p>

<p>Next, let’s create a button for our new Macro with <em>Tools &gt; Customize</em>:</p>

<p align="center"><img alt="image" border="0" height="420" src="http://lh6.ggpht.com/_IKD9WtY5kxU/SliTG5airfI/AAAAAAAAAU8/DXkl9MvFe-M/image%5B52%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="446" /> </p>

<p>Choose the <em>Macros </em>category and drag the Archive macro to your toolbar:</p>

<p align="center"><img alt="image" border="0" height="452" src="http://lh6.ggpht.com/_IKD9WtY5kxU/SliTHQ2UtPI/AAAAAAAAAVI/VdwHVAO-A8A/image%5B53%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="463" /> </p>

<p>Then, with the customize window still open, right click on the button you just created and give it a better name and set it to <em>Text Only</em>:</p>

<p align="center"><img alt="image" border="0" height="452" src="http://lh3.ggpht.com/_IKD9WtY5kxU/SliTH1y7qTI/AAAAAAAAAVM/cqU60CVZFP0/image%5B54%5D.png?imgmax=800" style="border-bottom: 0px; border-left: 0px; display: inline; border-top: 0px; border-right: 0px;" title="image" width="493" /> </p>

<p>I named mine <em>&amp;Quick Archive</em>. The ampersand sets the hotkey to the letter that follows it (denoted by the underlined letter in the toolbar). In this case, it will be <em>Alt-Q</em>.</p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p></p>

<p>Now all I need to do is click this button or press <em>Alt-Q</em> and whatever messages are highlighted will be archived. The first time you do it, you should get a warning about using macros. I suggest you instruct outlook to always trust macros signed by you to avoid the nagging prompts in the future. You could also skip the whole signing step and enable unsigned macros…but I wouldn’t.</p>

<p>All set!</p>