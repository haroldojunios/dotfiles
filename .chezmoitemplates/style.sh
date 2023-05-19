TEMP_FOLDER=$(mktemp -d)

# theme
if ! [ -d /usr/share/themes/sweet ]; then
  sudo mkdir -p /usr/share/icons
  git -C "$TEMP_FOLDER" clone --depth 1 -b nova https://github.com/EliverLara/sweet
  (
    cd "$TEMP_FOLDER/sweet/kde"
    mkdir -p aurorae/themes
    mv aurorae/Sweet-Dark aurorae/themes/Sweet-Dark
    mv aurorae/Sweet-Dark-transparent aurorae/themes/Sweet-Dark-transparent
    rm aurorae/.shade.svg
    mv colorschemes color-schemes
    mkdir -p plasma/look-and-feel
    mv look-and-feel plasma/look-and-feel/Sweet
    mv sddm sddm-Sweet
    mkdir -p sddm/themes
    mv sddm-Sweet sddm/themes/Sweet

    # cursors
    sudo rm -r /usr/share/icons/Sweet-cursors
    sudo mv cursors/Sweet-cursors /usr/share/icons

    # kvantum
    sudo cp -r Kvantum /usr/share

    # GTK
    sudo mkdir -p /usr/share/themes/sweet
    sudo cp -a * /usr/share/themes/sweet

    # KDE theme
    sudo cp -r aurorae /usr/share
    sudo cp -r color-schemes /usr/share
    sudo cp -r konsole /usr/share
    sudo cp -r plasma /usr/share
    sudo cp -r sddm /usr/share
  )

  sudo mkdir -p /usr/share/plasma/desktoptheme/Sweet
  git -C "$TEMP_FOLDER" clone --depth 1 https://github.com/EliverLara/sweet-kde
  sudo cp -r "$TEMP_FOLDER/sweet-kde"/* /usr/share/plasma/desktoptheme/Sweet

  # blur
  git -C "$TEMP_FOLDER" clone --depth 1 https://github.com/esjeon/kwin-forceblur
  sudo mkdir -p /usr/share/kwin/scripts/forceblur
  sudo cp -r "$TEMP_FOLDER/kwin-forceblur/"{contents/,LICENSE,image.png,metadata.desktop} /usr/share/kwin/scripts/forceblur/
  sudo install -Dm644 "$TEMP_FOLDER/kwin-forceblur/metadata.desktop" /usr/share/kservices5/kwin-script-forceblur.desktop

  # apply config
  sudo crudini --set /etc/sddm.conf Theme Current Sweet
  sudo mkdir -p /var/lib/AccountsService/icons
  # sudo cp "$SCRIPT_FOLDER/assets/avatar.png" "/var/lib/AccountsService/icons/$USER"

  # killall plasmashell && kstart plasmashell
fi

lookandfeeltool -a Sweet &>/dev/null || :

# icons
if ! [ -d /usr/share/icons/candy-icons ]; then
  sudo mkdir -p /usr/share/icons
  sudo git -C /usr/share/icons clone --depth 1 https://github.com/EliverLara/candy-icons.git
fi

{ command -v plasma-changeicons &>/dev/null && plasma-changeicons candy-icons &>/dev/null; } ||
  { [ -x /usr/lib/x86_64-linux-gnu/libexec/plasma-changeicons ] && /usr/lib/x86_64-linux-gnu/libexec/plasma-changeicons candy-icons &>/dev/null; } &>/dev/null || :

# fonts
UPDATE_FONT_CACHE=
if ! [ -d /usr/share/fonts/FiraSans ]; then
  sudo mkdir -p /usr/share/fonts/FiraSans
  wget -O "$TEMP_FOLDER/FiraSans.zip" -q "https://fonts.google.com/download?family=Fira%20Sans"
  sudo unzip -q "$TEMP_FOLDER/FiraSans.zip" -d /usr/share/fonts/FiraSans
  UPDATE_FONT_CACHE=true
fi
if ! [ -d /usr/share/fonts/FiraCode ]; then
  sudo mkdir -p /usr/share/fonts/FiraCode
  wget -O "$TEMP_FOLDER/FiraCode.zip" -q "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
  sudo unzip -q "$TEMP_FOLDER/FiraCode.zip" -d /usr/share/fonts/FiraCode
  sudo rm -f /usr/share/fonts/FiraCode/*windows* || :
  UPDATE_FONT_CACHE=true
fi
if ! [ -d /usr/share/fonts/FiraMono ]; then
  sudo mkdir -p /usr/share/fonts/FiraMono
  wget -O "$TEMP_FOLDER/FiraMono.zip" -q "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.zip"
  sudo unzip -q "$TEMP_FOLDER/FiraMono.zip" -d /usr/share/fonts/FiraMono
  UPDATE_FONT_CACHE=true
fi
if ! [ -d /usr/share/fonts/Hack ]; then
  sudo mkdir -p /usr/share/fonts/Hack
  wget -O "$TEMP_FOLDER/Hack.zip" -q "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
  sudo unzip -q "$TEMP_FOLDER/Hack.zip" -d /usr/share/fonts/Hack
  UPDATE_FONT_CACHE=true
fi
if ! [ -d /usr/share/fonts/ConkySymbols ]; then
  sudo mkdir -p /usr/share/fonts/ConkySymbols
  sudo cp "{{ .chezmoi.sourceDir }}/assets/ConkySymbols.ttf" /usr/share/fonts/ConkySymbols
  UPDATE_FONT_CACHE=true
fi
if [ -n $UPDATE_FONT_CACHE ]; then
  fc-cache -f
fi

# applets
if ! [ -d /usr/share/plasma/plasmoids/org.kde.windowbuttons ]; then
  git -C "$TEMP_FOLDER" clone --depth 1 https://github.com/psifidotos/applet-window-buttons.git
  (
    cd "$TEMP_FOLDER/applet-window-buttons"
    sh ./install.sh
  )
fi

if ! [ -d /usr/share/plasma/plasmoids/org.kde.windowappmenu ]; then
  git -C "$TEMP_FOLDER" clone --depth 1 https://github.com/psifidotos/applet-window-appmenu.git
  (
    cd "$TEMP_FOLDER/applet-window-appmenu"
    sh ./install.sh
  )
fi

if ! [ -d /usr/share/plasma/plasmoids/org.kde.windowtitle ]; then
  git -C "$TEMP_FOLDER" clone --depth 1 https://github.com/psifidotos/applet-window-title.git
  (
    cd "$TEMP_FOLDER/applet-window-title"
    sudo kpackagetool5 --global --install .
  )
fi

rm -rf "$TEMP_FOLDER"
