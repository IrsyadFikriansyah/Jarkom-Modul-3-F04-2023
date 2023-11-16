# Jarkom-Modul-3-F04-2023

## Anggota Kelompok

1. 5025211149 - Irsyad Fikriansyah Ramadhan
2. 5025211158 - Ghifari Maaliki Syafa Syuhada

| Kelompok | Prefix IP |
|----------|-----------|
| F04      | 192.223   |

## Cara Kami Mengerjakan

<div align=justify>
Cara kami mengerjakan praktikum ini adalah dengan menggunakan 1 buah file `script.sh` yang kami letakkan pada setiap node pada topologi. `script.sh` kami berisikian command command yang jika dijalankan akan men-setup node tersebut. Di dalam setiap node juga terdapat 1 buah file `install_script.sh` yang berisikan command untuk mengdownload packages yang diperlukan pada node tersebut. Pada tiap root juga terdapat file konfigurasi node yang telah dibuat sebelumnya, sehingga pada `script.sh` kami tinggal hanya men-copy file konfigurasi pada directory yang semestinya
</div>

## Topologi

![topologi](Images/topologi.jpg)

### Netwok Configuration

Router:
* Aura (Router/DHCP Relay):
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
* Himmel (DHCP Server):
    ```sh
    auto eth0
    iface eth0 inet static
        address 192.223.1.2
        netmask 255.255.255.0
        gateway 192.223.1.1
    ```

* Heiter (DNS Server):
    ```sh
    auto eth0
    iface eth0 inet static
        address 192.223.1.3
        netmask 255.255.255.0
        gateway 192.223.1.1
    ```

Switch2
* Denken (Database Server):
    ```sh
    auto eth0
    iface eth0 inet static
        address 192.223.2.2
        netmask 255.255.255.0
        gateway 192.223.2.1
    ```

* Eisen (Load Balancer):
    ```sh
    auto eth0
    iface eth0 inet static
        address 192.223.2.3
        netmask 255.255.255.0
        gateway 192.223.2.1
    ```

Switch3
* Revolte (Client):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    ```

* Richter (Client):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    ```

* Lawine (Laravel Worker):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    hwaddress ether b6:01:69:0e:9d:82
    ```

* Linie (Laravel Worker):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    hwaddress ether 3a:8e:11:17:0a:25
    ```

* Lugner (Laravel Worker):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    hwaddress ether 0a:1f:d6:f4:b0:3f
    ```

Switch4
* Sein (Client):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    ```

* Stark (Client):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    ```

* Frieren (PHP Worker):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    hwaddress ether 92:41:df:cb:af:16
    ```

* Flamme (PHP Worker):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    hwaddress ether 2e:25:8e:a2:72:68
    ```

* Fern (PHP Worker):
    ```sh
    auto eth0
    iface eth0 inet dhcp
    hwaddress ether 2e:96:83:59:da:5b
    ```

## Setup DHCP

### Setup DHCP Relay on `Aura`

1. install `isc-dhcp-relay`
2. configure `/etc/default/isc-dhcp-relay`
3. configure `/etc/sysctl.conf`
4. run `service isc-dhcp-relay restart`

* `/etc/default/isc-dhcp-relay`:
    ```sh
    SERVERS="192.223.1.2"
    INTERFACES="eth1 eth2 eth3 eth4"
    OPTIONS=
    ```
* `/etc/sysctl.conf`:
    ```sh
    net.ipv4.ip_forward=1
    ```

### Setup DHCP Server on `Himmel`

1. install `isc-dhcp-server`
2. konfigurasi `/etc/default/isc-dhcp-server`
3. konfigurasi `/etc/dhcp/dhcpd.conf`
4. jalankan `service isc-dhcp-server restart`

* `/etc/default/isc-dhcp-server`:
    ```sh
    INTERFACESv4="eth0"
    INTERFACESv6=""
    ```

* `/etc/dhcp/dhcpd.conf`:
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

## Soal 1

> Setelah mengalahkan Demon King, perjalanan berlanjut. Kali ini, kalian diminta untuk melakukan register domain berupa `riegel.canyon.f04.com` untuk worker Laravel dan `granz.channel.f04.com` untuk worker PHP (0) mengarah pada worker yang memiliki IP `192.223.x.1`.

<hr style="width:60%; align:center">

1. tambakan `nameserver` pada `/etc/resolv.conf`
2. install `bind9`
3. konfigutasi `/etc/bind/named.conf.local`
4. konfigutasi `/etc/bind/named.conf.options`
5. buat directory baru `/etc/bind/granz`
6. buat directory baru `/etc/bind/riegel`
7. buat file config baru `/etc/bind/granz/granz.channel.f04.com`
8. buat file config baru `/etc/bind/riegel/riegel.canyon.f04.com`
9. jalankan `service bind9 restart` 

* `/etc/resolv.conf`:
    ```sh
    nameserver 192.168.122.1  # IP NAT1
    ```

* `/etc/bind/named.conf.local`:
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

* `/etc/bind/named.conf.options`:
    ```sh
    options {
        directory "/var/cache/bind";
        forwarders {
                192.168.122.1;
        };
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
    };
    ```

* `/etc/bind/granz/granz.channel.f04.com`:
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
    @           IN      A       192.223.2.3 ; IP Eisen
    www         IN      CNAME   granz.channel.f04.com.
    ```

