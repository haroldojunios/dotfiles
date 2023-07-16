#!/bin/sh

if ! command -v chezmoi >/dev/null; then
  if command -v termux-setup-storage >/dev/null; then
    apt update
    apt install -y chezmoi
  else
    if [ -f /etc/os-release ]; then
      ID=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
      IDLIKE=$(grep -oP '(?<=^ID_LIKE=).+' /etc/os-release | tr -d '"')
      if [ "$ID" = arch ] || [ "$IDLIKE" = arch ]; then
        sudo pacman -Syy
        sudo pacman -S --noconfirm --needed chezmoi
      fi
    fi
  fi
fi

if command -v chezmoi >/dev/null; then
  chezmoi init --apply haroldojunios
else
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply haroldojunios
fi
