#!/bin/bash

bash /root/install_script.sh

# Configure Web using nginx
mkdir -p /var/www/riegel
cp -r /root/modul-3/* /var/www/riegel/

rm -rf /etc/nginx/sites-enabled/default
cp /root/riegel.canyon.f04 /etc/nginx/sites-available/riegel.canyon.f04
ln -sf /etc/nginx/sites-available/riegel.canyon.f04 /etc/nginx/sites-enabled

service nginx restart
service php8.3-fpm start
