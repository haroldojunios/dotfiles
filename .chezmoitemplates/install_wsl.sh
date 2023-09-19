export DEBIAN_FRONTEND=noninteractive

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

if [ -d /etc/needrestart ] && ! [ -f /etc/needrestart/conf.d/no-prompt.conf ]; then
  sudo mkdir -p /etc/needrestart/conf.d
  echo "\$nrconf{restart} = 'a';" | sudo tee /etc/needrestart/conf.d/no-prompt.conf >/dev/null
fi

# remove snap
if dpkg -s snapd &>/dev/null; then
  if mount | grep -q "/var/snap/firefox/common/host-hunspell"; then
    sudo umount /var/snap/firefox/common/host-hunspell
  fi
  sudo apt-get autopurge snapd -y
  sudo bash -c "cat >/etc/apt/preferences.d/nosnap.pref" <<EOF
# To prevent repository packages from triggering the installation of Snap,
# this file forbids snapd from being installed by APT.
# For more information: https://linuxmint-user-guide.readthedocs.io/en/latest/snap.html

Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
fi

sudo apt-get update
sudo apt-get upgrade -y

# wsl packages
packageList=(
  age
  bat
  bc
  clang
  cmake
  crudini
  curl
  eza
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
  wslu
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

if ! dpkg -s docker-ce &>/dev/null; then
  if command -v snap &>/dev/null; then
    if snap list | grep docker &>/dev/null; then
      sudo snap remove docker
    fi
  fi
  if ! command -v docker &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo groupadd docker &>/dev/null || true
    sudo usermod -aG docker $USER
    # newgrp docker
  fi
  if ! [ -f /etc/docker/daemon.json ]; then
    sudo bash -c "cat >/etc/docker/daemon.json" <<EOF
{
  "dns": [
    "10.1.2.3",
    "8.8.8.8"
  ]
}
EOF
  fi
fi

sudo apt-get autoremove -y
sudo apt-get clean -y
