#!/bin/bash
  
apt-get update > /dev/null

# Check if nginx is installed
if ! dpkg -l | grep -q nginx; then
  echo "nginx is not installed. Installing it now..."
  apt-get install nginx -y
else
  echo "nginx is already installed."
fi

# Check if php php-fpm is installed
if ! dpkg -l | grep -q php php-fpm; then
  echo "php php-fpm is not installed. Installing it now..."
  apt-get install php php-fpm -y
else
  echo "php php-fpm is already installed."
fi
