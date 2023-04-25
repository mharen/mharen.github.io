---
layout: post
date: '2010-03-01T14:03:00.001-05:00'
categories:
- work
- technology
title: 'Word Document Automation with .NET 4: Attach Styles From a Template'
---


I’ve been working with document generation a [bit](../../2010/02/word-document-automation-with-net-4.html) [lately](../../2010/02/word-document-automation-with-net-4_27.html). The latest hurdle I’ve had to jump is related to styles. I’ve found that the technique I’m using to merge styles is nice and easy but has one undesired feature: each source doc brings its own styles with it, overwriting any existing styles that have already been imported as it goes. This is nice in a lot of ways, but not what I want at the moment.

After a lot of trial and error, I’ve come up with a super simple way to apply a single set of styles to the finished document:  
```cs
public static void StyleDocument(Document document, string templateFile)
{
    document.CopyStylesFromTemplate(templateFile);
}
```
 
That’s it! This will take all the styles from the given .dotx or .docx file and apply them to the given document object. If you only have a file path of the document that needs to be styled, you’ll need to open/close it, too, with this overload (in addition to the above method):


```cs
public static void StyleDocument(string file, string templateFile)
{
    Application WordApp = null;

    try
    {
        WordApp = new Application();
        var Document = WordApp.Documents.Open(file);
        StyleDocument(Document, templateFile);
    }
    finally
    {
        DisposeApp(WordApp);
    }
}
```
 
Where <code class="csharpcode">DisposeApp(...)</code> is just a helper to cleanup my mess:


```cs
private static void DisposeApp(Application WordApp)
{
    if (WordApp != null)
    {
        foreach (var Doc in WordApp.Documents)
        {
            (Doc as _Document).Close();
        }
        (WordApp as _Application).Quit();

        System.Runtime.InteropServices.Marshal.FinalReleaseComObject(WordApp);
    }
}
```
 
This technique is far, far nicer than working with the styles manually.