# shellcheck shell=bash
export DEBIAN_FRONTEND=noninteractive

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

if [ -f "/etc/needrestart/needrestart.conf" ]; then
  sudo sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" "/etc/needrestart/needrestart.conf"
fi

mkdir -p -m 700 ~/.gnupg
gpg --refresh-keys &>/dev/null || :

# code repo
if ! [ -f /etc/apt/sources.list.d/vscode.list ]; then
  sudo apt-get install -y wget gpg apt-transport-https
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
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

# alacritty repo
if ! grep -q "^deb .*aslatter/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:aslatter/ppa -y
fi

# chromium repo
if ! grep -q "^deb .*saiarcot895/chromium-beta" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:saiarcot895/chromium-beta -y
fi

# vivaldi repo
if ! grep -q "^deb .*vivaldi" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
  sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main' -y
fi

# firefox repo
if ! grep -q "^deb .*mozillateam/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:mozillateam/ppa -y
  sudo bash -c "cat >/etc/apt/preferences.d/mozillateamppa" <<EOF
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501
EOF
fi

# kubuntu backports repo
if ! grep -q "^deb .*kubuntu-ppa/backports" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:kubuntu-ppa/backports -y
fi

# fish repo
if ! grep -q "^deb .*fish-shell/release-3" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:fish-shell/release-3 -y
fi

# neovim repo
if ! grep -q "^deb .*neovim-ppa/unstable" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:neovim-ppa/unstable -y
fi

# ubuntugis repo
if ! grep -q "^deb .*ubuntugis/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  sudo add-apt-repository ppa:ubuntugis/ppa -y
fi

# eza repo
if ! [ -f /etc/apt/sources.list.d/gierens.list ]; then
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list &>/dev/null
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
fi

# onlyoffice repo
if ! [ -f /etc/apt/sources.list.d/onlyoffice.list ]; then
  # mkdir -p -m 700 ~/.gnupg
  gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
  chmod 644 /tmp/onlyoffice.gpg
  sudo chown root:root /tmp/onlyoffice.gpg
  sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg

  sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main" > /etc/apt/sources.list.d/onlyoffice.list'
fi

# nodejs repo
if ! [ -f /etc/apt/sources.list.d/nodesource.list ]; then
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
fi

sudo apt-get update
# sudo apt-get full-upgrade -y

# desktop enviroment
dePackageList=(
  # x11 / login manager
  xorg
  sddm
  # plasma
  gtk3-nocsd
  kde-config-screenlocker
  kde-config-sddm
  kde-spectacle
  kwin-addons
  plasma-browser-integration
  plasma-desktop
  plasma-disks
  plasma-firewall
  plasma-framework
  plasma-integration
  plasma-nm
  plasma-pa
  plasma-systemmonitor
  plasma-thunderbolt
  plasma-widgets-addons
  plasma-workspace
  powerdevil
  pulseaudio-module-bluetooth
  xdg-desktop-portal-kde
  # kde gui apps
  ark
  dolphin
  ffmpegthumbs
  filelight
  gwenview
  kalgebra
  kate
  kcalc
  kde-spectacle
  kdegraphics-thumbnailers
  kdenetwork-filesharing
  kdialog
  kfind
  kmix
  kolourpaint
  konsole
  ksystemlog
  labplot
  okular
  partitionmanager
  # other gui apps
  alacritty
  {{ if not .isWork }}
  calibre
  {{ end }}
  code
  fontforge
  gimp
  gparted
  inkscape
  keepassxc
  libqt6svg6
  onlyoffice-desktopeditors
  qml-module-qtquick-controls2
  qml-module-qtquick-layouts
  vivaldi-stable
  xournalpp
  xserver-xorg-video-dummy
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
  7zip
  age
  aptitude
  bat
  bc
  black
  btrfs-compsize
  build-essential
  clang
  cmake
  conky-all
  crudini
  curl
  exfatprogs
  expect
  eza
  ffmpeg
  fish
  git
  hwinfo
  ghostscript
  jmtpfs
  jq
  libfontconfig1
  make
  micro
  mpv
  nano
  neovim
  ninja-build
  nodejs
  numlockx
  openssh-server
  perl
  python-is-python3
  python3
  python3-isort
  python3-pip
  python3-psutil
  python3-requests
  python3-venv
  rclone
  ripgrep
  shfmt
  sshfs
  tmux
  ufw
  unzip
  wget
  xclip
  zip
  zram-config
)

if [ -d "/sys/class/power_supply" ]; then
  packageList=(
    "${packageList[@]}"
    tlp
    tlp-rdw
  )
fi

{{ if .installDE }}
if ! { [ -d /usr/share/plasma/plasmoids/org.kde.windowbuttons ] && [ -d /usr/share/plasma/plasmoids/org.kde.windowappmenu ]; }; then
  packageList=(
    "${packageList[@]}"
    ${appletsPackageList}
  )
fi

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

if ! command -v 7z &>/dev/null && ! [ -f "/usr/bin/7z" ] && [ -f "/usr/bin/7zz" ]; then
  sudo ln -s /usr/bin/7zz /usr/bin/7z
fi

if ! systemctl list-unit-files --state=enabled | grep ufw &>/dev/null; then
  sudo systemctl enable --now ufw
fi

if [ -d "/sys/class/power_supply" ]; then
  if ! systemctl list-unit-files --state=enabled | grep tlp &>/dev/null; then
    sudo systemctl enable --now tlp
  fi
fi

if ! systemctl list-unit-files --state=masked | grep systemd-networkd-wait-online &>/dev/null; then
  sudo systemctl mask systemd-networkd-wait-online
fi

if sudo ufw status | grep -q inactive; then
  sudo ufw enable
fi

if ! sudo ufw status | grep -q 22/tcp; then
  sudo ufw allow ssh
fi

if lspci | grep -i network | grep -iq bcm; then
  if ! dpkg -s bcmwl-kernel-source &>/dev/null; then
    sudo apt install -y bcmwl-kernel-source
    sudo systemctl restart network-manager
  fi
fi

{{ if not .isWork }}
if ! command -v fastfetch &>/dev/null; then
  TEMP_FOLDER=$(mktemp -d)
  git -C "${TEMP_FOLDER}" clone --depth 1 https://github.com/LinusDierheimer/fastfetch.git
  (
    cd "${TEMP_FOLDER}/fastfetch"
    mkdir -p build
    cd build
    cmake ..
    cmake --build . --target fastfetch --target flashfetch
    sudo cmake --install . --prefix /usr/local
  )
  rm -rf "${TEMP_FOLDER}"
fi
{{ end }}

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
    sudo usermod -aG docker "${USER}"
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

if ! [ -f /usr/lib/libstderred.so ]; then
  TEMP_FOLDER=$(mktemp -d)
  git -C "$TEMP_FOLDER" clone --depth 1 https://github.com/ku1ik/stderred.git
  (
    cd "$TEMP_FOLDER/stderred"
    mkdir -p build
    cd build
    cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/usr -DLIBDIR=lib ../src
    make
    sudo make install
  )
  rm -rf "${TEMP_FOLDER}"
fi

## imagemagick
TEMP_FILE=$(mktemp)
wget 'https://dist.1-2.dev/imei.sh' -qO "${TEMP_FILE}"
sudo bash "${TEMP_FILE}" || :
rm -f "${TEMP_FILE}"

sudo aptitude safe-upgrade -o APT::Get::Fix-Missing=true -y
yes | sudo ubuntu-drivers install &>/dev/null
dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge 2>/dev/null || :
sudo apt-get autoremove --purge -y
sudo apt-get clean -y
