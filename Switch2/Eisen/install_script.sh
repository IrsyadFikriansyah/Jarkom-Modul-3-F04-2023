#!/bin/bash
  
apt-get update > /dev/null

# Check if nginx is installed
if ! dpkg -l | grep -q nginx; then
  echo "nginx is not installed. Installing it now..."
  apt-get install nginx -y
else
  echo "nginx is already installed."
fi