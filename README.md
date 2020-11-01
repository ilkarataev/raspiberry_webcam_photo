# raspiberry_webcam_photo
This repository have script and instruction to get image from usb camera plug in rasberrypi. When you finished don't forget enable overlay or mount tmp for tmpfs.
I didn't find full instruction and decide create set up script.

Project used:  
    1. nginx  
    2. php-fpm  
    3. fswebcam  
    4. Usb camera plug in.  
    5. Gpio4 enable light(light+3.3v PIN 1. GPIO4 GND PIN 7)  
![alt text](https://github.com/ilkarataev/raspiberry_webcam_photo/blob/master/img/board.jpg)

I added Light-emitting diode on the camera.  
![alt text](https://github.com/ilkarataev/raspiberry_webcam_photo/blob/master/img/pilight1.jpg)  
![alt text](https://github.com/ilkarataev/raspiberry_webcam_photo/blob/master/img/pilight2.jpg)  
### Install on rasberry pi model B.Webcam need plug in when you run script.  
```curl https://raw.githubusercontent.com/ilkarataev/raspiberrypi_camera_shot/master/install.bash| /bin/bash -x  ```  
### I used wifi module because installations was in the box without network cabel.The best way use wifi module that working without any drivers install.I used rt5320. You only need intall firmware package ```apt install firmware-ralink``` and configurate wifi inteface:  
add to /etc/network/interfaces.d/wlan0 or /etc/network/interfaces  
```
auto lo
iface lo inet loopback
iface eth0 inet dhcp
auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```  
And  /etc/wpa_supplicant/wpa_supplicant.conf сhange ssid_name and password
```
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
network={
  ssid="ssid_name"
  psk="password"
}
```

You can scheduler send you image to telegram channel you need BotToken,chatid.Script in repository telegram.sh  
```
copy it to /root/
chmod +x telegram.sh
```
Add to crontab

0 0 19 . / /root/telegram.sh

I need wireguard on pu pi to connect my server, and i was disapointed that it took soo many time because firstpi had old cpu.

```
apt update && apt upgrade 

apt install raspberrypi-kernel-headers libelf-dev libmnl-dev build-essential git
```

if you have error with just delete if block 
```
git clone https://git.zx2c4.com/WireGuard

cd WireGuard/

cd src/

make
make install
```

install wireguard
```
echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable.list

printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' > /etc/apt/preferences.d/limit-unstable

apt install dirmngr

wget -O - https://ftp-master.debian.org/keys/archive-key-$(lsb_release -sr).asc | sudo apt-key add -
 
apt update

apt install wireguard
```

full instruction on https://www.reddit.com/r/pihole/comments/bnihyz/guide_how_to_install_wireguard_on_a_raspberry_pi/ 

```
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 04EE7237B7D453EC 648ACFD622F3D138
sudo sh -c "echo 'deb http://deb.debian.org/debian/ unstable main' >> /etc/apt/sources.list.d/unstable.list"
sudo sh -c "printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' >> /etc/apt/preferences.d/limit-unstable"
sudo apt update
sudo apt install wireguard --assume-yes
```
Wireguard for buster
https://wireguard.how/server/raspbian/

keys generate 
```
(umask 077 && wg genkey > wg-private.key)
wg pubkey < wg-private.key > wg-public.key
```
