# What's this

This is modified https://github.com/linuxserver/docker-wireguard repo. Changes allow peers to get into 10.13.13.0/24 subnet
to talk to each other, but not external world.

## Usage

`/opt/wireguard-server/docker-compose.yml`

```yaml
---
version: "2.1"
services:
  wireguard:
    image: varnav/wireguard
    container_name: wireguard-server
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
#      - SERVERURL=wireguard.domain.com #optional
      - SERVERPORT=51820 #optional
      - PEERS=2 #optional
      - PEERDNS=auto #optional
      - INTERNAL_SUBNET=10.13.13.0
    volumes:
      - /opt/wireguard:/config
      - /lib/modules:/lib/modules
    ports:
      - 51820:51820/udp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
```

`docker-compose up -d`

Configs for peers will be generated inside: `/opt/wireguard/peer*`

## Add client via command line (TODO: Incomplete)

You will need info from peer config inside /opt/wireguard/peer1:

```bash
ip link add dev wg0 type wireguard
ip address add dev wg0 10.13.13.2

ip link set up dev wg0
```