#!/bin/bash
  
apt-get update > /dev/null

packages=("lsb-release" "ca-certificates" "apt-transport-https" "software-properties-common" "gnupg2" "mariadb-client" "htop" "wget")

for package in "${packages[@]}"; do
  # Check if the package is installed
  if ! dpkg -l | grep -q "$package"; then
    echo "$package is not installed. Installing it now..."
    apt-get install "$package" -y
  else
    echo "$package is already installed."
  fi
done

# Adding repository to download php8.0
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list

wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add -

apt-get update > /dev/null

packages=("php8.0-mbstring" "php8.0-xml" "php8.0-cli" "php8.0-common" "php8.0-intl" "php8.0-opcache" "php8.0-readline" "php8.0-mysql" "php8.0-fpm" "php8.0-curl" "unzip")

for package in "${packages[@]}"; do
  # Check if the package is installed
  if ! dpkg -l | grep -q "$package"; then
    echo "$package is not installed. Installing it now..."
    apt-get install "$package" -y
  else
    echo "$package is already installed."
  fi
done

rm -rf /etc/apt/sources.list.d/sury-php.list
apt-get install git -y
