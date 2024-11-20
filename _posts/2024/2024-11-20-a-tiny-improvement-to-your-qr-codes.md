---
layout: post
date: "2024-11-20"
categories:
    - technology
title: "A tiny improvement to your QR Codes"
---

Regardless of your executive's enthusiasm, QR codes are [not a silver bullet][3]. But they are occasionally useful and I
learned that you can improve them with a small tweak: [leverage the right mode][1].

Suppose you encode a URL, e.g. `https://www.wassupy.com/`:

{% imagesize /assets/2024/qrcode-byte.png:img alt='A qr code that is 33x33 blocks' %}

And then this similar URL, `HTTPS://WWW.WASSUPY.COM/`:

{% imagesize /assets/2024/qrcode-alpha.png:img alt='A 2nd, smaller qr code that is 29 by 29 blocks' %}

The all-caps version is simpler because it makes use of the "alphanumeric" segment mode to attain [higher information density][2]:

| Input mode   | Bits/char. | Character set       |
|--------------|------------|---------------------|
| Numeric      | 3 1⁄3      | `[0-9]`             |
| Alphanumeric | 5 1⁄2      | `[0–9A–Z$%*+./: -]` |
| Binary/byte  | 8          |                     |

*Note: the alphanumeric set **does not** include lowercase letters.*

When building the QR code, your input is split into segments according to what mode can handle the input, and all-caps URLs fit into the more efficient _alphanumeric_ mode. Keeping this in mind, you can generally always make the scheme and host portion of a URL uppercase, and the more caps you can accommodate in the path, the better.

Of course, using shorter URLs helps the most 😊.

[1]: https://www.imperialviolet.org/2021/08/26/qrencoding.html "Efficient QR codes"
[2]: https://en.wikipedia.org/wiki/QR_code#Information_capacity "QR Code Information capacity"
[3]: https://en.wikipedia.org/wiki/No_Silver_Bullet "No Silver Bullet"