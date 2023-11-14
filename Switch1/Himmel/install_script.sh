#!/bin/bash
  
apt-get update > /dev/null

# Check if isc-dhcp-server is installed
if ! dpkg -l | grep -q isc-dhcp-server; then
  echo "isc-dhcp-server is not installed. Installing it now..."
  apt-get install isc-dhcp-server -y
else
  echo "isc-dhcp-server is already installed."
fi
