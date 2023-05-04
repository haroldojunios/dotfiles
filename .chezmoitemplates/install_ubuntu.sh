export DEBIAN_FRONTEND=noninteractive

RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if [ -d /etc/needrestart ] && ! [ -f /etc/needrestart/conf.d/no-prompt.conf ]; then
  sudo mkdir -p /etc/needrestart/conf.d
  echo "\$nrconf{restart} = 'a';" | sudo tee /etc/needrestart/conf.d/no-prompt.conf >/dev/null
fi

sudo apt-get update
sudo apt-get upgrade -y

NEEDS_UPDATE=

# code repo
if ! [ -f /etc/apt/sources.list.d/vscode.list ]; then
  sudo apt-get install -y wget gpg apt-transport-https
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  NEEDS_UPDATE=1
fi

# alacritty repo
if ! grep -q "^deb .*aslatter/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:aslatter/ppa -y
  NEEDS_UPDATE=1
fi

# firefox repo
if ! grep -q "^deb .*mozillateam/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:mozillateam/ppa -y

  if command -v snap &>/dev/null; then
    if snap list | grep firefox &>/dev/null; then
      sudo snap remove firefox
    fi
  fi

  NEEDS_UPDATE=1
  sudo bash -c "cat >/etc/apt/preferences.d/mozillateamppa" <<EOF
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
EOF
fi

# kubuntu backports repo
if ! grep -q "^deb .*kubuntu-ppa/backports" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:kubuntu-ppa/backports -y
  sudo apt-get update && sudo apt-get full-upgrade -y
  NEEDS_UPDATE=
fi

if [ -n $NEEDS_UPDATE ]; then
  sudo apt-get update
fi

# desktop enviroment
dePackageList=(
  xorg
  sddm
  "
kde-config-screenlocker \
kde-config-sddm \
kde-spectacle \
kwin-addons \
plasma-browser-integration \
plasma-desktop \
plasma-disks \
plasma-firewall \
plasma-framework \
plasma-integration \
plasma-nm \
plasma-pa \
plasma-systemmonitor \
plasma-thunderbolt \
plasma-widgets-addons \
plasma-workspace \
powerdevil \
"
  "
ark \
dolphin \
filelight \
gwenview \
kate \
kcalc \
konsole \
okular \
"
)

# applets
appletsPackageList="
cmake \
extra-cmake-modules \
g++ \
gettext \
libkdecorations2-dev \
libkf5configwidgets-dev \
libkf5declarative-dev \
libkf5plasma-dev \
libkf5plasma-dev \
libkf5wayland-dev \
libqt5x11extras5-dev \
libsm-dev \
libxcb-randr0-dev \
make \
plasma-workspace-dev \
qtbase5-dev \
qtdeclarative5-dev \
"

# packages
packageList=(
  age
  alacritty
  bat
  calibre
  clang
  cmake
  code
  conky-all
  crudini
  curl
  exa
  ffmpeg
  fish
  firefox
  git
  gparted
  imagemagick
  jmtpfs
  jq
  keepassxc
  make
  micro
  mpv
  nano
  ninja-build
  numlockx
  openssh-server
  p7zip
  python-is-python3
  python3
  python3-venv
  sshfs
  systemd-zram-generator
  {{ if not .isWork }}
  texlive-fonts-recommended
  texlive-lang-portuguese
  texlive-latex-base
  texlive-latex-extra
  texlive-latex-recommended
  texlive-pictures
  texlive-pstricks
  texlive-science
  texlive-xetex
  {{ end }}
  tmux
  ufw
  unzip
  xclip
  zip
)

if ! { [ -d /usr/share/plasma/plasmoids/org.kde.windowbuttons ] && [ -d /usr/share/plasma/plasmoids/org.kde.windowappmenu ]; }; then
  packageList=(
    "${packageList[@]}"
    $appletsPackageList
  )
fi

if [ -d "/sys/class/power_supply" ]; then
  packageList=(
    "${packageList[@]}"
    tlp
    tlp-rdw
  )
fi

packageList=(
  "${dePackageList[@]}"
  "${packageList[@]}"
)

for package in "${packageList[@]}"; do
  if ! dpkg -s $package &>/dev/null; then
    sudo apt-get install -y $package || echo -e"${RED}Package ${BLUE}$package ${RED}not found!${NC}"
  fi
done

if ! command -v bat &>/dev/null; then
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi

if ! systemctl list-unit-files --state=enabled | grep ufw &>/dev/null; then
  sudo systemctl enable --now ufw
fi

if [ -d "/sys/class/power_supply" ]; then
  if ! systemctl list-unit-files --state=enabled | grep tlp &>/dev/null; then
    sudo systemctl enable --now tlp
  fi
fi

if ! command -v onlyoffice-desktopeditors &>/dev/null; then
  TEMP_FOLDER=$(mktemp -d)
  wget -O "$TEMP_FOLDER/onlyoffice.deb" -q "https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb"
  sudo apt-get install -y "$TEMP_FOLDER/onlyoffice.deb"
  rm -rf "$TEMP_FOLDER"
fi

{{ if not .isWork }}
if ! command -v fastfetch &>/dev/null; then
  TEMP_FOLDER=$(mktemp -d)
  git -C "$TEMP_FOLDER" clone --depth 1 https://github.com/LinusDierheimer/fastfetch.git
  (
    cd "$TEMP_FOLDER/fastfetch"
    mkdir -p build
    cd build
    cmake ..
    cmake --build . --target fastfetch --target flashfetch
    sudo cmake --install . --prefix /usr/local
  )
  rm -rf "$TEMP_FOLDER"
fi
{{ end }}

if sudo ufw status | grep -q inactive; then
  sudo ufw enable
fi

if ! sudo ufw status | grep -q 22/tcp; then
  sudo ufw allow ssh
fi

sudo apt-get autoremove -y
sudo apt-get clean -y
