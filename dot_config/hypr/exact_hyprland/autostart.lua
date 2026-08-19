-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require("hyprland.programs")

hl.on("hyprland.start", function()
  hl.exec_cmd("~/.config/hypr/scripts/xdg")
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  hl.exec_cmd(
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
  ) -- screen share
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  hl.exec_cmd(
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
  )
  hl.exec_cmd(
    "sleep 1 && kquitapp6 kiod6; kquitapp6 kded6; pkill kioworker; pkill kded6; waybar >~/.cache/waybar"
  ) -- https://github.com/Alexays/Waybar/issues/3468
  hl.exec_cmd("hypridle > ~/.cache/hypridle")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("otd-daemon")
  -- hl.exec_cmd("wl-paste --watch cliphist store")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd(
    "wl-clip-persist --clipboard regular --all-mime-type-regex '^(?!x-kde-passwordManagerHint).+'"
  )
  hl.exec_cmd("sleep 2 && nm-applet")
  hl.exec_cmd("sleep 2 && blueman-applet")
  hl.exec_cmd("sleep 2 && kdeconnect-indicator")
  hl.exec_cmd("sleep 2 && tailscale-systray")
  hl.exec_cmd("sleep 4 && keepassxc")
  hl.exec_cmd("sleep 2 && solaar -w hide")
  hl.exec_cmd("swaync")
  hl.exec_cmd("swayosd-server")
  hl.exec_cmd("sway-audio-idle-inhibit --ignore-source-outputs cava")
  hl.exec_cmd("wayvnc -ga 0.0.0.0")
  hl.exec_cmd("udiskie")
  hl.exec_cmd(
    "gsettings set org.gnome.desktop.interface gtk-theme catppuccin-mocha-lavender"
  )
  hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme beautyline")
  hl.exec_cmd(
    'gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"'
  )
  hl.exec_cmd(
    'gsettings set org.gnome.desktop.interface font-name "Iosevka Nerd Font, 9"'
  )
  hl.exec_cmd(
    'gsettings set org.gnome.desktop.interface document-font-name "Iosevka Nerd Font, 9"'
  )
  hl.exec_cmd(
    'gsettings set org.gnome.desktop.interface monospace-font-name "Iosevka Nerd Font, 9"'
  )
  -- hl.exec_cmd("hyprctl setcursor Sweet-cursors 24")
  -- hl.exec_cmd("XDG_MENU_PREFIX=arch- kbuildsycoca6")
  hl.exec_cmd("sleep 4 && SVPManager")
  hl.exec_cmd("sleep 60 && jellyfin-mpv-shim")

  hl.exec_cmd(programs.terminal, { workspace = 1 })
  hl.exec_cmd(programs.fileManager, { workspace = 3 })
end)
