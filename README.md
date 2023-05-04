# Dotfiles

To setup the dotfiles through the `setup.sh` script run:

```sh
sh -c "$(curl -fsLS bit.ly/hjdots)"
```

To setup the dotfiles through chezmoi install script run:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply haroldojunios
```
