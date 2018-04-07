# Dotfiles

After cloning this repo, run `install` to automatically set up the development environment. Note that the install script is idempotent: it can safely be run multiple times.

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Adding more files to this system

When wanting to add more files of your local machine to be tracked by git, run the following from the ~/.dotfiles local repo:

```bash
# Example adding the '~/.xprofile' file:
cd ~/.dotfiles
mkdir -p xprofile
rmdir xprofile
mv ~/.xprofile xprofile
./install
```

The output after the `./install` command should look like this:
```bash
All targets have been cleaned
Link exists ~/.bash_profile -> /home/xxxx/.dotfiles/bash_profile
Link exists ~/.bashrc -> /home/xxxx/.dotfiles/bashrc
Link exists ~/.bash_logout -> /home/xxxx/.dotfiles/bash_logout
Link exists ~/.Xresources -> /home/xxxx/.dotfiles/Xresources
Creating link ~/.xprofile -> /home/xxxx/.dotfiles/xprofile
Link exists ~/.gnupg/gpg.conf -> /home/xxxx/.dotfiles/gpg.conf
Link exists ~/.config/i3 -> /home/xxxx/.dotfiles/config/i3/
Link exists ~/.config/i3status -> /home/xxxx/.dotfiles/config/i3status/
All links have been set up

==> All tasks executed successfully
```

## Adding and commiting changes

The regular git way:
```bash
git add -A
git commit -m 'Custom commit message'
```

## Setting up remote repo as origin

This remote github repo has been populated from the local machine using the following commands:
```bash
git remote add origin https://github.com/kietoparao/dotfiles.git
git push -u origin master
```

## Saving changes remotely

When the remote repo has been setup, you can push changes to it:
```bash
git push origin master  # Or only 'git push'
```
