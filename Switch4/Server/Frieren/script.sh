#!/bin/bash

bash /root/install_script.sh

# Configure Web using nginx
mkdir -p /var/www/granz
cp -r /root/modul-3/* /var/www/granz/

rm -rf /etc/nginx/sites-enabled/default
cp /root/granz.channel.f04 /etc/nginx/sites-available/granz.channel.f04
ln -sf /etc/nginx/sites-available/granz.channel.f04 /etc/nginx/sites-enabled

service nginx restart
service php7.3-fpm start
