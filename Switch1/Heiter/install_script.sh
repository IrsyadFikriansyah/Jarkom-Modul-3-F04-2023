#!/bin/bash
  
apt-get update > /dev/null

# Check if bind9 is installed
if ! dpkg -l | grep -q bind9; then
  echo "bind9 is not installed. Installing it now..."
  apt-get install bind9 -y
else
  echo "bind9 is already installed."
fi