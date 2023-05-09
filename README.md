# Dotfiles

To setup the dotfiles through the `setup.sh` script run:

```sh
sh -c "$(curl -fsLS bit.ly/hjdots)"
```

To setup the dotfiles through chezmoi install script run:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply haroldojunios
```

## KDE config files

| File                                                  | Description                     |
| ----------------------------------------------------- | ------------------------------- |
| .config/kdeglobals                                    | KDE Global Config               |
| .config/latte/Default.layout.latte                    | Latte Dock Layout Config        |
| .config/lattedockrc                                   | Latte Dock Config               |
| .config/kded5rc                                       | KDE Startup Config              |
| .config/kcminputrc                                    | KDE Cursor Config               |
| .config/kwinrc                                        | KDE Window Manager Config       |
| .config/plasma-workspace/env/kwin.sh                  | KDE Window Manager Environment  |
| .config/plasma-workspace/env/askpass.sh               | KDE Askpass Environment         |
| .config/plasma-workspace/env/ssh-agent.sh             | Manage SSH Agent Environment    |
| .config/autostart/org.kde.latte-dock.desktop          | Autostart Latte Dock            |
| .config/autostart/ssh-add.desktop                     | Autostart SSH Keyring           |
| .config/plasmarc                                      | KDE Plasma Config               |
| .config/plasmashellrc                                 | KDE Plasma WM Config            |
| .config/gtkrc                                         | GTK Config                      |
| .config/gtkrc-2.0                                     | GTK2 Config                     |
| .config/gtk-3.0/                                      | GTK3 Config                     |
| .config/gtk-4.0/settings.ini                          | GTK4 Config                     |
| .config/Trolltech.conf                                | QT Theme Config                 |
| .config/xsettingsd/xsettingsd.conf                    | X11 Theme Config                |
| .config/dolphinrc                                     | Dolphin Config                  |
| .config/konsolerc                                     | Konsole Config                  |
| .config/mimeapps.list                                 | Default Applications            |
| .config/kglobalshortcutsrc                            | KDE Keybinding Config           |
| .config/ksmserverrc                                   | KDE Session Manager Config      |
| .config/kscreenlockerrc                               | KDE Lockscreen Config           |
| .config/krunnerrc                                     | KDE Launcher Config             |
| .config/plasma-org.kde.plasma.desktop-appletsrc       | KDE Plasmoids and Widgets       |
| .config/kde.org/UserFeedback.org.kde.plasmashell.conf | KDE Plasma User Feedback Config |
| .config/dconf/user                                    | Gnome DCONF Data                |
| .config/kactivitymanagerdrc                           | KDE Activites Config            |
| .config/ktimezonedrc                                  | KDE Timezone Config             |
| .config/plasma-localerc                               | KDE Locale Config               |
| .config/kwalletrc                                     | KDE Wallet Config               |
| .local/share/kwalletd/                                | KDE Wallet Data                 |
| .config/kdeconnect/                                   | KDE Connect Config + Data       |
| .config/kmail2rc                                      | Kmail Config                    |
| .local/share/kmail2/                                  | Kmail Data                      |
| .config/kalendarrc                                    | Kalendar Config                 |
| .config/KDE/kalendar.conf                             | Kalendar Config                 |
| .local/share/akonadi/                                 | Akonadi Data (PIM/Mail?)        |
