# General manual

## 1. Reinstall dotfiles in new machine

Go to <https://github.com/kietoparao/dotfiles-local>.

## 2. Security

### 2.1. Deny ssh root access

<https://wiki.archlinux.org/index.php/Secure_Shell#Deny>

Add the following to /etc/ssh/sshd_config:
```
PermitRootLogin no
```

### 2.2. (TODO)

<https://wiki.archlinux.org/index.php/Secure_Shell#Force_public_key_authentication>

### 2.3. TCP/IP stack hardening (TODO)

<https://wiki.archlinux.org/index.php/Sysctl#TCP.2FIP_stack_hardening>

### 2.4. Unlock locked user

Unlock a user that's locked after X failed login attempts:

```bash
usermod -U some_user #from root user
```

The lock feature has been edited in /etc/pam.d/system-login: 
<https://wiki.archlinux.org/index.php/Security#Lockout_user_after_three_failed_login_attempts>

### 2.5. Lock/unlock *root* user

```bash
# Lock:
sudo passwd -l root
# Unlock:
sudo passwd -u root
```

### 2.6. Firewall UFW

<https://wiki.archlinux.org/index.php/Uncomplicated_Firewall>

Check status with:

```bash
ufw status
```

### 2.7. iptables

File is in `/etc/iptables/iptables.rules`. Check steps done with `history | grep iptables`.

### 2.8. MAC apparmor (TODO)

<https://wiki.archlinux.org/index.php/Security#Mandatory_access_control>

### 2.9. GRUB (TODO)

<https://wiki.archlinux.org/index.php/GRUB/Tips_and_tricks#Password_protection_of_GRUB_menu>

### 2.10. GNUPG

Add the following line to ~/.gnupg/gpg.conf, in order to avoid failed signatures checks when compiling AUR packages:
```bash
keyserver-options auto-key-retrieve
```

## 3. Misc.

### 3.1. Volume

```bash
# Unmute:
amixer sset Master unmute
# Set volume to 100%:
amixer sset 'Master' 100%
```

### 3.2. Clamav antivirus

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

### 3.3. Fix fsck bootloader error

Avoid the following message:
```
The root device is not configured read-write! It may be fscked again later!
Add the "rw" before "root=[...]" line in /boot/grub/grub.cfg in Ubuntu partition
```

Solution: <https://bbs.archlinux.org/viewtopic.php?id=167153>

### 3.4. Background image

Added `~/.fehbg &` to ~/.xprofile to autostart on login. If you want to change the background image, modify .fehbg file in home folder, or run:

```bash
feh --bg-scale /path/to/image.png
```

### 3.5. Mail

Installed Postfix to use mail on console (13/07/2017). Followed this guide:
<https://www.howtoforge.com/tutorial/configure-postfix-to-use-gmail-as-a-mail-relay/#-configure-gmail-authentication>

Mail password from ra\*\*\*\*\*au@gmail.com at `/etc/postfix/sasl_passwd`.

Config at `/etc/postfix/main.cf`.

### 3.6. i3 config

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

### 3.7. Music

Install picard (graphical) and/or [beets](https://beets.readthedocs.io/en/v1.4.6/) (console), both working with musicbrainz website:

```bash
sudo pacman -S beet picard
```

### 3.8. Shell

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

#### 3.8.1. Switching to oh-my-zsh

Better shell: <https://github.com/robbyrussell/oh-my-zsh/>

Install with (it does everything for you):

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### 3.9. mysql

The setup on the `main` machine (2018-04-15) has been the following:

```bash
# Installing package
sudo pacman -S mysql
# Setup
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

Output:

```
To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system

PLEASE REMEMBER TO SET A PASSWORD FOR THE MariaDB root USER !
To do so, start the server, then issue the following commands:

'/usr/bin/mysqladmin' -u root password 'new-password'
'/usr/bin/mysqladmin' -u root -h main password 'new-password'

Alternatively you can run:
'/usr/bin/mysql_secure_installation'

which will also give you the option of removing the test
databases and anonymous user created by default.  This is
strongly recommended for production servers.

See the MariaDB Knowledgebase at http://mariadb.com/kb or the
MySQL manual for more instructions.

You can start the MariaDB daemon with:
cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'

You can test the MariaDB daemon with mysql-test-run.pl
cd '/usr/mysql-test' ; perl mysql-test-run.pl

Please report any problems at http://mariadb.org/jira

The latest information about MariaDB is available at http://mariadb.org/.
You can find additional information about the MySQL part at:
http://dev.mysql.com
Consider joining MariaDB's strong and vibrant community:
https://mariadb.org/get-involved/
```
