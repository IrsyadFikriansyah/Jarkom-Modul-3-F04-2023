;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.f04.com. root.granz.channel.f04.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@           IN      NS      granz.channel.f04.com.
@           IN      A       192.223.2.3 ; IP Eisen
www         IN      CNAME   granz.channel.f04.com.
