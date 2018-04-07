#!/bin/sh
echo "########## Saving native pkglist ('Packages') and AUR pkglist ('Packages.aur)..."
pacman -Qqen > Packages
pacman -Qqm > Packages.aur
