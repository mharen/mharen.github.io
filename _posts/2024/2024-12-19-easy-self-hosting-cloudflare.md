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

<picture> <source height="181" width="454" srcset="/assets/2024/cf-tunnels-dark.png" media="(prefers-color-scheme: dark)" />
    <img height="181" width="454" src="/assets/2024/cf-tunnels-light.png" alt='a flowchart that shows three
        entities: web user, cloudflare, home lab. The web user is connected to cloudflare. The home lab has three docker
        containers. The first is labled "CF tunnel" and it is connected to the cloudflare entity, and to each of the other
        two containers: web app, and web app 2' />
</picture>

We are **not** opening any ports, e.g. http/https from our server to the local network or internet. We are **not**
messing with dynamic dns stuff. We don't need to set up TLS.

## An example with Docker Compose

### Create the tunnel config at Cloudflare

First create your tunnel in the Cloudflare dashboard > Zero Trust > Networks > Tunnels:

- Choose `cloudflared`
- Name it whatever you want, e.g. `homelab`
- Click the "docker" installation instructions just to _grab the token_
- *Don't actually install anything*

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