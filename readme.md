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
* Himmel
```sh
auto eth0
iface eth0 inet static
	address 192.223.1.2
	netmask 255.255.255.0
	gateway 192.223.1.1
```

* Heiter
```sh
auto eth0
iface eth0 inet static
	address 192.223.1.2
	netmask 255.255.255.0
	gateway 192.223.1.1
```

Switch2
* Denken
```sh
auto eth0
iface eth0 inet static
	address 192.223.2.2
	netmask 255.255.255.0
	gateway 192.223.2.1
```
* Eisen
```sh
auto eth0
iface eth0 inet static
	address 192.223.2.3
	netmask 255.255.255.0
	gateway 192.223.2.1
```

Switch3
* Lawine
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether b6:01:69:0e:9d:82
```

* Linie
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 3a:8e:11:17:0a:25
```

* Lugner
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 0a:1f:d6:f4:b0:3f
```

Switch4
* Frieren
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 92:41:df:cb:af:16
```

* Flamme
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 2e:25:8e:a2:72:68
```

* Fern
```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether 2e:96:83:59:da:5b
```