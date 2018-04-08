# Dotfiles

After cloning this repo, run `install` to automatically set up the development environment. Note that the install script is idempotent: it can safely be run multiple times.

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.


### Adding more files to this system

When wanting to add more files of your local machine to be tracked by git, run the following commands from the ~/.dotfiles local repo:

```bash
# Example adding the '~/.xprofile' file

# Add the following lines to the '- link' line in 'install.conf.yaml':
- link:
    ~/.xprofile: xprofile
```

```bash
cd ~/.dotfiles
# These two next steps can be omitted:
mkdir -p xprofile
rmdir xprofile

mv ~/.xprofile xprofile

# Run the dotbot script to create the symlink:
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

### Adding files in subdirectories

When the *dotfile* you want to track is not in the $HOME (~) directory but is instead in some subdirectories from $HOME, the steps are a little different:

```bash
# Example adding the '~/.config/i3/' files

# Add the following lines to the '- link' line in 'install.conf.yaml':
- link:
    ~/.xprofile: xprofile
    ~/.config/i3:
        path: config/i3/
        create: true
```

```bash
cd ~/.dotfiles
# These two next steps can be omitted:
mkdir -p config/i3/ 
rmdir config/i3/

mv ~/.config/i3 config/i3/

# Run the dotbot script to create the symlink:
./install
```

## Git actions

### Adding and commiting changes

The regular git way:
```bash
git add -A    # or 'git add .'
git commit -m 'Custom commit message'
```

### Setting up remote repo as origin

This remote github repo has been populated from the local machine using the following commands:
```bash
git remote add origin https://github.com/kietoparao/dotfiles.git
git push -u origin master
```

### Saving changes remotely

When the remote repo has been setup, you can push changes to it:
```bash
git push    # Or 'git push origin master'
```

## Useful links

* [The best way to store your dotfiles: A bare Git repository](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)

* [Managing Your Dotfiles](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/)

* [Init Dotfiles (dotbot helper)](https://github.com/Vaelatern/init-dotfiles)

* [Using machine-specific configs](https://github.com/anishathalye/dotbot/pull/11#issuecomment-73082152)

