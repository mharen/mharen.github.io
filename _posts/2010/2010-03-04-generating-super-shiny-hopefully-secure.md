---
layout: post
date: '2010-03-04T23:06:00.001-05:00'
categories:
- code
- technology
title: Generating Super Shiny, Hopefully Secure Tokens
---

I’ve been told that these programming posts are not interesting or funny. For those that have no interest in programming, I offer the following joke:

> “My friend had a burrito. The next day he said, ‘That burrito did not agree with me.’ I was like, ‘Was the disagreement over whether or not you’d have diarrhea? Let me guess who won.’” 
> 
> – [Demetri Martin](http://www.demetrimartin.com/) ([via](http://captainpinhead.wordpress.com/2006/10/01/demetri-martin-quotes/))

Now would be a good time for you to stop reading.

***

I was working on a little security related code today which required the generation of unique and random tokens. I’m always nervous working with crypto because it’s so easy to fail. 

But here I am, ready to fail.

So like I said, I need to create a bunch of tokens—blocks of text or numbers. They can’t be easily guessed and need to be unique. Let’s see if I can’t screw this up.

```cs
/// <summary>
/// Generate a decently long string o random characters, suitable for tokens
/// </summary>
/// <returns>a string of gobbledygook</returns>
public static string GenerateKey()
{
    var RandomBytes = new byte[
        6 * 10 // use a multiple of 6 to get a full base64 output http://en.wikipedia.org/wiki/Base64">http://en.wikipedia.org/wiki/Base64
        - 16 // compensate for the 16-byte guid we're going to add in 
        ];

    // fill the buffer with garbage (this is threadsafe)
    BetterRandom.GetBytes(RandomBytes);

    // get a guid, which will be unique enough for us
    var UniqueBytes = Guid.NewGuid().ToByteArray();

    // encode the garbage as friendly, printable characters
    var AllBytes = new byte[RandomBytes.Length + UniqueBytes.Length];
    UniqueBytes.CopyTo(AllBytes, 0);
    RandomBytes.CopyTo(AllBytes, UniqueBytes.Length);

    return Convert.ToBase64String(AllBytes);
}
static RandomNumberGenerator BetterRandom = new RNGCryptoServiceProvider();
```
 
Basically I take two components—a 16-bit [GUID](http://en.wikipedia.org/wiki/Globally_Unique_Identifier), and a 44-byte chunk of random bits. The GUID would [normally be enough](http://blogs.msdn.com/oldnewthing/archive/2008/06/27/8659071.aspx) to satisfy me as they are pretty much unique (and the Win32 algorithm might even guarantee them to be unique when considering a single machine) *but*, I was afraid they might be predictable as they [aren’t actually all that random](http://blogs.msdn.com/oldnewthing/archive/2008/06/27/8659071.aspx). 

How’d I come up with 44 bytes (352 bits)? It looks nice. I guessed a few numbers until I got the encoded output to be of reasonable size. Which brings me to the Base64 conversion. This just takes the binary blob of bits and turns them into simple, printable characters so I can pass them around in URLs.

If you’re know of any weaknesses with this approach, please share! Something like this will eventually guard something about as valuable as a garden gnome, so I’m not too worried about it yet. It’s certainly more secure than the simple passwords most of *us* use.