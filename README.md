# raspiberry_webcam_photo
This repository have script and instruction to get image from usb camera rasberrypi

Project needs
    1. nginx  
    2. php-fpm  
    3.fswebcam  
    4. Usb camera plug in.  
    5. Gpio4 enable light(light+3.3v PIN 1. GPIO4 GND PIN 7)  
![alt text](https://github.com/ilkarataev/raspiberry_webcam_photo/blob/master/img/board.jpg)

To install on rasberry pi model B  
```curl https://raw.githubusercontent.com/ilkarataev/raspiberrypi_camera_shot/master/install.bash| /bin/bash -x  ```

The best way use wifi module that working without any drivers install.I used rt5320.  
Need configurate wifi inteface.  
add to /etc/network/interfaces.d/wlan0 or /etc/network/interfaces  
```
auto lo
iface lo inet loopback
iface eth0 inet dhcp
auto wlan0
allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
```  
And  /etc/wpa_supplicant/wpa_supplicant.conf
```
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
network={
  ssid="ssid_name"
  psk="password"
}
```
