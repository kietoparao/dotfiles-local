#!/bin/sh
set -euo pipefail

echo "########## Installing intel drivers..."
pacman -S mesa xf86-video-intel

echo "########## Installing xorg..."
pacman -S xorg

echo "########## Setting the xorg keyboard keymap..."
localectl --no-convert set-x11-keymap es pc104,pc105 ,cat terminate:ctrl_alt_bksp

echo "########## Installing i3 window manager..."
pacman -S i3

echo "########## Installing display manager..."
pacman -S lightdm lightdm-gtk-greeter

echo "########## Enabling ligthdm display manager at boot..."
systemctl enable lightdm.service

echo "########## Installing basic packages..."
pacman -S firefox weechat htop rxvt-unicode termite rofi pcmanfm gvfs xarchiver gnome-themes-standard flameshot

echo "########## Installing packages from "Packages" file on the root / dir..."
xargs -a /Packages pacman -S --noconfirm --needed
