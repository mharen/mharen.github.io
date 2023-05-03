---
layout: post
date: '2010-02-27T11:31:00.001-05:00'
categories:
- work
- technology
title: Word Document Automation with .NET 4
---

I’ve been toying around with some document generation lately and thought I’d share a bit of what I’ve learned. Here’s a method for extracting a list of custom properties in use in the document:  

```cs
/// <summary>
/// Retrieves custom properties from a given Word document
/// </summary>
/// <param name="file">Full path to the Word document</param>
/// <returns>A dictionary representation of the document's custom properties</returns>
public static Dictionary<string, string> GetDocProperties(string file)
{
    Application WordApp = null;
    var DocProperties = new Dictionary<string, string>();

    try
    {
        // spin up a new WinWord.exe
        WordApp = new Application();

        // open the specified document
        WordApp.Documents.Open(file);

        // grab the custom properties container
        dynamic CustomProps = WordApp.ActiveDocument.CustomDocumentProperties;

        // extract each property
        foreach (var Prop in CustomProps)
        {
            DocProperties.Add(Prop.Name, Prop.Value);
        }
    }
    finally
    {
        // close doc and shutdown word
        if (WordApp != null)
        {
            if (WordApp.ActiveDocument != null)
            {
                WordApp.ActiveDocument.Close();
            }
            WordApp.Quit();
        }
    }

    // return properties
    return DocProperties;
}
```
 
This is so much easier and cleaner with .NET4’s new dynamic capabilities and how nice it plays with COM. To use this, add the following references to your project:

  * Microsoft.Office.Interop.Word, v12 
  * Office, v12 

