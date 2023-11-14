#!/bin/bash
  
apt-get update > /dev/null

# Check if isc-dhcp-relay is installed
if ! dpkg -l | grep -q isc-dhcp-relay; then
  echo "isc-dhcp-relay is not installed. Installing it now..."
  apt-get install isc-dhcp-relay -y
else
  echo "isc-dhcp-relay is already installed."
fi


