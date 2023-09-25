RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

TEMP_FOLDER=$(mktemp -d)
trap "rm -rf $TEMP_FOLDER" EXIT

command -v reflector &>/dev/null && sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist
sudo pacman -Syu --noconfirm

if ! command -v paru &>/dev/null; then
  sudo pacman -S --noconfirm --needed base-devel asp
  git -C "$TEMP_FOLDER" clone --depth 1 https://aur.archlinux.org/paru.git
  (
    cd "$TEMP_FOLDER/paru"
    makepkg -si --noconfirm
  )
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

[multilib]
Include = /etc/pacman.d/mirrorlist
{{ if eq .osid "linux-garuda" }}
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
{{ end }}
EOF
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

# desktop enviroment
dePackageList=(
  # x11 / login manager
  sddm
  sddm-kcm
  xorg-server
  xorg-apps
  # plasma
  bluedevil
  bluez
  bluez-utils
  ffmpegthumbs
  kdeplasma-addons
  kgamma5
  kscreen
  kwallet-pam
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
  plasma-workspace
  powerdevil
  spectacle
  # kde gui apps
  ark
  dolphin
  ffmpegthumbs
  filelight
  gwenview
  kate
  kcalc
  konsole
  okular
  # other gui apps
  calibre
  conky
  firefox
  gimp
  gparted
  hyper
  keepassxc
  mpv
  onlyoffice-bin
  ventoy-bin
  virtualbox
  visual-studio-code-bin
  xournalpp
)

# applets
appletsPackageList=(
  plasma5-applets-window-appmenu
  plasma5-applets-window-buttons
  plasma5-applets-window-title
)

packageList=(
  age
  android-tools
  bat
  bc
  clang
  cmake
  compsize
  curl
  docker
  docker-compose
  eza
  expac
  expect
  fastfetch
  ffmpeg
  find-the-command
  fish
  fzf
  git
  htop
  imagemagick
  jq
  lm_sensors
  make
  mediainfo
  micro
  mlocate
  nano
  netcat
  ninja
  numlockx
  os-prober
  p7zip
  pandoc
  python
  python-black
  python-isort
  python-pipx
  python-requests
  reflector
  shfmt
  simple-mtpfs
  sshfs
  starship
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
  ufw
  unrar
  unzip
  usbutils
  usbutils
  wget
  which
  xclip
  zip
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

if lspci -k | grep -E "(VGA|3D)" | grep -i nvidia &>/dev/null; then
  case $(uname -r) in
  *arch*) nvidiaDriver=nvidia ;;
  *lts*) nvidiaDriver=nvidia-lts ;;
  *) nvidiaDriver=nvidia-dkms ;;
  esac

  packageList=(
    "${packageList[@]}"
    $nvidiaDriver
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
  if ! pacman -Q $package &>/dev/null && ! [ "$(pacman -Sg $package)" = "$(pacman -Qg $package 2>&1)" ]; then
    echo -e "${GREEN}Installing package ${BLUE}${package}${GREEN}...${NC}"
    paru -S --noconfirm --needed --skipreview --nouseask --sudoloop $package ||
      echo -e "${RED}Package(s) \"${BLUE}$package${RED}\" not found!${NC}"
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

if [ -d "/proc/acpi/button/lid" ]; then
  if pacman -Q tlp &>/dev/null && ! systemctl list-unit-files --state=enabled | grep tlp &>/dev/null; then
    sudo systemctl enable --now tlp
    sudo systemctl enable --now NetworkManager-dispatcher.service
    sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
  fi
fi

if ! pipx list --short | grep -q crudini; then
  pipx install crudini
fi

sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist

pacman -Qtdq | sudo pacman -Rns --noconfirm 2>/dev/null || :
