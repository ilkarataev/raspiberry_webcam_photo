# raspiberry_webcam_photo
### Описание проекта
Этот проект создан для автоматического снятия показания и отправки в Телеграм, или просмотр на веб странице т.к. я не нашел готовой инструкции решил описать проект.
Ввеб Ввеб железа используется я использовал raspiberry pi one model b+(отданный в подарок), уверен в работе на любом другом одноплатнике.

Проблемы:ы
  Были сложности с настройкой wifi и установка wireguard для доступа через vpn. 

Оборудование:
  Необходимо вебкамебра и можно кусок светодиодной ленты или 2 светодиода т.к. питание будет от 3х вольт, У меня был кусок ленты от переделки аквариумной лампы, его и использовал.

Советы: После настройки не забудьте настроить монтирование раздела /tmp в /tmpfs т.к. туда сохраняется и перезаписывается при обновление картинка с камеры, также можно активировать overlay в режим если вы используете raspberry pi одноплатный ПК. 

В проект используется ПО:
    1. nginx  
    2. php-fpm  
    3. fswebcam  
    4. Usb camera plug in.  
    5. Gpio4 enable light(light+3.3v PIN 1. GPIO4 GND PIN 7)  
![alt text](https://github.com/ilkarataev/raspiberry_webcam_photo/blob/master/img/board.jpg)

Фото с добавленными светодиодами, включение регулируется через актвирование GIPO, подаем GND(землю) через пин GPIO4.(если у вас другой одноплатник нужно сменить пин в скрипте webcam.sh и и autostart.sh)
![alt text](https://github.com/ilkarataev/raspiberry_webcam_photo/blob/master/img/pilight1.jpg)  
![alt text](https://github.com/ilkarataev/raspiberry_webcam_photo/blob/master/img/pilight2.jpg)  
### Для установка необходим curl, просто копируете скрипт автоматической установки. 
```curl https://raw.githubusercontent.com/ilkarataev/raspiberrypi_camera_shot/master/install.bash| /bin/bash -x  ```  
###  Я использую wifi модуль rt5320 т.к. другие модули требую установки и сборки драйверов, проще купить закать необходимый, т.к. устновка происходила в ванной  необходим был  wifi модуль.Необходимо только установить пакет ```apt install firmware-ralink``` и настроить wifi интерфейс:  
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
Для отправки сообщений в телеграм через планировщик необходимо скопировать скрипт из репозитория, сделать его исполняемым и добавить задачу в crontab.
Для отправки в телеграмм необходимо знать BotToken,chatid.Script и исправить в telegram.sh  
```
Скопируйте скрипт в репозиторий /root/ 
chmod +x telegram.sh
```
Add to crontab

0 0 19 . /root/telegram.sh

Я использовал wireguard для подключения pi к моему серверу, я был очень разочеровен т.к. мне пришлось потратить много времени на настройку. Процессор на моей плате считается устаревшим поэтому нужно сбилдить часть файлов.

Далее инструкция по настройки wireguard.
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
