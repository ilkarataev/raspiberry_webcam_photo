#!/bin/sh

# /etc/init.d/pirservice.sh

### BEGIN INIT INFO
# Provides:          myservice
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Put a short description of the service here
# Description:       Put a long description of the service here
### END INIT INFO

# Change the next 3 lines to suit where you install your script and what you want to     call it
echo 04 > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio4/direction
echo 0 > /sys/class/gpio/gpio4/value
sleep 5
echo 1 > /sys/class/gpio/gpio4/value
exit 0
