# Dotfiles-tiny

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

Config files for *tiny* branch.

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

# Creating new branch 'tiny' in 'dotfiles-local' repo:
git checkout -b tiny

# Pushing changes from local to remote new 'tiny' branch:
git push origin tiny    # or 'git push'

# Change the upstream branch you are tracking (from 'master' to 'tiny'):
git branch -u origin/tiny
```
