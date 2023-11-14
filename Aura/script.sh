#!/bin/bash
  
bash /root/install_script.sh

cp /root/isc-dhcp-server /etc/default/isc-dhcp-server
cp /root/dhcpd.conf /etc/dhcp/dhcpd.conf

rm /var/run/dhcpd.pid
service isc-dhcp-server restart