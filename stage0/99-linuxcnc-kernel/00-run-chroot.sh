#!/bin/bash -e

apt-get remove -y raspberrypi-kernel || true
apt-get install -y wget

# TODO get kernel from a proper apt repository
wget -O /tmp/kernel.deb https://media.unpythonic.net/pi4-kernel-pkg/linux-image-4.19.71-rt24-v7l+_4.19.71-rt24-v7l+-4_armhf.deb

dpkg -i /tmp/kernel.deb

rm -f /tmp/kernel.deb
