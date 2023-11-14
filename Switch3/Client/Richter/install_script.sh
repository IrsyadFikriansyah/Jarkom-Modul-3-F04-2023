#!/bin/bash
  
apt-get update > /dev/null

# Check if dnsutils is installed
if ! dpkg -l | grep -q dnsutils; then
  echo "dnsutils is not installed. Installing it now..."
  apt-get install dnsutils -y
else
  echo "dnsutils is already installed."
fi

# Check if lynx is installed
if ! dpkg -l | grep -q lynx; then
  echo "lynx is not installed. Installing it now..."
  apt-get install lynx -y
else
  echo "lynx is already installed."
fi