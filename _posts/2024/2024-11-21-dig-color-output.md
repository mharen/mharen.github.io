---
layout: post
date: "2024-11-21"
categories:
    - technology
title: "Colorized DNS results from dig"
---

Inspired by this [old script][1], you can colorize `dig`'s output to make it easier to read:

<picture>
    <source srcset="/assets/2024/dig-color-dark.png" media="(prefers-color-scheme: dark)">
    <img height="497" width="640" src="/assets/2024/dig-color-light.png" title="hi" alt='a terminal window showing the command "dig portal.azure.com" and the results, which are several recursive dns entries, colored so that each name has a different color' />
</picture>

Each host gets a color, which makes it easier to scan the recursive entries because you can easily pair up the identical names.

Add this to your `~/.bash_profile` or similar:

```sh
dig-color () {
  OUTPUT=$(\dig $*)
  MAX_HOST_LENGTH=$(echo "$OUTPUT" | awk 'NF && $0 !~ /^;/ { for(i=1;i<=NF;i++) if(length($i)>max) max=length($i) } END { print max }')
  # print the raw output of dig in dim text
  echo -e "\033[2m$OUTPUT\033[0m\n"
  echo "$OUTPUT" | gawk '
    BEGIN { 
      uniqueHosts = 0 
    } 
    # only look at lines that do not start with a ";"
    NF && $0 !~ /^;/ { 
      # extract all the parts of the output we care about -- host, ttl, type, etc.  
      match($0, /^(\S+)\s+([0-9]+)\s+(\S+)\s(\S+)\s(.*)$/, a);
      
      # assign a color code to hosts the first time we encounter them, starting at color code 91
      if (a[1] in hosts == 0) 
        hosts[a[1]] = (91 + ++uniqueHosts);
      
      if (a[5] in hosts == 0)
        hosts[a[5]] = (91 + ++uniqueHosts);
      
      # print colorized output for each DNS record
      printf "\033[1;%sm%-'"$MAX_HOST_LENGTH"'s\033[0m %5s %s %-5s \033[1;%sm%s\033[0m\n",
        hosts[a[1]], a[1], a[2], a[3], a[4], hosts[a[5]], a[5] 
    }
  '
}

alias dig='dig-color'
```

[1]: https://github.com/repro/dig-color