RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

apt update
apt upgrade -y

# its pointless repo
if ! [ -f $PREFIX/etc/apt/sources.list.d/pointless.list ]; then
  curl -sL https://its-pointless.github.io/setup-pointless-repo.sh | bash
fi

packageList=(
  age
  bat
  clang
  cmake
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
  zip
)

for package in "${packageList[@]}"; do
  if ! dpkg -s $package &>/dev/null; then
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
