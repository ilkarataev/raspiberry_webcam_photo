#!/bin/bash

if [[ -f "/etc/armbian-release" ]]; then
    phpv=7.2
else
    phpv=7.3
fi

apt update && apt upgrade -y
apt install git nginx php${phpv}-fpm fswebcam vim -y
usermod -a -G video www-data 
usermod -a -G gpio www-data 
mkdir /var/www/pi/

cd /root && git clone https://github.com/ilkarataev/raspiberrypi_camera_shot.git
if [[ "${phpv}" == "7.2" ]]; then
    sed -i 's|fswebcam -r 1280x720 --no-banner /tmp/viewcam.jpg|fswebcam -d /dev/video2 -r 1280x720 --no-banner /tmp/viewcam.jpg|' /root/raspiberrypi_camera_shot/server_script/webcam.sh
fi

cp -r /root/raspiberrypi_camera_shot/server_script/* /var/www/pi/
cp -r /root/raspiberrypi_camera_shot/gpio/autostart.sh  /etc/init.d/
chmod 755  /etc/init.d/autostart.sh
cp /root/raspiberrypi_camera_shot/nginx/camera.conf /etc/nginx/sites-available/
cp /root/raspiberrypi_camera_shot/php-fpm/www.conf /etc/php/${phpv}/fpm/pool.d/
ln -s /etc/nginx/sites-available/camera.conf /etc/nginx/sites-enabled/camera.conf
rm /etc/nginx/sites-enabled/default
chown -R www-data:www-data /var/www/pi
chmod 755  /var/www/pi/index.php /var/www/pi/camera.sh
service nginx reload
service php${phpv}-fpm restart
update-rc.d autostart.sh defaults
reboot