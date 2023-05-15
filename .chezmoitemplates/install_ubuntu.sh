export DEBIAN_FRONTEND=noninteractive

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

if [ -d /etc/needrestart ] && ! [ -f /etc/needrestart/conf.d/no-prompt.conf ]; then
  sudo mkdir -p /etc/needrestart/conf.d
  echo "\$nrconf{restart} = 'a';" | sudo tee /etc/needrestart/conf.d/no-prompt.conf >/dev/null
fi

# sudo apt-get update
# sudo apt-get upgrade -y

{{ if not .isWSL }}
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

if [ -n "$NEEDS_UPDATE" ]; then
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
  dbus-x11
  tigervnc-standalone-server
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
  bc
  {{ if not .isWork }}
  calibre
  {{ end }}
  clang
  cmake
  code
  conky-all
  crudini
  curl
  exa
  expect
  ffmpeg
  fish
  firefox
  git
  gparted
  imagemagick
  jmtpfs
  jq
  {{ if not .isWork }}
  keepassxc
  {{ end }}
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
  shfmt
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
  wget
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
{{ else }}
# wsl packages
packageList=(
  age
  bat
  bc
  clang
  cmake
  crudini
  curl
  exa
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
  unzip
  wget
  wslu
  xclip
  zip
)
{{ end }}

for package in "${packageList[@]}"; do
  if ! dpkg -s $package &>/dev/null; then
    echo -e "${GREEN}Installing package ${BLUE}$package ${GREEN}...${NC}"
    sudo apt-get install -y $package || echo -e"${RED}Package ${BLUE}$package ${RED}not found!${NC}"
  fi
done

if ! command -v bat &>/dev/null; then
  mkdir -p ~/.local/bin
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi

{{ if not .isWSL }}
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
{{ end }}

{{ if and (not .isWork) (not .isWSL) }}
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
    cat >/etc/docker/daemon.json <<EOF
{
  "dns": [
    "10.1.2.3",
    "8.8.8.8"
  ]
}
EOF
  fi
fi

{{ if not .isWSL }}
if ! [ -f "/etc/systemd/system/vncserver@.service" ]; then
  pkill vncserver || true

  expect <<EOF
spawn "vncserver"
set timeout 3
expect "Password:" { send "123456\r" }
expect "Verify:" { send "123456\r" }
expect "Would you like to enter a view-only password (y/n)?" { send "n\r" }
expect eof
exit
EOF

  pkill vncserver || true

  sudo bash -c "cat >/etc/systemd/system/vncserver@.service" <<EOF
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=simple
User={{ .chezmoi.username }}
Group={{ .chezmoi.group }}
WorkingDirectory={{ .chezmoi.homeDir }}
PAMName=loginPIDFile=/home/%u/.vnc/%H%i.pid
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver :%i -geometry 1280x720 -alwaysshared -fg
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOF

  cat >$HOME/.vnc/xstartup <<EOF
#!/bin/sh

# Start up the standard system desktop
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

/usr/bin/startplasma-x11

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
x-window-manager &
EOF

  chmod +x ~/.vnc/xstartup

  sudo systemctl daemon-reload
  sudo systemctl enable --now vncserver@1.service
fi
{{ end }}

# sudo apt-get autoremove -y
# sudo apt-get clean -y
