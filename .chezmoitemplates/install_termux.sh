# shellcheck shell=bash
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

apt-get update
apt-get upgrade -y --option Dpkg::Options::=--force-confold --option Dpkg::Options::=--force-confdef

packageList=(
  7zip
  age
  bat
  binutils
  clang
  cmake
  cronie
  curl
  eza
  ffmpeg
  fish
  git
  imagemagick
  jq
  make
  matplotlib
  micro
  nano
  ncdu
  net-tools
  ninja
  openssh
  python
  python-numpy
  python-pandas
  python-pillow
  python-pip
  python-scipy
  rclone
  rsync
  starship
  termux-api
  tmux
  unzip
  wget
  which
  zip
)
# desktop enviroment
dePackageList=(
  # x11
  x11-repo
  termux-x11-nightly
  tigervnc
  # xfce
  xfce4
  xfce4-screenshooter
  xfce4-terminal
  xfce4-whiskermenu-plugin
  # other gui apps/plugins
  keepassxc
)

{{ if .installDE }}
packageList=(
  "${packageList[@]}"
  "${dePackageList[@]}"
)
{{ end }}

for package in "${packageList[@]}"; do
  if ! dpkg -s ${package} &>/dev/null; then
    echo -e "${GREEN}Installing package ${BLUE}${package} ${GREEN}...${NC}"
    apt-get install -y ${package} || echo -e "${RED}Package ${BLUE}${package} ${RED}not found!${NC}"
  fi
done

sed 's/PasswordAuthentication yes/PasswordAuthentication no/' -i "${PREFIX}/etc/ssh/sshd_config"

if ! dpkg -s tsu &>/dev/null && su -c echo &>/dev/null; then
  apt-get install -y tsu
fi

if ! [ -d "${HOME}/storage" ]; then
  termux-setup-storage
fi

apt-get autoremove -y
apt-get clean
