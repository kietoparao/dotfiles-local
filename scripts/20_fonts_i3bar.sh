#======================
# MAIN FONT
#======================
# Install inconsolata font:
pacman -S ttf-inconsolata

# OR terminus-font:
pacman -S terminus-font

# Check the font name to add to ~/.config/i3/config. 'bar' section:
fc-query -f '%{family}\n' /usr/share/fonts/TTF/Inconsolata-Regular.ttf

#======================
# ICONS
#======================

# Install otf-font-awesome to fix this issue with TTF
# Font Awesome v5 https://bugs.archlinux.org/task/56899:
pacman -S otf-font-awesome

# Add the following line inside 'bar{' on ~/.config/i3/config:
font pango:Inconsolata, FontAwesome 12

# On urvxt terminal, add the icons on i3bar (/etc/i3status.conf) 
# by holding Ctrl+Shift and the letter+number of the icon on the
# cheatsheet https://fontawesome.com/cheatsheet.


# ALTERNATIVES TO FONT AWESOME

# ttf-ionicons [community]
# https://aur.archlinux.org/packages/ttf-font-icons/ [aur]
# terminus-font [community] - don't know if it supports icons
