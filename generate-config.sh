#!/bin/bash

IPADDR=$1
PRIVKEY=$2

PUBKEY=""
ENDPOINT=""

cat >/etc/wireguard/wg0.conf <<EOF
[Interface]
Address = ${IPADDR}
PrivateKey = ${PRIVKEY}
ListenPort = 51820
DNS = 10.13.13.1

[Peer]
PublicKey = ${PUBKEY}
Endpoint = ${ENDPOINT}
AllowedIPs = 10.13.13.0/24, ::/1, 8000::/1

EOF

wg-quick up wg0
sleep 3
wg