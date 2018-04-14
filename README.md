# Dotfiles-netbook

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

Config files for *netbook* branch.

## Setup from remote dotfiles-local repo

Remote repo that has been branched: <https://github.com/kietoparao/dotfiles-local.git>.

Also used the [init_dotfiles.sh](https://github.com/Vaelatern/init-dotfiles) script for dotbot initial config.

```bash
cd ~

# Creating the ~/.dotfiles dotbot git repo: 
curl -fsSLO https://raw.githubusercontent.com/Vaelatern/init-dotfiles/master/init_dotfiles.sh
./init_dotfiles.sh

# Entering the newly created repo:
cd ~/.dotfiles

# Adding the remote repo to track:
git remote add origin https://github.com/kietoparao/dotfiles-local.git

# Creating new branch 'netbook' in 'dotfiles-local' repo:
git checkout -b netbook

# Pushing changes from local to remote new 'netbook' branch:
git push origin netbook    # or 'git push'

# Change the upstream branch you’re tracking (from 'master' to 'netbook'):
git branch -u origin/netbook
```
