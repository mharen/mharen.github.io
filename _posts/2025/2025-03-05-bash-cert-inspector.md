---
layout: post
date: "2025-03-05"
categories:
    - technology
    - code
title: Command line server TLS certificate inspector
---

I can never remember this command to inspect a remote server's certificate from bash/shell/terminal:

```sh
openssl s_client -connect example.com:443 < /dev/null | openssl x509 -noout -text
```

So I wrapped it in a function and stuck it into my `~/.bash_profile` like this:

```sh
cert () 
{ 
    openssl s_client -connect $1:443 < /dev/null | openssl x509 -noout -text
}
```

And now I just have to remember `cert [hostname]`, like this:
```
$ cert github.com
Connecting to 140.82.112.3
...
        Issuer: C=GB, ST=Greater Manchester, L=Salford, O=Sectigo Limited, CN=Sectigo ECC Domain Validation Secure Server CA
        Validity
            Not Before: Feb  5 00:00:00 2025 GMT
            Not After : Feb  5 23:59:59 2026 GMT
        Subject: CN=github.com
...
```

And if you're looking for something in particular, you can just `grep` for it:

```sh
$ cert github.com | grep github
        Subject: CN=github.com
                DNS:github.com, DNS:www.github.com
```

Very handy.