---
layout: post
date: '2010-03-01T14:03:00.001-05:00'
categories:
- work
- technology
title: 'Word Document Automation with .NET 4: Attach Styles From a Template'
---


I’ve been working with document generation a [bit](../2010/2010-02-word-document-automation-with-net-4.html) [lately](../2010/2010-02-word-document-automation-with-net-4_27.html). The latest hurdle I’ve had to jump is related to styles. I’ve found that the technique I’m using to merge styles is nice and easy but has one undesired feature: each source doc brings its own styles with it, overwriting any existing styles that have already been imported as it goes. This is nice in a lot of ways, but not what I want at the moment.

After a lot of trial and error, I’ve come up with a super simple way to apply a single set of styles to the finished document:  <pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">void</span> StyleDocument(Document document, <span class="kwrd">string</span> templateFile)
{
    document.CopyStylesFromTemplate(templateFile);
}</pre>


That’s it! This will take all the styles from the given .dotx or .docx file and apply them to the given document object. If you only have a file path of the document that needs to be styled, you’ll need to open/close it, too, with this overload (in addition to the above method):

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">static</span> <span class="kwrd">void</span> StyleDocument(<span class="kwrd">string</span> file, <span class="kwrd">string</span> templateFile)
{
    Application WordApp = <span class="kwrd">null</span>;

    <span class="kwrd">try</span>
    {
        WordApp = <span class="kwrd">new</span> Application();
        var Document = WordApp.Documents.Open(file);
        StyleDocument(Document, templateFile);
    }
    <span class="kwrd">finally</span>
    {
        DisposeApp(WordApp);
    }
}</pre>


Where <code class="csharpcode">DisposeApp(…)</code> is just a helper to cleanup my mess:

<pre class="csharpcode"><span class="kwrd">private</span> <span class="kwrd">static</span> <span class="kwrd">void</span> DisposeApp(Application WordApp)
{
    <span class="kwrd">if</span> (WordApp != <span class="kwrd">null</span>)
    {
        <span class="kwrd">foreach</span> (var Doc <span class="kwrd">in</span> WordApp.Documents)
        {
            (Doc <span class="kwrd">as</span> _Document).Close();
        }
        (WordApp <span class="kwrd">as</span> _Application).Quit();

        System.Runtime.InteropServices.Marshal.FinalReleaseComObject(WordApp);
    }
}</pre>


This technique is far, far nicer than working with the styles manually.