---
layout: post
date: "2024-11-22"
categories:
    - technology
title: "Sneaky file uploads with mismatched content types and file extensions"
---

There's a long history of exploits when web browsers and files mix. I recently worked on a page that accepted files from users, and allowed other users to download them. To avoid a whole host of problems, the file types were strictly limited to:

- common image types
- text/plain
- text/csv

The page was careful to check the content type during the upload, and to return the same content type on download. But this left a gap. A careful attacker could do this:

1. Upload a file with a supported content type, e.g. `text/plain` and a mis-matched file extension normally associated with an unsupported content type, `e.g. .exe`. The page ignores the file extension so it doesn't care.
3. Later, a user downloads the file. The browser knows it is a text file by its content type, but saves it as a `.exe` because of its file extension. Uh oh.
4. The user double-clicks the file and things are not so good.

The attacker could maybe even name the file something like `docs.zip.exe` to further obscure the risk.

Even though the page itself treated the file safely via content types, the OS doesn't do that. One remedy is to check both the content type and file extension and only accept files where they match, and are on the allow list. Another might be to strip file extensions from uploads entirely, though I haven't tried that.