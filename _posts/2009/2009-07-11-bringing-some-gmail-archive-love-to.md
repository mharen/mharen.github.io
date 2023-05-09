---
layout: post
date: '2009-07-11T09:26:00.001-04:00'
categories:
- work
- usability
- code
- technology
title: Bringing some Gmail-Archive Love to Outlook
---

I love Gmail's archive feature. It frees me from organizing my mail by depending on search instead. If you’re unfamiliar, here’s the Google approach to mail:  

  1. New mail shows up in your inbox    
  2. When you’re done with an email, you “archive” it, which basically moves it into a giant folder    
  3. When you need to find an old message again, you *search
  4. for it by keyword, sender, date, etc. You *do not* organize mail by folder (though you can if you must)

I’ve been using a similar approach in Outlook at work for a long time. Encouraged by a [GTD idea](http://getitdone.quickanddirtytips.com/inbox-zero.aspx) (cool podcast, btw), I created this structure:  

{% imagesize /assets/2009/outlook-archive-00001.png:img %}

This mimics the Gmail approach pretty well and means that I can often get to a zero-message inbox. I use a slightly more complex approach at work by adding two extra archive folders (Later and Waiting). These hold mail that is not yet actionable.

This process has worked wonders for me—really! So now my problem is this: I’m in the office after some paternity leave and I have hundreds of messages to run through. This leaves me missing gmail’s shortcut key for archiving. With a quick press of the “y” key, I can archive messages in gmail and I wanted that in Outlook, too! Here’s how I did it.

First, create a certificate so you can sign the macro we’re about to create. Do this by following [these instructions](http://grok.lsu.edu/Article.aspx?articleId=593) (this is my abbreviated version):

> Open *Start > All Programs > Microsoft Office > MS Office Tools > Digital Certificate for VBA Projects*

Enter a name for the certificate and click *OK*:  

{% imagesize /assets/2009/outlook-archive-00002.png:img %}

Next, open up Outlook and go to *Tools > Macro > Visual Basic Editor*:  

{% imagesize /assets/2009/outlook-archive-00003.png:img %}

Next, enter this code under *Project1 > Microsoft Office Outlook > ThisOutlookSession* (thanks to [Richard](http://richarddingwall.name/2007/11/15/adding-gmails-archive-button-to-microsoft-outlook/) for this code!):

```vb
Option Explicit

Public Sub ArchiveSelectedItems()
    MoveSelectedItemsToFolder "1_Archive"
End Sub

'http://richarddingwall.name/2007/11/15/adding-gmails-archive-button-to-microsoft-outlook/
Private Sub MoveSelectedItemsToFolder(FolderName As String)
    On Error GoTo ErrorHandler

    Dim Namespace As Outlook.Namespace
    Set Namespace = Application.GetNamespace("MAPI")

    Dim Inbox As Outlook.MAPIFolder
    Set Inbox = Namespace.GetDefaultFolder(olFolderInbox)

    Dim Folder As Outlook.MAPIFolder
    Set Folder = Inbox.Folders(FolderName)

    If Folder Is Nothing Then
        MsgBox "The '" & FolderName & "' folder doesn't exist!", _
            vbOKOnly + vbExclamation, "Invalid Folder"
    End If

    Dim Item As Object
    For Each Item In Application.ActiveExplorer.Selection
        If Item.UnRead Then Item.UnRead = False
        Item.Move Folder
    Next

    Exit Sub

ErrorHandler:
    MsgBox Error(Err)

End Sub
```

{% imagesize /assets/2009/outlook-archive-00004.png:img %}

Create the folder in red (*1_Archive*) under your inbox or change the code to refer to your folder of choice.

Sign the certificate by choosing *Tools > Digital Signature > Choose*:

{% imagesize /assets/2009/outlook-archive-00005.png:img %}

{% imagesize /assets/2009/outlook-archive-00006.png:img %}

Save and close the VBA window. Restart Outlook (choose *Yes* to save anything if prompted).

Next, let’s create a button for our new Macro with *Tools > Customize*:

{% imagesize /assets/2009/outlook-archive-00007.png:img %}

Choose the *Macros* category and drag the Archive macro to your toolbar:

{% imagesize /assets/2009/outlook-archive-00008.png:img %}

Then, with the customize window still open, right click on the button you just created and give it a better name and set it to *Text Only*:

{% imagesize /assets/2009/outlook-archive-00009.png:img %}

I named mine *&Quick Archive*. The ampersand sets the hotkey to the letter that follows it (denoted by the underlined letter in the toolbar). In this case, it will be *Alt-Q*.























Now all I need to do is click this button or press *Alt-Q* and whatever messages are highlighted will be archived. The first time you do it, you should get a warning about using macros. I suggest you instruct outlook to always trust macros signed by you to avoid the nagging prompts in the future. You could also skip the whole signing step and enable unsigned macros...but I wouldn’t.


All set!