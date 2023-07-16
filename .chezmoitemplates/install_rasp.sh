export DEBIAN_FRONTEND=noninteractive

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

if ! dpkg -s software-properties-common &>/dev/null; then
  sudo apt-get install software-properties-common -y
fi

# fish repo
if ! grep -q "^deb .*fish-shell/release-3" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:fish-shell/release-3 -y
fi

sudo apt-get update
sudo apt-get full-upgrade -y

packageList=(
  age
  bat
  bc
  clang
  cmake
  crudini
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
  ninja-build
  openssh-server
  p7zip
  python-is-python3
  python3
  python3-venv
  shfmt
  sshfs
  texlive-fonts-recommended
  texlive-lang-portuguese
  texlive-latex-base
  texlive-latex-extra
  texlive-latex-recommended
  texlive-pictures
  texlive-pstricks
  texlive-science
  texlive-xetex
  tmux
  unzip
  wget
  xclip
  zip
)

for package in "${packageList[@]}"; do
  if ! dpkg -s $package &>/dev/null; then
    echo -e "${GREEN}Installing package ${BLUE}$package ${GREEN}...${NC}"
    sudo apt-get install -y $package || echo -e "${RED}Package ${BLUE}$package ${RED}not found!${NC}"
  fi
done

if ! command -v bat &>/dev/null && ! [ -f "$HOME/.local/bin/bat" ]; then
  mkdir -p "$HOME/.local/bin"
  ln -s /usr/bin/batcat "$HOME/.local/bin/bat"
fi

sudo apt-get autoremove -y
sudo apt-get clean -y
