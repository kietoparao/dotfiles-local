# Dotfiles-local

After cloning this repo, run `install` to automatically set up the development environment. Note that the install script is idempotent: it can safely be run multiple times.

Dotfiles uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

Further instructions are in [dotfiles personal repo](https://github.com/kietoparao/dotfiles).

### Saving changes to different branches

<https://help.github.com/articles/pushing-to-a-remote/>

You can push changes when working in different branches (*main*, *portable*, *tiny*, etc.) doing the following:

```bash
# If origin=https://github.com/kietoparao/dotfiles-local.git:
git remote -v

# Then, for the 'main' branch:
git push origin main

# For the 'portable' branch:
git push origin portable

# And so on...
```
