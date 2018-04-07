#!/bin/sh
# MORE INFO: https://wiki.archlinux.org/index.php/SANE

# Installing the packages:
pacman -S sane cups hplip sane-frontends foomatic-db foomatic-db-ppds xsane xsane-gimp rpcbind

# Testing if 'sane' recognizes the network scanner:
sane-find-scanner
# Probably the above command doesn't work, so try the other one:
scanimage -L

# Scan a document by command-line orders:
scanimage --format=png > test.png

# Scan documents by running xsane graphical frontend:
xsane

# OR by running:
hp-scan
