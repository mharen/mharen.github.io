---
layout: post
date: "2024-12-19"
categories:
  - technology
  - code
  - homelab
title: "Easy self-hosting websites with Cloudflare and Docker Compose"
---

## Prerequisites

This guide assumes you have the following:

1. A Cloudflare account (free)
2. A domain name (bought from Cloudflare or elsewhere; $10/yr), set up in Cloudflare
3. A linux server with docker

## The general idea

Web users connect to Cloudflare, and instead of Cloudflare reaching into our network, we run a service inside the
network that _reaches out to Cloudflare_:

<svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 879 240" font-size="20" stroke-width="4" stroke="black" fill="none" role="img">
    <title>CF Tunnels</title>
    <desc>Diagram of a user connecting to a homelab via Cloudflare Tunnels. The diagram has three entities: user,
    Cloudflare, home lab. The user is connected to Cloudflare. The home lab has three docker containers. The first is
    labled "CF Tunnel" and it is connected to the Cloudflare entity, and to each of the other two containers: Webapp1,
    and Webapp2</desc>
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
        <rect x="500" y="10" width="365" height="180" />
        <rect id="cftunnel" x="520" y="80" width="135" height="40" />
        <rect id="webapp1" x="710" y="30" width="135" height="40" />
        <rect id="webapp2" x="710" y="130" width="135" height="40" />
    </g>

    <g id="connections">
        <path marker-end="url(#head)" d="M90,100 155,100"/>
        <path marker-end="url(#head)" d="M515,100 450,100"/>
        <path marker-end="url(#head)" d="M660,90 695,75 "/>
        <path marker-end="url(#head)" d="M660,110 695,125 "/>
    </g>

    <g id="labels" stroke-width="0" fill="black">
        <text x="50" y="220" dominant-baseline="middle" text-anchor="middle">User</text>
        <text x="304" y="220" dominant-baseline="middle" text-anchor="middle">Cloudflare</text>
        <text x="681.5" y="220" dominant-baseline="middle" text-anchor="middle">Homelab Containers</text>
        <text id="cftunnel-label" x="530" y="108">CF Tunnel</text>
        <text id="webapp1-label" x="720" y="58">Webapp1</text>
        <text id="webapp2-label" x="720" y="158">Webapp2</text>
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

    web:
        image: nginx:latest
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
- **service:** choose `http`, and set `url` to the name of your docker service. In the above example it's `web`
- **additional application settings:** none

With that done, you should be able to browse to the subdomain you set up, and the response will be tunneled over from
your homelab server. Good job ✨

## Adding another website

You can add another container to the docker compose file like this:

```yaml
version: "3.3"

services:

  tunnel:
    image: cloudflare/cloudflared
    restart: unless-stopped
    command: tunnel run
    environment:
      - TUNNEL_TOKEN=<insert sensitive token here>

  web:
    image: nginx:latest
    restart: unless-stopped

  whoami:
    image: traefik/whoami
    restart: unless-stopped
```

And add a public hostname mapping in your tunnel:

- **subdomain:** anything you want (this DNS record will be added for you)
- **domain:** pick the domain you already set up in Cloudflare
- **service:** choose `http`, and set `url` to the name of your docker service. **This time it's `whoami`**
- **additional application settings:** none

## Do I need to do TLS, HTTP compression, etc.?

No. Cloudflare handles TLS and HTTP compression for you. The tunnel is encrypted so no additional TLS is necessary for
that leg.

I suggest setting up a global redirect rule in Cloudflare to handle http->https.

## Can I build my own containers?

Sure, that's pretty easy. Your docker compose service can just point to a folder that itself contains a Dockerfile like
this:

```yaml
# ...
  web:
    build: ./web
    restart: unless-stopped
```

When you do `docker compose up -d` it will build the image for you and then start it.

...and run this to _rebuild_ the image as needed: `docker compose up -d --build web`

## Why don't I need a load balancer like Traefik?

Often we'd carefully expose containers within docker to something _outside_ of docker by configuring ports and proxying
traffic through a load balancer like nginx or traefik. We're not actually accepting connections to our
containers from outside of docker so we don't need to do that.

By default, docker compose containers can see each other and connect by service name (i.e. `web`, `whoami`, etc.). When
you configure the tunnel to resolve a public hostname to the internal docker service name, the tunnel container just
uses the docker network to talk to it. And the tunnel container can reach _out_ of the docker network to connect to
Cloudflare. If your container is listening on port 80, you're done—you don't need to expose it to the host network.

## Troubleshooting

See logs from your containers, including the cloudflare tunnel (read those error messages carefully!):

```sh
docker compose logs -f
```

See if the tunnel state is healthy in the Cloudflare dashboard

See if your containers are running:

```sh
docker container ls
```
