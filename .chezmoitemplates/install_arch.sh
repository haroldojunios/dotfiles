# shellcheck shell=bash
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

TEMP_FOLDER=$(mktemp -d)
trap 'rm -rf ${TEMP_FOLDER}' EXIT

# command -v reflector &>/dev/null && sudo reflector --latest 50 --number 20 --sort delay --protocol "http,https" --save /etc/pacman.d/mirrorlist

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
{{ if eq .osid "linux-garuda" }}
[garuda]
Include = /etc/pacman.d/chaotic-mirrorlist
{{ end }}
[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist
{{ if eq .chezmoi.osRelease.id "archarm" }}
[alarm]
Include = /etc/pacman.d/mirrorlist

[aur]
Include = /etc/pacman.d/mirrorlist
{{ else }}
[multilib]
Include = /etc/pacman.d/mirrorlist
{{ end }}
{{ if eq .osid "linux-garuda" }}
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
{{ end }}
EOF
fi

if ! command -v paru &>/dev/null; then
  sudo pacman -Syu --noconfirm
  sudo pacman -S --noconfirm --needed base-devel
  git -C "${TEMP_FOLDER}" clone --depth 1 https://aur.archlinux.org/paru.git
  (
    cd "${TEMP_FOLDER}/paru" || exit
    makepkg -si --noconfirm
  )
else
  paru -Syu --noconfirm
  paru -Fy || :
fi

if grep -q "#" /etc/paru.conf; then
  sudo bash -c "cat >/etc/paru.conf" <<EOF
[options]
PgpFetch
Devel
Provides
DevelSuffixes = -git -cvs -svn -bzr -darcs -always -hg -fossil
BottomUp
SudoLoop
CleanAfter
RemoveMake = ask
UpgradeMenu
SortBy = popularity
Limit = 100
CompletionInterval = 1
EOF
fi

{{ if ne .chezmoi.osRelease.id "archarm" }}
if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
  # chaotic-aur
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U --noconfirm --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

  sudo tee -a /etc/pacman.conf >/dev/null <<'EOF'
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist

EOF

  sudo pacman -Syu --noconfirm
fi
{{ end }}

if ! pacman -Q pipewire pipewire-jack pipewire-alsa pipewire-pulse wireplumber &>/dev/null; then
  yes | sudo pacman -S pipewire pipewire-jack pipewire-alsa pipewire-pulse wireplumber
fi

# desktop enviroment
dePackageList=(
  # x11 / login manager
  sddm
  sddm-kcm
  xdotool
  xorg-apps
  xorg-server
  xorg-xwayland
  # plasma
  bluedevil
  bluez
  bluez-utils
  gtk3-nocsd
  kde-cli-tools
  kdeplasma-addons
  kgamma
  kio-admin
  kscreen
  kwallet-pam
  kwin-effects-forceblur
  plasma-browser-integration
  plasma-desktop
  plasma-disks
  plasma-firewall
  plasma-framework5
  plasma-integration
  plasma-nm
  plasma-pa
  plasma-systemmonitor
  plasma-thunderbolt
  plasma-workspace
  powerdevil
  purpose5
  xdg-desktop-portal-gtk
  xdg-desktop-portal-kde
  # qtile
  qtile-git
  libinput
  libpulse
  python-dbus-next
  python-iwlib
  python-pywayland
  python-pywlroots
  python-xdg
  python-xkbcommon
  # kde gui apps
  ark
  dolphin
  dolphin-plugins
  ffmpegthumbs
  filelight
  gwenview
  kalgebra
  kate
  kcalc
  kdeconnect
  kdegraphics-thumbnailers
  kdenetwork-filesharing
  kdialog
  kfind
  kimageformats
  kimageformats5
  kjournald
  kmix
  kolourpaint
  konsole
  krdc
  ksystemlog
  labplot
  okular
  partitionmanager
  spectacle
  # other gui apps/plugins
  alacritty
  calibre
  chromium
  conky
  dex
  feh
  filezilla
  gimp
  gparted
  inkscape
  jdownloader2
  keepassxc
  kitty
  mpv
  obs-studio-git
  obsidian
  onlyoffice-bin
  pdfarranger
  qbittorrent
  qt6-declarative
  qt6-imageformats
  qt6-jpegxl-image-plugin
  qt6-svg
  rofi
  stremio
  tk
  ventoy-bin
  virtualbox
  visual-studio-code-bin
  vivaldi
  xournalpp
  zathura-pdf-mupdf
  zathura-ps
)

# applets
appletsPackageList=(
  plasma6-applets-netspeed
  plasma6-applets-window-appmenu
  plasma6-applets-window-buttons
  plasma6-applets-window-title
)

packageList=(
  age
  alsa-card-profiles
  alsa-utils
  android-tools
  bat
  bc
  biber
  bibtool
  clang
  cmake
  compsize
  cronie
  crudini
  curl
  ddcci-driver-linux-dkms
  ddcutil
  docker
  docker-buildx
  docker-compose
  efibootmgr
  expac
  expect
  eza
  fastfetch
  fd
  ffmpeg
  find-the-command
  fish
  flatpak
  fnt
  fzf
  gdown
  git
  git-delta
  github-cli
  htop
  hwinfo
  i2c-tools
  imagemagick
  inetutils
  inxi
  jq
  lazydocker
  lazygit
  lazynpm
  libarchive
  libjxl
  libmupdf
  libvncserver
  lm_sensors
  lshw
  make
  mediainfo
  micro
  minidlna
  mongosh
  mypy
  nano
  ncdu
  neovim
  neovim-remote
  net-tools
  netcat
  ninja
  nnn
  nodejs
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  ntfs-3g
  numlockx
  numlockx
  nvme-cli
  ookla-speedtest-bin
  os-prober
  p7zip
  pacman-contrib
  pandoc
  peerflix
  perl-file-homedir
  perl-image-exiftool
  perl-yaml-tiny
  pkgfile
  playerctl
  plocate
  prettier
  pulseaudio-ctl
  pyenv
  python
  python-beautifulsoup4
  python-click
  python-matplotlib
  python-pandas
  python-pipx
  python-poetry
  python-poetry-plugin-export
  python-psutil
  python-py7zr
  python-pyexiftool
  python-pylatexenc
  python-requests
  python-scipy
  python-tqdm
  rclone
  reflector
  ripgrep
  ruff
  shfmt
  simple-mtpfs
  spotify-player-full-pipe
  sshfs
  starship
  stderred-git
  sysfsutils
  texlive-bibtexextra
  texlive-bin
  texlive-binextra
  texlive-fontutils
  texlive-langportuguese
  texlive-latexextra
  texlive-mathscience
  texlive-pictures
  texlive-plaingeneric
  texlive-pstricks
  texlive-publishers
  texlive-science
  texlive-xetex
  tmux
  tree-sitter-cli
  ufw
  unrar
  unzip
  usbutils
  wget
  which
  wine-staging
  wine-gecko
  wine-mono
  winetricks
  wkhtmltopdf
  xclip
  zerotier-one
  zip
  zoxide
  zram-generator
)

qgisPackageList=(
  python-gdal
  python-jinja
  python-owslib
  python-psycopg2
  python-yaml
  qgis
)

packageList=(
  "${packageList[@]}"
  "${dePackageList[@]}"
  "${appletsPackageList[@]}"
)

if lspci -k 2>/dev/null | grep -E "(VGA|3D)" | grep -i nvidia &>/dev/null; then
  case $(uname -r) in
  *arch*) nvidiaDriver=nvidia ;;
  *lts*) nvidiaDriver=nvidia-lts ;;
  *) nvidiaDriver=nvidia-dkms ;;
  esac

  packageList=(
    "${packageList[@]}"
    "${nvidiaDriver}"
    nvidia-utils
  )
