#!/bin/sh

# Configure the Macbook's touchpad with libinput
# https://wiki.archlinux.org/index.php/Libinput

# To determine the id number of the device you want (in this case, the touchpad):
# xinput list

# We find that the touchpad device's name is "bcm5974" (id=11)
# xinput list-props 11
# OR
# xinput list-props bcm5974

# Two lines from those commands show the following:
# libinput Tapping Enabled (279): 0
# libinput Natural Scrolling Enabled (287): 0

# Enable tapping:                                     
# xinput set-prop 11 279 1

# Enable natural scrolling
# xinput set-prop 11 287 1

# Make changes permanent in /etc/X11/xorg.conf.d/30-touchpad.conf
# Add the following text as sudo user:
# Section "InputClass"
#         Identifier "bcm5974"
#         MatchIsTouchpad "on"
#         MatchDevicePath "/dev/input/event16"
#         Driver "libinput"
#         Option "Tapping" "1"
#         Option "NaturalScrolling" "1"
#         Option "AccelSpeed" "0.5"
# EndSection
