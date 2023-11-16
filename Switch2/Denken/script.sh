#!/bin/bash

echo 'nameserver 192.223.1.3 # IP Heiter' > /etc/resolv.conf

bash /root/install_script.sh

service mysql restart

mysql < /root/queries.sql