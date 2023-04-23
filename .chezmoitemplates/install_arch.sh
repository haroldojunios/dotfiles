RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# desktop enviroment
dePackageList="
ark \
dolphin \
filelight \
gwenview \
kate \
kcalc \
kde-config-screenlocker \
kde-spectacle \
konsole \
kdeplasma-addons \
okular \
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
plasma-workspace \
powerdevil \
sddm \
sddm-kcm \
xorg-server \
xorg-apps \
"

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
  bc
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
  git
  gparted
  imagemagick
  jmtpfs
  jq
  keepassxc
  make
  mpv
  nano
  ninja-build
  numlockx
  p7zip
  python-is-python3
  python3
  python3-venv
  sshfs
  systemd-zram-generator
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
  ufw
  unzip
  xclip
  zip
)

if ! { [ -d /usr/share/plasma/plasmoids/org.kde.windowbuttons ] && [ -d /usr/share/plasma/plasmoids/org.kde.windowappmenu ]; }; then
  packageList=(
    "${packageList[@]}"
    "$appletsPackageList"
  )
fi

if [ -d "/sys/class/power_supply" ]; then
  packageList=(
    "${packageList[@]}"
    tlp
    tlp-rdw
  )
fi

for package in "${packageList[@]}"; do
  if ! dpkg -l "$package" &>/dev/null; then
    sudo apt install -y "$package" || echo "${RED}Package ${BLUE}$package ${RED}not found!${NC}"
  fi
done

if ! command -v bat &>/dev/null; then
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi

if ! command -v starship &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

if ! systemctl list-unit-files --state=enabled | grep ufw &>/dev/null; then
  sudo systemctl enable --now ufw
fi

if [ -d "/sys/class/power_supply" ]; then
  if ! systemctl list-unit-files --state=enabled | grep tlp &>/dev/null; then
    sudo systemctl enable --now tlp
    sudo systemctl enable --now NetworkManager-dispatcher.service
    sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
  fi
fi
