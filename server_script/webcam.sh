#!/usr/bin/sh
echo 0 > /sys/class/gpio/gpio4/value
fswebcam -r 1280x720 --no-banner /tmp/viewcam.jpg
echo 1 > /sys/class/gpio/gpio4/value
