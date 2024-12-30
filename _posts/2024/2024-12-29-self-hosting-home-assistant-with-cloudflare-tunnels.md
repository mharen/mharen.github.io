---
layout: post
date: "2024-12-29"
categories:
  - technology
  - code
  - homelab
title: "Expose self-hosted Home Assistant to the internet (and companion app) with Cloudflare Tunnels and Docker Compose"
---

## Prerequisites

This guide assumes you have the following:

1. A Cloudflare account (free)
2. A domain name (bought from Cloudflare or elsewhere; $10/yr), set up in Cloudflare
3. A linux server with docker, which can be the same one where you run Home Assistant, but doesn't need to be

## The general idea

Web users connect to Cloudflare, and instead of Cloudflare reaching into our network, we run a service inside the
network that _reaches out to Cloudflare_:

<svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 874 240" font-size="20" stroke-width="4" stroke="black" fill="none" role="img">
    <title>CF Tunnels</title>
    <desc>Diagram of a client connecting to a Home Assistant instance inside a homelab via Cloudflare Tunnels. The diagram has three entities: client,
    Cloudflare, home lab. The client is connected to Cloudflare. The home lab has two docker containers. The first is
    labled "CF Tunnel" and it is connected to the Cloudflare entity, and the other container: Home Assistant</desc>
    <defs>
        <marker id="head" orient="auto" markerWidth="4" markerHeight="4" refX="0.1" refY="2">
            <path d="M0,0 V4 L2,2 Z" stroke-width="1" fill="black" />
        </marker>
    </defs>

    <g id="actor" fill="none">
        <circle cx="50" cy="50" r="40"/>
        <line x1="50" y1="90" x2="50" y2="150"/>
        <line x1="50" y1="150" x2="25" y2="190"/>
        <line x1="50" y1="150" x2="75" y2="190"/>
        <line x1="25" y1="100" x2="75" y2="100"/>
    </g>
    <path id="cloudflare" stroke-linecap="round" stroke-linejoin="round" d="M 172.498 118.768 C 172.498 175.125 220.749 189.214 244.868 189.214 L 376.449 189.214 C 396.186 189.214 435.661 177.687 435.661 131.576 C 435.661 85.467 396.186 73.94 376.449 73.94 C 376.449 54.727 356.712 9.898 310.658 9.898 C 273.816 9.898 251.447 35.515 244.868 48.323 C 220.749 48.323 172.498 62.413 172.498 118.768 Z" style="fill: none;"/>

    <g id="homelab">
        <rect x="500" y="10" width="360" height="180" />
        <rect x="520" y="80" width="110" height="40" />
        <rect x="685" y="80" width="155" height="40" />
    </g>

    <g id="connections">
        <path marker-end="url(#head)" d="M90,100 155,100"/>
        <path marker-end="url(#head)" d="M515,100 450,100"/>
        <path marker-end="url(#head)" d="M635,100 670,100 "/>
    </g>

    <g id="labels" stroke-width="0" fill="black">
        <text x="50" y="220" dominant-baseline="middle" text-anchor="middle">Client</text>
        <text x="304" y="220" dominant-baseline="middle" text-anchor="middle">Cloudflare</text>
        <text x="681.5" y="220" dominant-baseline="middle" text-anchor="middle">Homelab Containers</text>
        <text x="530" y="108">CF Tunnel</text>
        <text x="695" y="108">Home Assistant</text>
    </g>

</svg>

We are **not** opening any ports, e.g. http/https from our server to the local network or internet. We are **not**
messing with dynamic dns stuff. We don't need to set up TLS.

## An example with Docker Compose

### Create the tunnel config at Cloudflare

First create your tunnel in the Cloudflare dashboard > Zero Trust > Networks > Tunnels:

-   Choose `cloudflared`
-   Name it whatever you want, e.g. `homelab`
-   Click the "docker" installation instructions just to _grab the token_
-   _Don't actually install anything_

Copy that token for the next section.

### On your homelab server

Create `docker-compose.yaml` like this, with the token you copied above:

```yaml
version: "3.3"

services:
    tunnel:
        image: cloudflare/cloudflared
        restart: unless-stopped
        command: tunnel run
        environment:
            - TUNNEL_TOKEN=***insert CF Tunnel token here***
```

Start up the containers:

```sh
docker compose up -d
```

Tail the logs:

```sh
docker compose logs -f
```

### Back in the Cloudflare dashboard

At this point, the Cloudflare dashboard should show your tunnel as _healthy_. If not, read those logs carefully for
errors and fix it before continuing.

Add a public hostname to your tunnel:

- **subdomain:** anything you want (this DNS record will be added for you)
- **domain:** pick the domain you already set up in Cloudflare
- **service:** choose `http`, and set `url` to the internal IP and port of your Home Assistant inac name of your docker service. E.g. `http://192.168.1.100:8123`
- **additional application settings:** none

With that done, you should be able to browse to the subdomain you set up, and the response will be tunneled over from
your homelab server. You'll probably get a `400` error. Don't fret—you're almost done.

Now you need to tell Home Assistant that the Cloudflare tunnel is allowed to proxy it. You can see the exact IP you need
in the Home Assistant error log, e.g.:

> "A request from a reverse proxy was received from 172.21.0.8, but your HTTP integration is not set-up for reverse proxies"

That exact IP could change when your cftunnel container restarts, but the first two parts of the network probably won't,
so you can just trust the whole thing like this, in HA `configuration.yaml`:

```yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.21.0.0/16 # add the actual IP of your cftunnels container, or the network it's on
```

(And restart your HA instance.)

You can also find the anticipated proxy IP by checking the network details, too. First, list your docker networks:

```
docker network ls

NETWORK ID     NAME                     DRIVER    SCOPE
37c19c0df841   bridge                   bridge    local
da9f58733dc9   home-assistant_default   bridge    local
587ff440738c   host                     host      local
30a44b8290f3   none                     null      local
0e1df72bc30c   sites_default            bridge    local
```

Then pick the one *where you're running your cftunnels container* (**not** the one running your HA instance!). In my case, it's in a folder called `sites`, so I need the last one. Inspect it:

```json
// docker network inspect sites_default 

[
    {
        "Name": "sites_default",
        "IPAM": {
            "Config": [
                {
                    "Subnet": "172.21.0.0/16", // <-- this is what you want
                    "Gateway": "172.21.0.1"
                }
            ]
        },
        "Containers": {
            "6626c238...": {
                "Name": "sites-tunnel-1",
                "IPv4Address": "172.21.0.8/16"
            }
        }
    }
]
```

## Do I need to do TLS, HTTP compression, etc.?

No. Cloudflare handles TLS and HTTP compression for you. The tunnel is encrypted so no additional TLS is necessary for
that leg.

## I'm still getting a `400` error, or something else isn't working

Check the logs!