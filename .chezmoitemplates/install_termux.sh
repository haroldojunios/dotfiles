RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

apt update
apt upgrade -y --option Dpkg::Options::=--force-confold --option Dpkg::Options::=--force-confdef

# setup its pointless repo
if ! [ -f $PREFIX/etc/apt/sources.list.d/pointless.list ]; then
  curl -sL https://its-pointless.github.io/setup-pointless-repo.sh | bash
fi

packageList=(
  tur-repo # setup tur repo
  age
  bat
  clang
  cmake
  code-server # needs tur repo
  cronie
  curl
  exa
  ffmpeg
  fish
  git
  imagemagick
  jq
  make
  micro
  nano
  ninja
  openssh
  p7zip
  python
  scipy
  starship
  termux-api
  tmux
  unzip
  wget
  which
  zip
)

for package in "${packageList[@]}"; do
  if ! dpkg -s $package &>/dev/null; then
    echo -e "${GREEN}Installing package ${BLUE}$package ${GREEN}...${NC}"
    apt install -y $package || echo -e "${RED}Package ${BLUE}$package ${RED}not found!${NC}"
  fi
done

passwd &>/dev/null <<EOD
0000
0000
EOD

if ! dpkg -s tsu &>/dev/null && su -c echo &>/dev/null; then
  apt install -y tsu
fi

if ! [ -d "$HOME/storage" ]; then
  termux-setup-storage
fi

apt autoremove -y
apt clean
