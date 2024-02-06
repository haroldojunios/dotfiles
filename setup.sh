#!/bin/sh

if ! command -v chezmoi >/dev/null; then
  if command -v termux-setup-storage >/dev/null; then
    apt update
    apt install -y chezmoi
  elif command -v pacman >/dev/null; then
    sudo pacman -Sy
    sudo pacman -S --noconfirm --needed chezmoi
  elif command -v apt-get >/dev/null; then
    sudo apt-get update
  fi
fi

export PATH=$PATH:"${HOME}/.local/bin"

if command -v chezmoi >/dev/null; then
  chezmoi init --apply haroldojunios
else
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ${HOME}/.local/bin init --apply haroldojunios
fi
