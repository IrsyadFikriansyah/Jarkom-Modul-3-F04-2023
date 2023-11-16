#!/bin/bash
  
apt-get update > /dev/null

# Check if nginx is installed
if ! dpkg -l | grep -q nginx; then
  echo "nginx is not installed. Installing it now..."
  apt-get install nginx -y
else
  echo "nginx is already installed."
fi

# Check if apache2-utils is installed
if ! dpkg -l | grep -q apache2-utils; then
  echo "apache2-utils is not installed. Installing it now..."
  apt-get install apache2-utils -y
else
  echo "apache2-utils is already installed."
fi