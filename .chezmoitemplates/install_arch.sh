# shellcheck shell=bash
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

TEMP_FOLDER=$(mktemp -d)
trap 'rm -rf ${TEMP_FOLDER}' EXIT

command -v reflector &>/dev/null && sudo reflector --latest 50 --number 20 --sort delay --protocol "http,https" --save /etc/pacman.d/mirrorlist

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
  paru -Fy
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

  # arch4edu
  sudo pacman-key --recv-keys 7931B6D628C8D3BA
  sudo pacman-key --finger 7931B6D628C8D3BA
  sudo pacman-key --lsign-key 7931B6D628C8D3BA

  sudo tee -a /etc/pacman.conf >/dev/null <<'EOF'
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist

[arch4edu]
Server = https://repository.arch4edu.org/$arch

EOF

  sudo pacman -Syu --noconfirm
fi
{{ end }}

# desktop enviroment
dePackageList=(
  # x11 / login manager
  {{ if ne .chezmoi.osRelease.id "archarm" }}
  sddm
  sddm-kcm
  xorg-server
  xorg-apps
  {{ else }}
  dbus-x11
  tightvncserver
  {{ end }}
  # plasma
  gtk3-nocsd
  kde-cli-tools
  kdeplasma-addons
  kgamma
  kio-admin
  kscreen
  kwallet-pam
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
  {{ if ne .chezmoi.osRelease.id "archarm" }}
  bluedevil
  bluez
  bluez-utils
  pulseaudio-bluetooth
  {{ end }}
  # kde gui apps
  ark
  dolphin
  ffmpegthumbs
  filelight
  gwenview
  kalgebra
  kate
  kcalc
  kdegraphics-thumbnailers
  kdenetwork-filesharing
  kdialog
  kfind
  kimageformats5
  kjournald
  kmix
  kolourpaint
  konsole
  ksystemlog
  labplot
  okular
  partitionmanager
  spectacle
  # other gui apps/plugins
  alacritty
  calibre
  conky
  gimp
  inkscape
  keepassxc
  mpv
  onlyoffice-bin
  qt5-imageformats
  qt5-jpegxl-image-plugin
  qt6-jpegxl-image-plugin
  visual-studio-code-bin
  xournalpp
  {{ if ne .chezmoi.osRelease.id "archarm" }}
  gparted
  ventoy-bin
  virtualbox
  vivaldi
  {{ else }}
  vivaldi-snapshot
  {{ end }}
)

# applets
appletsPackageList=(
  plasma5-applets-window-appmenu
  plasma5-applets-window-buttons
  plasma5-applets-window-title
)

packageList=(
  age
  bat
  bc
  clang
  cmake
  curl
  expac
  expect
  eza
  fastfetch
  fd
  ffmpeg
  find-the-command
  fish
  fzf
  git
  htop
  imagemagick
  jq
  libjxl
  make
  mediainfo
  micro
  nano
  neovim
  netcat
  ninja
  numlockx
  p7zip
  pacman-contrib
  pandoc
  perl-file-homedir
  perl-image-exiftool
  perl-yaml-tiny
  pkgfile
  plocate
  pyenv
  python
  python-black
  python-isort
  python-pipx
  python-requests
  rclone
  reflector
  ripgrep
  shfmt
  sshfs
  starship
  stderred-git
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
  unrar
  unzip
  wget
  which
  xclip
  zip
  zoxide
  {{ if ne .chezmoi.osRelease.id "archarm" }}
  alsa-card-profiles
  android-tools
  compsize
  cronie
  docker
  docker-compose
  hwinfo
  inetutils
  lm_sensors
  os-prober
  simple-mtpfs
  ufw
  usbutils
  zram-generator
  {{ end }}
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
pacman -Qtdq | sudo pacman -Rns --noconfirm 2>/dev/null || :

echo