* `/etc/bind/riegel/riegel.canyon.f04.com`:
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
    @           IN      A       192.223.2.3 ; IP Eisen
    www         IN      CNAME   riegel.canyon.f04.com.
    ```

## Soal 2

> Client yang melalui Switch3 mendapatkan range IP dari 192.223.3.16 - 192.223.3.32 dan 192.223.3.64 - 192.223.3.80

<hr style="width:60%; align:center">

1. add configuration ip range in `/etc/default/isc-dhcp-server` on `Himmel`

* `/etc/default/isc-dhcp-server`:
    ```sh
    ...
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
    ...
    ```

## Soal 3

> Client yang melalui Switch4 mendapatkan range IP dari 192.223.4.12 - 192.223.4.20 dan 192.223.4.160 - 192.223.4.168

<hr style="width:60%; align:center">

1. add ip range configuration in `/etc/default/isc-dhcp-server` on `Himmel`

* `/etc/default/isc-dhcp-server`:
    ```sh
    ...
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
    ...
    ```

## Soal 4

> Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut

<hr style="width:60%; align:center">

1. add DNS configuration in `/etc/default/isc-dhcp-server` on `Himmel`

* `/etc/default/isc-dhcp-server`:
    ```sh
    ...
        subnet 192.223._.0 netmask 255.255.255.0 {
            ...
            option domain-name-servers 192.223.1.3;
            ...
        }
    ...
    ```
    
## Soal 5

> Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3 selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan waktu maksimal dialokasikan untuk peminjaman alamat IP selama 96 menit

<hr style="width:60%; align:center">

1. add lease time configuration in `/etc/default/isc-dhcp-server` on `Himmel`

* `/etc/default/isc-dhcp-server`:
    ```sh
    ...
        # eth3
        subnet 192.223.3.0 netmask 255.255.255.0 {
            ...
            default-lease-time 180;
            max-lease-time 5760;
        }

        # eth4
        subnet 192.223.4.0 netmask 255.255.255.0 {
            ...
            default-lease-time 720;
            max-lease-time 5760;
        }
    ...
    ```
    
    
## Soal 6

> Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut dengan menggunakan php 7.3.

<hr style="width:60%; align:center">

Pada tiap PHP worker:

1. install `nginx php php-fpm`
2. download file website dengan `wget` (butuh `wget` dan `unzip`)
3. buat directory baru `/var/www/granz`
4. copy file website yang telah di-unzip ke directory `/var/www/granz/`
5. hapus directory default pada nginx `/etc/nginx/sites-enabled/default`
6. buat file config baru `/etc/nginx/sites-available/granz.channel.f04`
7. link file `/etc/nginx/sites-available/granz.channel.f04` pada `/etc/nginx/sites-enabled`
8. jalankan `service nginx restart`
9. jalankan `service php7.3-fpm start`

* download dan unzip file dengan command berikut:
    ```sh
    wget --no-check-certificate "https://drive.google.com/uc?export=download&id=1ViSkRq7SmwZgdK64eRbr5Fm1EGCTPrU1" -O file
    unzip file.zip
    ```
* `/etc/nginx/sites-available/granz.channel.f04`:
    ```sh
    server {
            listen 80 default_server;
            listen [::]:80 default_server;

            root /var/www/granz;

            index index.html index.htm index.php;

            server_name granz.channel.f04.com;

            location / {
                    try_files $uri $uri/ =404;
            }

            location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.3-fpm.sock;
            }
    }
    ```
    
## Soal 7

> Kepala suku dari Bredt Region memberikan resource server sebagai berikut: <br>
> a. Lawine, 4GB, 2vCPU, dan 80 GB SSD. <br>
> b. Linie, 2GB, 2vCPU, dan 50 GB SSD. <br>
> c. Lugner 1GB, 1vCPU, dan 25 GB SSD. <br>
> aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000 request dan 100 request/second.

<hr style="width:60%; align:center">

Untuk melakukan testing, kita dapat menggunakan `ApacheBench`. berikut adalah langkah-langkahnya:

Pada salah satu client:

1. install `apache2-utils`
2. jalankan `ab -n 1000 -c 100 granz.channel.f04.com/`

* hasil:
![7](images/7.jpg)
    
## Soal 8

> Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200 request dan 10 request/second masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut: <br>
> a. Nama Algoritma Load Balancer <br>
> b. Report hasil testing pada Apache Benchmark <br>
> c. Grafik request per second untuk masing masing algoritma. <br>
> d. Analisis 
 
<hr style="width:60%; align:center">

Untuk melakukan testing, kita dapat menggunakan `ApacheBench`. berikut adalah langkah-langkahnya:

Pada salah satu client:

1. install `apache2-utils`
2. jalankan `ab -n 200 -c 10 granz.channel.f04.com/`
3. ubah algoritma lb pada node `Sein` dan ulangi langkah ke-2
4. ulangi langkah ke-3 untuk semua algoritma load balancing

#### Hasil: 

Kami melakukan 10 kali percobaan untuk tiap algoritma (Round Robin, Least Connection, IP Hash, Generic Hash). Kemudian dari ke 10 percobaan yang kami lakukan, kami buat rata-rata nya yang kemudian kami bandingkan tiap algoritma. Berikut adalah graf performa tiap algoritma load balancing:

![8](images/8.jpg)

untuk lebih detailnya dapat diakses pada tautan **<a href="https://docs.google.com/document/d/1KRXqVpzQufx1s8oTjW6fgp6x9LUVNZi1pcKLPr0Z1-o/edit?usp=drive_link">ini</a>**.
    
## Soal 9

> Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second, kemudian tambahkan grafiknya pada grimoire.
 
<hr style="width:60%; align:center">

Untuk melakukan testing, kita dapat menggunakan `ApacheBench`. berikut adalah langkah-langkahnya:

Pada salah satu client:

1. install `apache2-utils`
2. jalankan `ab -n 100 -c 10 granz.channel.f04.com/`
3. matikan worker dengan `service nginx stop` dan ulangi langkah ke-2 untuk jumlah worker 3, 2, dan 1

#### Hasil: 

Sama seperti soal 8, kami melakukan 10 percobaan untuk tiap jumlah worker (3, 2, dan 1). Lalu, kami buat rata-ratanya yang kemudian kami bandingkan. Berikut adalah graf performa pengaruh jumlah worker:

![9](images/9.jpg)

untuk lebih detailnya dapat diakses pada tautan **<a href="https://docs.google.com/document/d/1KRXqVpzQufx1s8oTjW6fgp6x9LUVNZi1pcKLPr0Z1-o/edit?usp=drive_link">ini</a>**.
    
## Soal 10

> Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi username: `netics` dan password: `ajkf04`, dengan yyy merupakan kode kelompok. Terakhir simpan file `htpasswd` nya di `/etc/nginx/rahasisakita/` .
 
<hr style="width:60%; align:center">

Pada Eisen:

1. jalankan `htpasswd -c /etc/nginx/.htpasswd netics` kemudian masukkan password `ajkf04`
2. jalankan `ab -n 100 -c 10 granz.channel.f04.com/`
3. matikan worker dengan `service nginx stop` dan ulangi langkah ke-2 untuk jumlah worker 3, 2, dan 1

#### Hasil: 

Sama seperti soal 8, kami melakukan 10 percobaan untuk tiap jumlah worker (3, 2, dan 1). Lalu, kami buat rata-ratanya yang kemudian kami bandingkan. Berikut adalah graf performa pengaruh jumlah worker:

![9](images/9.jpg)

untuk lebih detailnya dapat diakses pada tautan **<a href="https://docs.google.com/document/d/1KRXqVpzQufx1s8oTjW6fgp6x9LUVNZi1pcKLPr0Z1-o/edit?usp=drive_link">ini</a>**.
    
