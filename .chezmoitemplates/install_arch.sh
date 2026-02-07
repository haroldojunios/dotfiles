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
  command -v pkgfile &>/dev/null && sudo pkgfile --update
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
  sddm-astronaut-theme
  xdotool
  xorg-apps
  xorg-server
  xorg-xwayland
  wayland-protocols
  # bluetooth
  bluez
  bluez-utils
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
  xdg-desktop-portal-gtk
  xwaylandvideobridge
  # lxqt
  lxqt-admin
  lxqt-config
  lxqt-globalkeys
  lxqt-notificationd
  lxqt-panel
  lxqt-policykit
  lxqt-powermanagement
  lxqt-qtplugin
  lxqt-runner
  lxqt-session
  lxqt-sudo
  obconf-qt
  openbox
  xdg-desktop-portal-lxqt
  # gui apps/plugins
  alacritty
  archlinux-xdg-menu
  blueman
  calibre-bin
  chromium
  cliphist
  dex
  ffmpegthumbs
  filelight
  filezilla
  fuzzel
  gimp
  gnome-epub-thumbnailer
  gnome-keyring
  gparted
  grim
  gtk3-nocsd
  gvfs
  gvfs-mtp
  gvfs-smb
  gvfs-wsdd
  inkscape
  kcalc
  kdeconnect
  keepassxc
  keyd
  kfind
  kimageformats
  kimageformats5
  kitty
  kjournald
  krdc
  ksystemlog
  lxqt-archiver
  mailcap
  obs-studio
  okular
  opentabletdriver
  partitionmanager
  pavucontrol
  pcmanfm-qt
  pdfarranger
  pomodorolm-bin
  purpose5 # sharing to smartphone via KDE Connect
  qt6-declarative
  qt6-imageformats
  qt6-jpegxl-image-plugin
  qt6-svg
  screengrab
  slurp
  stremio
  swappy
  swayosd-git
  tk
  ventoy-bin
  virtualbox
  visual-studio-code-bin
  waybar
  wl-clip-persist
  wl-clipboard
  wlogout
  xclip
  xdg-utils
  xournalpp
  zathura-pdf-mupdf
  zathura-ps
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
  ddcutil
  docker
  docker-buildx
  docker-compose
  earlyoom
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
  otf-latinmodern-math
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
  python-iniparse-git # crudini
  python-matplotlib
  python-mpd2 # beets
  python-openpyxl
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
  python-yaml
  python-requests
  python-scipy
  python-tqdm
  python-xdg  # beets / WM
  python-yams # mpd: last fm scrobbler
  qutebrowser
  rar
  rclone
  reflector
  ripgrep
  simple-mtpfs
  sshfs
  starship
  stderred-git
  sysfsutils
  tmux
  udiskie
  ufw
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
  # language servers and tools
  clang
  cmake-format
  eslint_d
  fixjson
  hadolint-bin
  ltex-ls-plus-bin
  lua-language-server
  markdownlint
  markdownlint-cli2
  mypy
  prettierd
  ruff
  shellcheck
  shfmt
  sqlfmt-bin
  stylua
  taplo-cli
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
  tree-sitter-cli
  typst
  typstyle-bin # typst formatter
  yaml-language-server
  yamlfmt
)

qgisPackageList=(
  python-gdal
  python-jinja
  python-owslib
  python-psycopg2
  python-pyproj
  python-yaml
  qgis
)

packageList=(
  "${packageList[@]}"
  "${dePackageList[@]}"
  "${qgisPackageList[@]}"
)

if lspci -k 2>/dev/null | grep -E "(VGA|3D)" | grep -i nvidia &>/dev/null; then
  packageList=(
    "${packageList[@]}"
    nvidia-open-dkms
    lib32-mesa
    lib32-nvidia-utils
    lib32-opencl-nvidia
    libva-mesa-driver
    libva-nvidia-driver-git
    libvdpau
    libxnvctrl
    mesa
    nvidia-container-toolkit
    nvidia-utils
    opencl-mesa
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

if ! systemctl list-unit-files --state=enabled | grep earlyoom.service &>/dev/null; then
  systemctl enable --now earlyoom.service
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
