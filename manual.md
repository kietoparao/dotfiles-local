\newpage

# General manual

Generated PDF with the following commands:

```bash
# Include table of contents with depth 4, and 1 inch margin
pandoc manual.md -o manual.pdf --toc --toc-depth=4 -V geometry:margin=1in
```

\newpage

## 1. Reinstall dotfiles in new machine

Go to <https://github.com/kietoparao/dotfiles-local>.

## 2. Security

### 2.1. SSH

#### 2.1.1. Deny ssh root access

<https://wiki.archlinux.org/index.php/Secure_Shell#Deny>

Add the following to /etc/ssh/sshd_config:
```
PermitRootLogin no
```

#### 2.1.2. Disable Password Authentication (TODO)

<https://wiki.archlinux.org/index.php/Secure_Shell#Force_public_key_authentication>

### 2.2. GnuPG

Add the following line to ~/.gnupg/gpg.conf, in order to avoid failed signatures checks when compiling AUR packages:
```bash
keyserver-options auto-key-retrieve
```

To list gpg keys:

```bash
# List all keys
gpg --list-keys

# List only private keys
gpg --list-secret-keys
```

### 2.3. TCP/IP stack hardening (TODO)

<https://wiki.archlinux.org/index.php/Sysctl#TCP.2FIP_stack_hardening>

### 2.4. Lock/unlock users

#### 2.4.1. Unlock locked user

Unlock a user that's locked after X failed login attempts:

```bash
usermod -U some_user #from root user
```

The lock feature has been edited in /etc/pam.d/system-login: 
<https://wiki.archlinux.org/index.php/Security#Lockout_user_after_three_failed_login_attempts>

#### 2.4.2. Lock/unlock *root* user

```bash
# Lock:
sudo passwd -l root
# Unlock:
sudo passwd -u root
```

### 2.5. Firewalls

#### 2.5.1. UFW

<https://wiki.archlinux.org/index.php/Uncomplicated_Firewall>

Check status with:

```bash
ufw status
```

#### 2.5.2. iptables

File is in `/etc/iptables/iptables.rules`. Check steps done with `history | grep iptables`.

### 2.6. MAC apparmor (TODO)

<https://wiki.archlinux.org/index.php/Security#Mandatory_access_control>

### 2.7. Bootloaders (TODO)

#### 2.7.1. GRUB

<https://wiki.archlinux.org/index.php/GRUB/Tips_and_tricks#Password_protection_of_GRUB_menu>

#### 2.7.2. EFI

Guides from:

* <https://wiki.archlinux.org/index.php/EFI_System_Partition>
* <https://wiki.archlinux.org/index.php/REFInd>

Download rEFInd from <http://www.rodsbooks.com/refind/> (e.g. 
<http://sourceforge.net/projects/refind/files/0.11.2/refind-bin-0.11.2.zip/download>).

```bash
# After extracting the zip file, enter the directory
cd refind-bin-0.11.2/

# Execute refind-install script from the Mac
./refind-install
```

Basically, the ESP is located under `/boot/efi` on Linux, and under `/Volumes/ESP` 
on a Mac.

After rEFInd installation, try to boot into Linux with the Archiso by mounting 
the linux partition (`mount /dev/sda5 /mnt`), `arch-chroot /mnt` into it and 
running the `mkrlconf` script that can also be found on `refind-bin-0.11.2/` 
directory. This will generate a `refind-linux.conf` under `/boot`, that you can 
configure to set boot instructions for rEFInd.

### 2.8. Password Manager

Install "pass" package on Arch repo. Guide from 
<https://lists.zx2c4.com/pipermail/password-store/2015-January/001331.html>

Bare git repo created in `osmc@192.168.1.133:/home/osmc/git/contrasenyes`
We will use this bare git repo to `git push` to it from the local machine.

On the server machine:

```bash
cd ~
mkdir git
mkdir git/contrasenyes
cd git/contrasenyes
git init --bare
```

On the local machine:

```bash
# Find your gpgID with "gpg --list-secret-keys" and copy it here
pass init [gpgID]
pass git init

# Tell git where is the bare repo in the server and push to initialize everything
pass git remote add origin ssh://osmc@192.168.1.133:~/git/contrasenyes
cd ~/.password-store
git push --set-upstream origin master
```

Set up a git hook that runs every time there is a new commit. This hook
first fetches any changes we don't have locally, then rebases our recent
local commit on top of those changes, then sends it all back to the server.

```bash
echo git pull --rebase > .password-store/.git/hooks/post-commit
echo git push >> .password-store/.git/hooks/post-commit
chmod u+x .password-store/.git/hooks/post-commit

# Export the private gpg key from the git repo (remote server raspberry)
gpg --export-secret-keys > private.key
```

Import the `private.key` file into Openkeychain app on the phone. After that, 
you will be able to decrypt and view the passwords pulled from the git repo.

Install on the phone the app "Android Password Store" 
(<https://github.com/zeapo/Android-Password-Store#readme>)

Setup the server config, and all set!

#### Usage

```bash
# Show all the saved passwords
pass

# Write a new password with multiline support
pass insert -m Dir/subdir/username

# Edit a password
pass edit Dir/subdir/username

# Remove a password
pass rm Dir/subdir/username

# Generate a new password of N length of characters
pass generate Dir/subdir/username N
```

\newpage

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

In EFI systems, the solution will be a bit different: you need to set the `rw` 
option in the `/boot/refind-linux.conf`.

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

### 3.9. MySQL

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

### 3.10. Rename pictures with exiv2

Rename all pictures that start with `IMG_` with the formatted timestamp:

```bash
exiv2 -tFv -r %Y-%m-%d_%H%M%S IMG_*
```

Example of output:
```bash
File 001/755: IMG_31122014_223643.jpg
Renaming file to ./2014-12-31_223643.jpg, updating timestamp
```

