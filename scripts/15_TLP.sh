#==============================
# TLP CONFIG (only for laptop)
#==============================
# Guide at https://wiki.archlinux.org/index.php/TLP

# Install TLP and optional dependencies:
pacman -S tlp
pacman -S ethtool x86_energy_perf_policy lsb-release smartmontools

# Enable tlp systemd units for TLP
sudo systemctl enable tlp.service
sudo systemctl enable tlp-sleep.service

# Mask rfkill service & socket to avoid conflicts:
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket
