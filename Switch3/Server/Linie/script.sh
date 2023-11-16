#!/bin/bash

bash /root/install_script.sh

# For connecting to the database
# mariadb --host=192.223.2.2 --port=3306 --user=kelompokf04 --password=passwordf04

wget https://getcomposer.org/download/2.0.13/composer.phar
chmod +x composer.phar
mv composer.phar /usr/bin/composer

git clone https://github.com/martuafernando/laravel-praktikum-jarkom.git
cat /root/env-laravel > /root/laravel-praktikum-jarkom/.env
cp -r /root/laravel-praktikum-jarkom /var/www/laravel-praktikum-jarkom

cd /var/www/laravel-praktikum-jarkom
composer update
composer install

php artisan migrate:fresh
php artisan db:seed --class=AiringsTableSeeder
php artisan key:generate
php artisan jwt:secret

rm -rf /etc/nginx/sites-enabled/default
cp /root/riegel.canyon.f04 /etc/nginx/sites-available/riegel.canyon.f04

ln -sf /etc/nginx/sites-available/riegel.canyon.f04 /etc/nginx/sites-enabled/
chown -R www-data.www-data /var/www/laravel-praktikum-jarkom/storage

service nginx restart
service php8.0-fpm start