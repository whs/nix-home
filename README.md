# Home Manager
This is my [Home Manager](https://nix-community.github.io/home-manager/) configuration. It is not intended to be use by someone else, but you could look at it for examples.

## Installing

```sh
cp example-home.nix ~/.config/home-manager/home.nix
ln -s `pwd`/common.nix ~/.config/home-manager/common.nix
if [ -d /mnt/c/Windows ]; then ln -s `pwd`/wsl.nix ~/.config/home-manager/wsl.nix; fi
home-manager build
~/.nix-profile/bin/zsh # Use this shell
```

For per-host configuration, store them in home.nix

## Locale

There's a problem with zsh locale that I couldn't fix. To fix this, ensure that your locale supports en_US.UTF-8
even without Nix. Otherwise, zsh will complain about characters.
