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

# Check if apache2-utils is installed
if ! dpkg -l | grep -q apache2-utils; then
  echo "apache2-utils is not installed. Installing it now..."
  apt-get install apache2-utils -y
else
  echo "apache2-utils is already installed"
fi

# Check if htop is installed
if ! dpkg -l | grep -q htop; then
  echo "htop is not installed. Installing it now..."
  apt-get install htop -y
else
  echo "htop is already installed"
fi

# Check if less is installed
if ! dpkg -l | grep -q less; then
  echo "less is not installed. Installing it now..."
  apt-get install less -y
else
  echo "less is already installed"
fi