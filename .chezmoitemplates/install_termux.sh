# shellcheck shell=bash
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

apt-get update
apt-get upgrade -y --option Dpkg::Options::=--force-confold --option Dpkg::Options::=--force-confdef

packageList=(
  tur-repo # setup tur repo
  7zip
  age
  bat
  clang
  cmake
  code-server # needs tur repo
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
  rsync
  starship
  termux-api
  tmux
  unzip
  wget
  which
  xz-utils
  zip
)

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
