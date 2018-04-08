#==============================================
# OPTIONS FOR C COMPILER (for package building)
#==============================================
# Date: 2018-03-04
# Guides at https://wiki.archlinux.org/index.php/Makepkg & https://linux.die.net/man/1/gcc

# TIPS FOR OPTIMIZING BUILDING TIMES

# Modify the following config file for makepkg...
sudo nano /etc/makepkg.conf 
# ... to remove any -mtune and -march flags, and then add the following flag:
-march=native
