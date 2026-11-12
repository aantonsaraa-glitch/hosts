#!/usr/bin/env bash

echo "Alex"

# valid_ip <host> <ip> <dns_server>
valid_ip() { dig +short "$1" "@$3" | grep -qxF "$2"; }


dns=${1:-8.8.8.8}

while read -r ip names; do
    [[ -z $ip || $ip == \#* ]] && continue
    for name in ${names%%#*}; do
        valid_ip "$name" "$ip" "$dns" || echo "Bogus IP for $name in /etc/hosts!"
    done
done < /etc/hosts
