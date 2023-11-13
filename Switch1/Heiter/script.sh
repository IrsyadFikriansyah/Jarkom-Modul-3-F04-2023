#!/bin/bash

echo 'nameserver 192.168.122.1  # IP Pandudewanata' > /etc/resolv.conf

bash /root/install-script.sh

# Setting DNS
cp /root/named.conf.local /etc/bind/named.conf.local
cp /root/named.conf.options /etc/bind/named.conf.options

# Setting baratayuda
mkdir -p /etc/bind/baratayuda
cp /root/baratayuda/baratayuda.abimanyu.f04.com /etc/bind/baratayuda/baratayuda.abimanyu.f04.com

# Start services
service bind9 restart