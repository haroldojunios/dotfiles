# shellcheck shell=bash
export DEBIAN_FRONTEND=noninteractive

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

sudo apt-get update
sudo apt-get full-upgrade -y

dePackageList=(
  xserver-xorg
  raspberrypi-ui-mods
  rpi-chromium-mods
  lxterminal
  python3-tk
)

packageList=(
  age
  bat
  bc
  clang
  cmake
  crudini
  curl
  ffmpeg
  fish
  git
  i2c-tools
  imagemagick
  jq
  make
  micro
  mosquitto
  mosquitto-clients
  nano
  ninja-build
  openssh-server
  p7zip
  python-is-python3
  python3-dev
  python3-pip
  python3-rpi-lgpio
  python3-smbus
  python3-venv
  shfmt
  sshfs
  tmux
  unzip
  wget
  xclip
  zip
)

{{ if .installDE }}
packageList=(
  "${dePackageList[@]}"
  "${packageList[@]}"
)
{{ end }}

for package in "${packageList[@]}"; do
  if ! dpkg -s ${package} &>/dev/null; then
    echo -e "${GREEN}Installing package ${BLUE}${package} ${GREEN}...${NC}"
    sudo apt-get install -y ${package} || echo -e "${RED}Package ${BLUE}${package} ${RED}not found!${NC}"
  fi
done

if ! command -v bat &>/dev/null && ! [ -f "${HOME}/.local/bin/bat" ]; then
  mkdir -p "${HOME}/.local/bin"
  ln -s /usr/bin/batcat "${HOME}/.local/bin/bat"
fi

sudo apt-get autoremove -y
sudo apt-get clean -y
