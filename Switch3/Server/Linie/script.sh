#!/bin/bash

bash /root/install_script.sh

# Configure Web using nginx
# mkdir -p /var/www/riegel
# cp -r /root/modul-3/* /var/www/riegel/
# 
# rm -rf /etc/nginx/sites-enabled/default
# cp /root/riegel.canyon.f04 /etc/nginx/sites-available/riegel.canyon.f04
# ln -sf /etc/nginx/sites-available/riegel.canyon.f04 /etc/nginx/sites-enabled
# 
# service nginx restart
# service php7.3-fpm start

wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/compose

git clone https://github.com/martuafernando/laravel-praktikum-jarkom.git
cd /root/laravel-praktikum-jarkom
composer update
composer install

cat /root/env-laravel > /root/laravel-praktikum-jarkom/.env

cd /root/laravel-praktikum-jarkom
php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate

cp -r /root/laravel-praktikum-jarkom /var/www/laravel-praktikum-jarkom

rm -rf /etc/nginx/sites-enabled/default
cp /root/riegel.canyon.f04 /etc/nginx/sites-available/riegel.canyon.f04

ln -sf /etc/nginx/sites-available/riegel.canyon.f04 /etc/nginx/sites-enabled/
chmod -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage

service nginx restart
service php8.0-fpm start