fi

if [ -d "/proc/acpi/button/lid" ]; then
  if ! pacman -Q power-profiles-daemon &>/dev/null; then
    packageList=(
      "${packageList[@]}"
      tlp
      tlp-rdw
    )
  fi
fi

for package in "${packageList[@]}"; do
  if ! pacman -Q ${package} &>/dev/null && ! [ "$(pacman -Sg ${package})" = "$(pacman -Qg ${package} 2>&1)" ]; then
    echo -e "${GREEN}Installing package ${BLUE}${package}${GREEN}...${NC}"
    paru -S --noconfirm --needed --skipreview --nouseask --sudoloop ${package} ||
      echo -e "${RED}Package(s) \"${BLUE}${package}${RED}\" not found!${NC}"
  fi
done

{{ if ne .chezmoi.osRelease.id "archarm" }}
if ! systemctl list-unit-files --state=enabled | grep lm_sensors &>/dev/null; then
  sudo systemctl enable --now lm_sensors
fi

if ! systemctl list-unit-files --state=enabled | grep ufw &>/dev/null; then
  sudo systemctl enable --now ufw
fi

if ! systemctl list-unit-files --state=enabled | grep sddm &>/dev/null; then
  sudo systemctl enable sddm
fi

if ! systemctl list-unit-files --state=enabled | grep cronie &>/dev/null; then
  sudo systemctl enable --now cronie
fi

if ! systemctl list-unit-files --state=enabled | grep bluetooth &>/dev/null; then
  sudo systemctl enable --now bluetooth
fi

if ! systemctl list-unit-files --state=enabled | grep docker &>/dev/null; then
  sudo systemctl enable --now docker
  sudo groupadd docker &>/dev/null || true
  sudo usermod -aG docker "${USER}"
fi

if ! systemctl list-unit-files --state=enabled | grep pkgfile-update.timer &>/dev/null; then
  sudo systemctl enable --now pkgfile-update.timer
fi

if ! systemctl list-unit-files --state=enabled | grep plocate-updatedb.timer &>/dev/null; then
  sudo systemctl enable --now plocate-updatedb.timer
fi

if [ -d "/proc/acpi/button/lid" ]; then
  if pacman -Q tlp &>/dev/null && ! systemctl list-unit-files --state=enabled | grep tlp &>/dev/null; then
    sudo systemctl enable --now tlp
    sudo systemctl enable --now NetworkManager-dispatcher.service
    sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
  fi
fi
{{ end }}

if ! pipx list --short | grep -q crudini; then
  pipx install crudini
fi

yes | paru -Scd
pacman -Qtdq | xargs -r -n 1 sudo pacman -Rns --noconfirm

echo
