#!/bin/bash -e

wget -O /tmp/linuxcnc.deb https://media.unpythonic.net/pi4-linuxcnc-pkg/linuxcnc-uspace_2.9.0~pre0_armhf.deb
wget -O /tmp/linuxcnc-dev.deb https://media.unpythonic.net/pi4-linuxcnc-pkg/linuxcnc-uspace-dev_2.9.0~pre0_armhf.deb
wget -O /tmp/kernel.deb https://media.unpythonic.net/pi4-kernel-pkg/linux-image-4.19.71-rt24-v7l+_4.19.71-rt24-v7l+-3_armhf.deb

dpkg -i /tmp/linuxcnc.deb /tmp/linuxcnc-dev.deb /tmp/kernel.deb || true
apt -f install

rm -f /tmp/linuxcnc.deb /tmp/linuxcnc-dev.deb /tmp/kernel.deb

# Default to the RT kernel
printf '[all]\ninclude config-rt.txt\n' >> /boot/config.txt
printf '[pi4]\nkernel=vmlinuz-4.19.71-rt24-v7l+\nforce_turbo=1\n' >> /boot/config-rt.txt

# Add necessary kernel configuration
sed -i  '1s/$/ isolcpus=3 idle=poll/' /boot/cmdline.txt

# Do raspi-configgy things
# Sam reports the "desktop" gl driver gives better performance
raspi-config nonint do_gldriver G2

# 0 means enabled, based on UTSL (because it's a UNIX exit status, where 0 means success)
raspi-config nonint do_spi 0
raspi-config nonint do_net_names 0
