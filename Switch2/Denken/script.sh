#!/bin/bash

echo 'nameserver 192.223.1.3 # IP Heiter' > /etc/resolv.conf

bash /root/install_script.sh

service mysql restart

mysql < /root/queries.sql

echo '
#
# This group is read both both by the client and the server
# use it for options that affect everything
#
[client-server]

# Import all .cnf files from configuration directory
!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mariadb.conf.d/

[mysqld]
skip-networking=0
skip-bind-address' > /etc/mysql/my.cnf
