#!/bin/bash -e

# Do raspi-configgy things
# Sam reports the "desktop" gl driver gives better performance
raspi-config nonint do_gldriver G2

# 0 means enabled, based on UTSL (because it's a UNIX exit status, where 0 means success)
raspi-config nonint do_spi 0
raspi-config nonint do_net_names 0
