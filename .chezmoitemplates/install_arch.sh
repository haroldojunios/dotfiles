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
IgnorePkg = chaotic-mirrorlist

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

if ! command -v paru &>/dev/null; then
  sudo pacman -Syu --noconfirm || :
  sudo pacman -S --noconfirm --needed base-devel
  git -C "${TEMP_FOLDER}" clone --depth 1 https://aur.archlinux.org/paru.git
  (
    cd "${TEMP_FOLDER}/paru" || exit
    makepkg -si --noconfirm
  )
else
  paru -Syu --noconfirm || :
  paru -Fy || :
fi

if ! [ -f "${HOME}/.local/state/paru/devel.toml" ]; then
  paru --gendb
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

if ! pacman -Q pipewire pipewire-jack pipewire-alsa pipewire-pulse wireplumber &>/dev/null; then
  yes | sudo pacman -S pipewire pipewire-jack pipewire-alsa pipewire-pulse wireplumber
fi

# desktop enviroment
dePackageList=(
  # x11 / wayland / login manager
  sddm
  sddm-kcm
  xdotool
  xorg-apps
  xorg-server
  xorg-xwayland
  wayland-protocols
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
  # hyprland
  hyprland
  hyprcursor
  hypridle
  hyprlock
  hyprpaper
  hyprpicker
  egl-wayland
  polkit-kde-agent
  qt5-wayland
  qt6-wayland
  xdg-desktop-portal-hyprland
  xwaylandvideobridge
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
  okular
  partitionmanager
  spectacle
  # other gui apps/plugins
  alacritty
  archlinux-xdg-menu
  blueman
  calibre
  chromium
  cliphist
  dex
  filezilla
  fuzzel
  gimp
  gparted
  grim
  gvfs
  inkscape
  jdownloader2
  keepassxc
  keyd
  kitty
  mailcap
  obs-studio
  onlyoffice-bin
  opentabletdriver
  pavucontrol
  pdfarranger
  pomodorolm-bin
  qt6-declarative
  qt6-imageformats
  qt6-jpegxl-image-plugin
  qt6-svg
  slurp
  stremio
  swappy
  swayosd-git
  tk
  ventoy-bin
  virtualbox
  visual-studio-code-bin
  vlc
  waybar-cava
  wl-clip-persist
  wl-clipboard
  wlogout
  xclip
  xdg-utils
  xournalpp
  zathura-pdf-mupdf
  zathura-ps
)

# applets
appletsPackageList=(
  plasma6-applets-netspeed
  plasma6-applets-window-buttons
  plasma6-applets-window-title
)

packageList=(
  advcpmv
  age
  alsa-card-profiles
  alsa-utils
  android-tools
  bat
  bc
  beets
  biber
  bibtool
  bpython # python repl
  chafa
  chromaprint # beets
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
  exfatprogs
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
  khal
  lazydocker
  lazygit
  lazynpm
  libarchive
  libheif-highmem
  libjxl
  libmupdf
  libvncserver
  litecli # sqlite cli browser
  lm_sensors
  lshw
  make
  mediainfo
  micro
  minidlna
  mongosh
  mpd
  mpd-mpris
  mpv
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
  nss-mdns
  ntfs-3g
  numlockx
  nvme-cli
  ookla-speedtest-bin
  opus-tools
  opustags
  os-prober
  p7zip
  pacman-contrib
  pandoc
  pdfjs # qutebrowser
  peerflix
  perl-archive-zip # exiftool
  perl-file-homedir
  perl-file-mimeinfo
  perl-image-exiftool
  perl-io-compress-brotli # exiftool
  perl-yaml-tiny
  pkgfile
  pkgstats
  playerctl
  plocate
  prettier
  pulseaudio-ctl
  python
  python-adblock # qutebrowser
  python-aiohttp-oauthlib
  python-beautifulsoup4
  python-catppuccin
  python-click
  python-discogs-client # beets
  python-flask          # beets
  python-humanize
  python-iniparse # crudini
  python-matplotlib
  python-mpd2 # beets
  python-pandas
  python-pipx
  python-poetry
  python-poetry-plugin-export
  python-psutil
  python-py7zr
  python-pyacoustid # beets
  python-pyexiftool
  python-pylast # beets
  python-pylatexenc
  python-pypdf
  python-python-ffmpeg
  python-requests
  python-scipy
  python-tqdm
  python-xdg  # beets
  python-yams # mpd: last fm scrobbler
  qbittorrent-nox
  qutebrowser
  rclone
  reflector
  ripgrep
  ruff
  shfmt
  simple-mtpfs
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
  tinymist # typst lsp
  tmux
  tree-sitter-cli
  typst
  typstyle-bin # typst formatter
  ufw
  unrar
  unzip
  usbutils
  vdirsyncer
  vivify-bin
  wget
  which
  wine-staging
  wine-gecko
  wine-mono
  winetricks
  wkhtmltopdf
  yazi
  zerotier-one
  zip
  zk
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
  "${qgisPackageList[@]}"
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
    lib32-mesa
    lib32-nvidia-utils
    lib32-opencl-nvidia
    libva-mesa-driver
    libva-nvidia-driver-git
    libvdpau
    libxnvctrl
    mesa
    mesa-vdpau
    nvidia-utils
    opencl-clover-mesa
    opencl-nvidia
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
  if ! pacman -Q "${package}" &>/dev/null && ! [ "$(pacman -Sg "${package}")" = "$(pacman -Qg "${package}" 2>&1)" ]; then
    echo -e "${GREEN}Installing package ${BLUE}${package}${GREEN}...${NC}"
    paru -S --noconfirm --needed --skipreview --nouseask --sudoloop "${package}" ||
      echo -e "${RED}Package(s) \"${BLUE}${package}${RED}\" not found!${NC}"
    if [ "${package}" = "opentabletdriver" ]; then
      sudo mkinitcpio -P
      sudo rmmod wacom hid_uclogic || :
    fi
  fi
done

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

if ! systemctl list-unit-files --state=enabled | grep nvidia-resume &>/dev/null; then
  sudo systemctl enable --now nvidia-resume
  sudo systemctl enable --now nvidia-suspend
  sudo systemctl enable --now nvidia-hibernate
fi

if ! systemctl list-unit-files --state=enabled | grep pkgfile-update.timer &>/dev/null; then
  sudo systemctl enable --now pkgfile-update.timer
fi

if ! systemctl list-unit-files --state=enabled | grep plocate-updatedb.timer &>/dev/null; then
  sudo systemctl enable --now plocate-updatedb.timer
fi

if ! systemctl list-unit-files --state=enabled | grep avahi-daemon.service &>/dev/null; then
  sudo systemctl enable --now avahi-daemon.service
fi

if [ -d "/proc/acpi/button/lid" ]; then
  if pacman -Q tlp &>/dev/null && ! systemctl list-unit-files --state=enabled | grep tlp &>/dev/null; then
    sudo systemctl enable --now tlp
    sudo systemctl enable --now NetworkManager-dispatcher.service
    sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
  fi
fi

if ! systemctl list-unit-files --user --state=enabled | grep mpd.service &>/dev/null; then
  systemctl enable --user --now mpd.service
fi

if ! systemctl list-unit-files --user --state=enabled | grep mpd-mpris.service &>/dev/null; then
  systemctl enable --user --now mpd-mpris.service
fi

if ! systemctl list-unit-files --user --state=enabled | grep yams.service &>/dev/null; then
  systemctl enable --user --now yams.service
fi

yes | paru -Sc
pacman -Qtdq | xargs -r sudo pacman -Rns --noconfirm
rm -rf ~/.cache/paru/clone/*

echo
