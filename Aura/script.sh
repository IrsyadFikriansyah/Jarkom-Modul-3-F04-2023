#!/bin/bash
  
:1bash /root/install_script.sh

cp /root/isc-dhcp-relay /etc/default/isc-dhcp-relay
cp /root/sysctl.conf /etc/sysctl.conf

service isc-dhcp-relay restart