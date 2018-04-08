# General manual

## Reinstall dotfiles in new machine

Go to <https://github.com/kietoparao/dotfiles-local>.

## Security

### Deny ssh root access

<https://wiki.archlinux.org/index.php/Secure_Shell#Deny>

Add the following to /etc/ssh/sshd_config:
```
PermitRootLogin no
```

### (TODO)

<https://wiki.archlinux.org/index.php/Secure_Shell#Force_public_key_authentication>

### TCP/IP stack hardening (TODO)

<https://wiki.archlinux.org/index.php/Sysctl#TCP.2FIP_stack_hardening>

### Unlock locked user

Unlock a user that's locked after X failed login attempts:

```bash
usermod -U some_user #from root user
```

The lock feature has been edited in /etc/pam.d/system-login: 
<https://wiki.archlinux.org/index.php/Security#Lockout_user_after_three_failed_login_attempts>

### Lock/unlock *root* user

```bash
# Lock:
sudo passwd -l root
# Unlock:
sudo passwd -u root
```

### Firewall UFW

<https://wiki.archlinux.org/index.php/Uncomplicated_Firewall>

Check status with:

```bash
ufw status
```

### iptables

File is in `/etc/iptables/iptables.rules`. Check steps done with `history | grep iptables`.

### MAC apparmor (TODO)

<https://wiki.archlinux.org/index.php/Security#Mandatory_access_control>

### GRUB (TODO)

<https://wiki.archlinux.org/index.php/GRUB/Tips_and_tricks#Password_protection_of_GRUB_menu>

### GNUPG

Add the following line to ~/.gnupg/gpg.conf, in order to avoid failed signatures checks when compiling AUR packages:
```bash
keyserver-options auto-key-retrieve
```

## Misc.

### Volume

```bash
# Unmute:
amixer sset Master unmute
# Set volume to 100%:
amixer sset 'Master' 100%
```

### Clamav antivirus

Initial config:

```bash
sudo freshclam
sudo systemctl start clamd.service
sudo systemctl enable clamd.service
# Test with harmless file:
curl http://www.eicar.org/download/eicar.com.txt | clamscan -
# Scan files/folders:
clamscan myfile
clamscan -r -i /home #same as --recursive --infected
```

### Fix fsck bootloader error

Avoid the following message:
```
The root device is not configured read-write! It may be fscked again later!
Add the "rw" before "root=[...]" line in /boot/grub/grub.cfg in Ubuntu partition
```

Solution: <https://bbs.archlinux.org/viewtopic.php?id=167153>

### Background image

Added `~/.fehbg &` to ~/.xprofile to autostart on login. If you want to change the background image, modify .fehbg file in home folder, or run:

```bash
feh --bg-scale /path/to/image.png
```

### Mail

Installed Postfix to use mail on console (13/07/2017). Followed this guide:
<https://www.howtoforge.com/tutorial/configure-postfix-to-use-gmail-as-a-mail-relay/#-configure-gmail-authentication>

Mail password from ra\*\*\*\*\*au@gmail.com at `/etc/postfix/sasl_passwd`.

Config at `/etc/postfix/main.cf`.

### i3 config

Modify the i3 config file, key bindings and so on...

```bash
nano .config/i3/config
```

Modify setting in i3bar:

```bash
mkdir ~/.config/i3status
cp /etc/i3status.conf .config/i3status/config
nano .config/i3status/config
```

### Music

Install picard (graphical) and/or [beets](https://beets.readthedocs.io/en/v1.4.6/) (console), both working with musicbrainz website:

```bash
sudo pacman -S beet picard
```

### Shell

Changing between shells (bash and zsh):
<https://wiki.archlinux.org/index.php/Command-line_shell#Changing_your_default_shell>

```bash
# Listing available shells:
chsh -l

# From /bin/bash shell environment, change to zsh:
chsh -s /bin/zsh

# From bash shell, use zsh shell:
zsh

# From zsh shell, use bash shell:
bash
```

#### Switching to oh-my-zsh

Better shell: <https://github.com/robbyrussell/oh-my-zsh/>

Install with (it does everything for you):

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
