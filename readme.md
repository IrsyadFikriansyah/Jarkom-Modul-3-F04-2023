# Jarkom-Modul-3-F04-2023

## Anggota Kelompok

1. 5025211149 - Irsyad Fikriansyah Ramadhan
2. 5025211158 - Ghifari Maaliki Syafa Syuhada

| Kelompok | Prefix IP |
|----------|-----------|
| F04      | 192.223   |


## Topologi

![topologi](Images/topologi.jpg)

### Netwok Configuration

Router:
* Aura:
```sh
# DHCP config for eth0
auto eth0
iface eth0 inet dhcp

# Static config for eth1
auto eth1
iface eth1 inet static
	address 192.223.1.1
	netmask 255.255.255.0

# Static config for eth2
auto eth2
iface eth2 inet static
	address 192.223.2.1
	netmask 255.255.255.0

# Static config for eth3
auto eth3
iface eth3 inet static
	address 192.223.3.1
	netmask 255.255.255.0

# Static config for eth4
auto eth4
iface eth4 inet static
	address 192.223.4.1
	netmask 255.255.255.0
```

Switch 1
* Himmel:
```sh
auto eth0
iface eth0 inet static
	address 192.223.1.2
	netmask 255.255.255.0
	gateway 192.223.1.1
```

* Heiter:
```sh
auto eth0
iface eth0 inet static
	address 192.223.1.3
	netmask 255.255.255.0
	gateway 192.223.1.1
```

Switch2
* Denken:
```sh
auto eth0
iface eth0 inet static
	address 192.223.2.2
	netmask 255.255.255.0
	gateway 192.223.2.1
```
* Eisen:
```sh
auto eth0
iface eth0 inet static
	address 192.223.2.3
	netmask 255.255.255.0
	gateway 192.223.2.1
```

Switch3
* Lawine:
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether b6:01:69:0e:9d:82
```

* Linie:
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 3a:8e:11:17:0a:25
```

* Lugner:
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 0a:1f:d6:f4:b0:3f
```

Switch4
* Frieren:
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 92:41:df:cb:af:16
```

* Flamme:
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 2e:25:8e:a2:72:68
```

* Fern:
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 2e:96:83:59:da:5b
```

### DHCP Configuration

```sh
ddns-update-style none;
option domain-name "example.org";
option domain-name-servers ns1.example.org, ns2.example.org;

default-lease-time 600;
max-lease-time 7200;

authoritative;
log-facility local7;

# eth1
subnet 192.223.1.0 netmask 255.255.255.0 {
  option routers 192.223.1.1;
}

# eth2
subnet 192.223.2.0 netmask 255.255.255.0 {
  option routers 192.223.2.1;
}

# eth3
subnet 192.223.3.0 netmask 255.255.255.0 {
    range 192.223.3.16 192.223.3.32;
    range 192.223.3.64 192.223.3.80;
    option routers 192.223.3.1;
    option broadcast-address 192.223.3.255;
    option domain-name-servers 192.223.1.3;
    default-lease-time 180;
    max-lease-time 5760;
}

# eth4
subnet 192.223.4.0 netmask 255.255.255.0 {
    range 192.223.4.12 192.223.4.20;
    range 192.223.4.160 192.223.4.168;
    option routers 192.223.4.1;
    option broadcast-address 192.223.4.255;
    option domain-name-servers 192.223.1.3;
    default-lease-time 720;
    max-lease-time 5760;
}

# Switch 3
host Lawine {
    hardware ethernet b6:01:69:0e:9d:82;
    fixed-address 192.223.3.2;
}

host Linie {
    hardware ethernet 3a:8e:11:17:0a:25;
    fixed-address 192.223.3.3;
}

host Lugner {
    hardware ethernet 0a:1f:d6:f4:b0:3f;
    fixed-address 192.223.3.4;
}

# Switch 4
host Frieren {
    hardware ethernet 92:41:df:cb:af:16;
    fixed-address 192.223.4.2;
}

host Flamme {
    hardware ethernet 2e:25:8e:a2:72:68;
    fixed-address 192.223.4.3;
}

host Fern {
    hardware ethernet 2e:96:83:59:da:5b;
    fixed-address 192.223.4.4;
}
```

### DNS Configuration

* named.conf.local :
```sh
zone "granz.channel.f04.com" {
    type master;
    file "/etc/bind/granz/granz.channel.f04.com";
};

zone "riegel.canyon.f04.com" {
    type master;
    file "/etc/bind/riegel/riegel.canyon.f04.com";
};
```

* granz.channel.f04.com:
```sh
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
@           IN      A       192.223.4.2 ; IP Frieren
www         IN      CNAME   granz.channel.f04.com.
```

* riegel.canyon.f04.com:
```sh
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
@           IN      A       192.223.3.2 ; IP Lawine
www         IN      CNAME   riegel.canyon.f04.com.
```
