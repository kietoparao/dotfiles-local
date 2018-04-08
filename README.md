# Dotfiles-local

After cloning this repo, run `install` to automatically set up the development environment. Note that the install script is idempotent: it can safely be run multiple times.

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

Further instructions are in [dotfiles personal repo](https://github.com/kietoparao/dotfiles).

### Saving changes to different branches

<https://help.github.com/articles/pushing-to-a-remote/>

You can push changes when working in different branches (*main*, *portable*, *tiny*, etc.) doing the following:

```bash
# Checking if origin=https://github.com/kietoparao/dotfiles-local.git:
git remote -v

# Then, for the 'main' branch:
git checkout -b main    # Creating and moving to 'main' branch from 'master' branch
git branch -u origin/main   # set remote upstream tracking to new 'main' branch
git push origin main

# For the 'portable' branch:
git checkout -b portable
git branch -u origin/portable
git push origin portable

# And so on...
```
