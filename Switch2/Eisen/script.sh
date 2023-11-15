#!/bin/bash

echo 'nameserver 192.223.1.3 # IP Heiter' > /etc/resolv.conf

bash /root/install_script.sh

# configure load balancing
rm -rf /etc/nginx/sites-enabled/default

cp /root/lb-jarkom /etc/nginx/sites-available/
ln -sf /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled

service nginx restart
