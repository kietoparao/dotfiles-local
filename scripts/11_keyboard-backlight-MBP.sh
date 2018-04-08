#!/bin/sh

echo "########## Installing kbdlight..."
git clone https://aur.archlinux.org/kbdlight.git
cd kbdlight
makepkg -si

# Add the following to .xbindkeysrc file in ~, without the first character in each line:
#"kbdlight up 5"
#   XF86KbdBrightnessUp

#"kbdlight down 5"
#   XF86KbdBrightnessDown
