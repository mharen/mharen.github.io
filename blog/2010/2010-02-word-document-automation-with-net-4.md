---
date: '2010-02-27T11:31:00.001-05:00'
description: ''
published: true
slug: 2010-02-word-document-automation-with-net-4
tags:
- http://schemas.google.com/blogger/2008/kind#post
- Work
- Technology
- legacy-blogger
time_to_read: 5
title: Word Document Automation with .NET 4
---


I’ve been toying around with some document generation lately and thought I’d share a bit of what I’ve learned. Here’s a method for extracting a list of custom properties in use in the document:  <pre class="csharpcode"><span class="rem">/// &lt;summary&gt;</span>
<span class="rem">/// Retrieves custom properties from a given Word document</span>
<span class="rem">/// &lt;/summary&gt;</span>
<span class="rem">/// &lt;param name=&quot;file&quot;&gt;Full path to the Word document&lt;/param&gt;</span>
<span class="rem">/// &lt;returns&gt;A dictionary representation of the document's custom properties&lt;/returns&gt;</span>
<span class="kwrd">public</span> <span class="kwrd">static</span> Dictionary&lt;<span class="kwrd">string</span>, <span class="kwrd">string</span>&gt; GetDocProperties(<span class="kwrd">string</span> file)
{
    Application WordApp = <span class="kwrd">null</span>;
    var DocProperties = <span class="kwrd">new</span> Dictionary&lt;<span class="kwrd">string</span>, <span class="kwrd">string</span>&gt;();

    <span class="kwrd">try</span>
    {
        <span class="rem">// spin up a new WinWord.exe</span>
        WordApp = <span class="kwrd">new</span> Application();

        <span class="rem">// open the specified document</span>
        WordApp.Documents.Open(file);

        <span class="rem">// grab the custom properties container</span>
        dynamic CustomProps = WordApp.ActiveDocument.CustomDocumentProperties;

        <span class="rem">// extract each property</span>
        <span class="kwrd">foreach</span> (var Prop <span class="kwrd">in</span> CustomProps)
        {
            DocProperties.Add(Prop.Name, Prop.Value);
        }
    }
    <span class="kwrd">finally</span>
    {
        <span class="rem">// close doc and shutdown word</span>
        <span class="kwrd">if</span> (WordApp != <span class="kwrd">null</span>)
        {
            <span class="kwrd">if</span> (WordApp.ActiveDocument != <span class="kwrd">null</span>)
            {
                WordApp.ActiveDocument.Close();
            }
            WordApp.Quit();
        }
    }

    <span class="rem">// return properties</span>
    <span class="kwrd">return</span> DocProperties;
}</pre>


This is so much easier and cleaner with .NET4’s new dynamic capabilities and how nice it plays with COM. To use this, add the following references to your project:

<ul>
  <li>Microsoft.Office.Interop.Word, v12 </li>

  <li>Office, v12 </li>
</ul>