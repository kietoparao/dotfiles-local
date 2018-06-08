# Dotfiles-portable

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

Config files for *portable* branch.

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

# Creating new branch 'portable' in 'dotfiles-local' repo:
git checkout -b portable

# Pushing changes from local to remote new 'portable' branch:
git push origin portable    # or 'git push'

# Change the upstream branch you’re tracking (from 'master' to 'portable'):
git branch -u origin/portable
```
