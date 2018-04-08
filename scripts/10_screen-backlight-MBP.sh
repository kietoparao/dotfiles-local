#!/bin/sh

# INFO https://wiki.archlinux.org/index.php/Backlight

echo "########## Adding username to 'video' group ..."
echo "########## Please write your username:"
read username
gpasswd -a $username video

#If you get the "No outputs have backlight property" error, it is because xrandr/xbacklight does not choose the right directory in /sys/class/backlight. You can specify the direct$

#/etc/X11/xorg.conf

#Section "Device"
#    Identifier  "Card0"
#    Driver      "intel"
#    Option      "Backlight"  "intel_backlight"
#EndSection


# To adjust screen brightness on MBP, you can change the number as root in:
# /sys/class/backlight/intel_backlight/brightness

# To set brightness level at 50%:
# xbacklight -set 50

# To increase or decrease brightness by percentage diff:
# xbacklight -inc 20
# xbacklight -dec 20

# To assign these commands to keys on the keyboard:
# https://wiki.archlinux.org/index.php/Extra_keyboard_keys_in_Xorg
# Install xbindkeys package https://wiki.archlinux.org/index.php/Xbindkeys
# Find particular keycodes pressing that key after running:

# xbindkeys -k
# OR
# xev

# Add them to ~/.xbindkeysrc as described in https://wiki.archlinux.org/index.php/Xbindkeys#Identifying_keycodes
pacman -S xbindkeys
echo "##### Write your username:"
read username
xbindkeys --defaults > /home/$username/.xbindkeysrc

echo "##########  Making changes permanent in /etc/profile:"
sudo echo "xbindkeys" >> /etc/profile
