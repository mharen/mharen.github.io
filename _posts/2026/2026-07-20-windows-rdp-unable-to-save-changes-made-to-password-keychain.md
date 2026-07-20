---
layout: post
date: "2026-07-20"
categories:
    - technology
    - code
title: "Fixed: Windows.app: Unable to save changes made to the password as the default keychain can't be accessed."
---

I recently changed my password and since then have been getting this error in _Windows.app_ (i.e. _Remote Desktop_) on my Mac:

> Unable to save changes made to the password as the default keychain can't be accessed

Instead of messing with _Keychain Access_, resetting prefs on disk, etc., all I ultimately had to do was this _within the Windows app itself_:

1. Preferences > Credentials
2. Remove the credential
3. Re-add the credential

And then update the config for any related connections to use the "new" credential.

That's it.