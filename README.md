# raspiberrypi_camera_shot
This repository have script and instruction to get image from usb camera rasberrypi

Project needs
    1. nginx  
    2. php-fpm  
    3.fswebcam  
    4. Usb camera plug in.  
    5. Gpio4 enable light(light+5v gpio4 GND)  

To install on rasberry pi model B  
curl https://raw.githubusercontent.com/ilkarataev/raspiberrypi_camera_shot/master/install.bash| /bin/bash -x  

Asus n10 wifi driver RTL8192SU   
#Downloads the installation file  
```sudo wget http://downloads.fars-robotics.net/wifi-drivers/install-wifi -O /usr/bin/install-wifi```  
```sudo chmod +x /usr/bin/install-wifi ```  
#Installation process
```sudo install-wifi -c rpi-update``` - check for driver if rpi-update is run
```sudo rpi-update``` - if a driver is available you can run rpi-update to update firmware.  
```sudo install-wifi -u rpi-update``` - then update the driver for the new kernel installed by rpi-update.  
``` sudo reboot``` - now reboot to update the kernel with the new wifi driver.

