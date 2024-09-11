---
layout: post
date: '2024-09-11'
categories:
- technology
title: "Terraform: add the active workspace name to your command prompt"
---

I've found it very convenient to see the active terraform workspace in my command prompt. This is easy
to achieve with a single line in my `.bash_profile`, _and it only shows up in folders where terraform is active_ ✨.

It's also very fast because it just looks for a file (it doesn't invoke any terraform-related commands).

Here's the snippet to add to `.bash_profile`, or somewhere similar:

```sh
export PS1="\w\[\e[0;32m\]\`if [ -f .terraform/environment ]; then echo -n ' ['; cat .terraform/environment; echo -n ']'; fi\`\[\e[m\] \[\e[1m\]$\[\e[m\] "
```

If you squint past the color codes, it's just looking for the presence of a file `.terraform/environment`, and
if it exists, it sticks its contents into the prompt. It looks like this:

```sh
~/code/infra $ cd terraform
~/code/infra/terraform [prod] $ terraform workspace select dev
Switched to workspace "dev".
~/code/infra/terraform [dev] $ 
```

Pretty nifty.
