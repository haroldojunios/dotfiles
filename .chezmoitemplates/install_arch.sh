RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

sudo pacman -Syu --noconfirm

if ! command -v paru &>/dev/null; then
  TEMP_FOLDER=$(mktemp -d)
  sudo pacman -S --needed base-devel
  git -C "$TEMP_FOLDER" clone --depth 1 https://aur.archlinux.org/paru.git
  (
    cd "$TEMP_FOLDER/paru"
    makepkg -si
  )
  rm -rf "$TEMP_FOLDER"
fi

if grep -q "#" /etc/pacman.conf; then
  sudo bash -c "cat >/etc/pacman.conf" <<EOF
[options]
CacheDir = /var/cache/pacman/pkg/
HoldPkg = pacman glibc
Architecture = auto
Color
ParallelDownloads = 10
CheckSpace
ILoveCandy
VerbosePkgLists
SigLevel = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
fi

if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
  sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key FBA220DFC880C036
  sudo pacman -U --noconfirm --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

  sudo tee -a /etc/pacman.conf >/dev/null <<EOF

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOF
fi

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
  conky
  crudini
  curl
  exa
  ffmpeg
  fish
  git
  gparted
  imagemagick
  jq
  keepassxc
  make
  micro
  mpv
  mtpfs
  nano
  ninja
  numlockx
  p7zip
  python
  sshfs
  starship
  texlive-bibtexextra
  texlive-bin
  texlive-latexextra
  texlive-latexindent-meta
  texlive-pictures
  texlive-pstricks
  texlive-science
  tmux
  ufw
  unzip
  wget
  which
  xclip
  zip
  zram-generator
)

if ! { [ -d /usr/share/plasma/plasmoids/org.kde.windowbuttons ] && [ -d /usr/share/plasma/plasmoids/org.kde.windowappmenu ]; }; then
  packageList=(
    "${packageList[@]}"
    "$appletsPackageList"
  )
fi

if [ -d "/proc/acpi/button/lid" ]; then
  if ! pacman -Qi power-profiles-daemon &>/dev/null; then
    packageList=(
      "${packageList[@]}"
      tlp
      tlp-rdw
    )
  fi
fi

for package in "${packageList[@]}"; do
  if ! pacman -Qi $package &>/dev/null; then
    echo -e "${GREEN}Installing package ${BLUE}$package ${GREEN}...${NC}"
    paru -S --noconfirm --needed --skipreview --nouseask --sudoloop $package ||
      echo -e "${RED}Package(s) \"${BLUE}$package${RED}\" not found!${NC}"
  fi
done

if ! systemctl list-unit-files --state=enabled | grep ufw &>/dev/null; then
  sudo systemctl enable --now ufw
fi

if [ -d "/proc/acpi/button/lid" ]; then
  if pacman -Qi tlp &>/dev/null && ! systemctl list-unit-files --state=enabled | grep tlp &>/dev/null; then
    sudo systemctl enable --now tlp
    sudo systemctl enable --now NetworkManager-dispatcher.service
    sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
  fi
fi

pacman -Qtdq | sudo pacman -Rns --noconfirm 2>/dev/null
