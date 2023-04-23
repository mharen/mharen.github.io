---
layout: post
date: '2010-02-27T12:02:00.001-05:00'
categories:
- work
- technology
title: 'Word Document Automation with .NET 4: Update All Fields'
---




I’ve been told that these programming posts are not interesting or funny. For those that have no interest in programming, I offer the following joke:
<blockquote> 

I hope the next time I move I get a real easy phone number, something that's real easy to remember. Something like two two two two two two two two. I would say "Sweet." And then people would say, "Mitch, how do I get a hold of you?" I'd say, "Just press two for a while. And when I answer, you will know you have pressed two enough." ([more classics](http://en.wikiquote.org/wiki/Mitch_Hedberg) from the late and invariably hilarious Mitch Hedberg)
</blockquote>

Now would be a good time for you to stop reading.   <hr />

On with the show! This handy method will attempt to update all the fields in the document passed to it:  
```cs
/// <summary>
/// Update damn near every field in the document
/// </summary>
/// <param name="document">The document in dire need of updating</param>
private static void UpdateAllFields(Document document)
{
    // there must be a better way than searching everything I can thing of
    // please let me know if you find one!

    foreach (Range R in document.StoryRanges)
    {
        R.Fields.Update();
    }

    foreach (TableOfContents T in document.TablesOfContents)
    {
        T.Update();
    }

    foreach (Section S in document.Sections)
    {
        foreach (HeaderFooter F in S.Footers)
        {
            F.Range.Select();
            F.Range.Fields.Update();
        }
        foreach (HeaderFooter H in S.Headers)
        {
            H.Range.Select();
            H.Range.Fields.Update();
        }
    }

    foreach (Shape S in document.Shapes)
    {
        if (S.Type == Microsoft.Office.Core.MsoShapeType.msoTextBox &amp;&amp; S.TextFrame.HasText > 0)
        {
            S.TextFrame.TextRange.Fields.Update();
        }
    }

    foreach (Range S in document.Sentences)
    {
        if (S.ShapeRange.Count > 0)
        {
            foreach (Shape Shape in S.ShapeRange)
            {
                if (Shape.Type == Microsoft.Office.Core.MsoShapeType.msoTextBox)
                {
                    Shape.TextFrame.TextRange.Fields.Update();
                }
            }
        }
    }

    document.Application.ActiveWindow.View.Type = WdViewType.wdMasterView;
    document.Application.ActiveWindow.View.Type = WdViewType.wdPrintPreview;
}
```

<span class="Apple-style-span"><span class="Apple-style-span" style="text-align: left; line-height: 16px; font-family: verdana, arial, sans-serif; color: rgb(51,51,51); font-size: 13px;">
  

To use this, add the following references to your project:

    <ul>
      <li>Microsoft.Office.Interop.Word, v12</li>

      <li>Office, v12</li>
    </ul>
  </span></span>


It makes me cry a little to brute force every container I can think of this way. Surely there’s a better way. Maybe I could just traverse the documents DOM an update anything that looks like a field castable to a Field…I’ll think about that. Until then, this seems to work…

---

## 1 comments captured from [original post](https://blog.wassupy.com/2010/02/word-document-automation-with-net-4_27.html) on Blogger

**Michael Haren said on 2010-02-27**

Note: the finally{} cleanup code ought be enhanced with a call to something [like this](http://stackoverflow.com/questions/1907270/c-outlook-2007-com-interop-application-does-not-exit" rel="nofollow):

    private static void DisposeApp(Application WordApp)

    {

        if (WordApp != null)

        {

            if (WordApp.ActiveDocument != null)

            {

                (WordApp.ActiveDocument as _Document).Close();

            }

            (WordApp as _Application).Quit();

            System.Runtime.InteropServices.Marshal.FinalReleaseComObject(WordApp);

        }

    }

