#!/bin/bash

echo 'nameserver 192.223.1.3 # IP Heiter' > /etc/resolv.conf 

bash /root/install_script.sh

cp /root/isc-dhcp-server /etc/default/isc-dhcp-server
cp /root/dhcpd.conf /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart