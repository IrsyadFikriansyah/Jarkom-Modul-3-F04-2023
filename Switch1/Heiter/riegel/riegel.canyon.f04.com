;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.f04.com. root.riegel.canyon.f04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@           IN      NS      riegel.canyon.f04.com.
@           IN      A       192.223.3.2 ; IP Lawine???
www         IN      CNAME   riegel.canyon.f04.com.
