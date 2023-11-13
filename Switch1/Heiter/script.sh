#!/bin/bash

echo 'nameserver 192.168.122.1  # IP Aura' > /etc/resolv.conf

bash /root/install-script.sh

# Setting DNS
cp /root/named.conf.local /etc/bind/named.conf.local
cp /root/named.conf.options /etc/bind/named.conf.options

# Setting granz
mkdir -p /etc/bind/granz
cp /root/granz/granz.channel.f04.com /etc/bind/granz/granz.channel.f04.com

# Setting riegel
mkdir -p /etc/bind/riegel
cp /root/riegel/riegel.canyon.f04.com /etc/bind/riegel/riegel.canyon.f04.com

# Start services
service bind9 restart