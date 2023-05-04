#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if ! command -v chezmoi &>/dev/null; then
  if command -v termux-setup-storage; then
    apt update
    apt install -y chezmoi
  else
    if [ -f /etc/os-release ]; then
      ID=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
      IDLIKE=$(grep -oP '(?<=^ID_LIKE=).+' /etc/os-release | tr -d '"')
      if [ "$ID" = ubuntu ] || [ "$IDLIKE" = ubuntu ]; then
        sudo apt-get update
        sudo apt-get install -y chezmoi
      elif [ "$ID" = arch ] || [ "$IDLIKE" = arch ]; then
        sudo pacman -Syy
        sudo pacman -S --noconfirm --needed chezmoi
      fi
    fi
  fi
fi

if command -v chezmoi &>/dev/null; then
  chezmoi init --apply haroldojunios
else
  echo -e "${RED}Could not find ${BLUE}chezmoi ${RED}binary!${NC}"
fi
