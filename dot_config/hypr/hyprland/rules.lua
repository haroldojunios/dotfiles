-- Converted from rules.conf
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
--
-- hl.window_rule({ name=, match={...}, <effect fields> }) and
-- hl.layer_rule({ name=, match={...}, <effect fields> }) directly mirror the
-- official example (suppress_event, no_focus, float, move all appear there
-- verbatim). Effect fields not shown in the example -- opacity, size,
-- max_size, no_blur, no_anim, no_initial_focus, ignore_alpha -- are carried
-- over using the same field names your classic windowrule blocks already
-- used, which is a safe bet, but hasn't been confirmed line-by-line.

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
  name = "windowrule-1",
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
  name = "windowrule-2",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

-- BT manager
hl.window_rule({
  name = "windowrule-3",
  match = { class = "^(blueman-manager)$" },
  float = true,
})

-- Audio control
hl.window_rule({
  name = "windowrule-4",
  match = { class = "^(org.pulseaudio.pavucontrol)$" },
  float = true,
  size = "750 450",
})

-- nm-applet
hl.window_rule({
  name = "windowrule-5",
  match = { class = "^(nm-connection-editor)$" },
  float = true,
})

-- -- Waybar
-- hl.window_rule({
--     name = "windowrule-6",
--     match = { class = "^(calendar|system-monitor|mpd-player)$" },
--     float = true,
--     size = "(monitor_w*0.5)",
-- })

-- Kcalc
hl.window_rule({
  name = "windowrule-7",
  match = { class = "^(org\\.kde\\.kcalc)$" },
  float = true,
})

-- Portal
hl.window_rule({
  name = "windowrule-8",
  match = { class = "^(org\\.freedesktop\\.impl\\.portal\\.desktop\\.kde)$" },
  float = true,
})

hl.window_rule({
  name = "windowrule-9",
  match = { class = "^(xdg-desktop-portal-gtk)$" },
  float = true,
})

-- Login Google
hl.window_rule({
  name = "windowrule-10",
  match = { class = "firefox", title = "*login*Google*" },
  float = true,
})

-- CloudCompare
hl.window_rule({
  name = "windowrule-11",
  match = { title = "^(Open LAS file)$" },
  float = true,
})

hl.window_rule({
  name = "windowrule-12",
  match = { title = "^(Global shift/scale)$" },
  float = true,
})

-- Flameshot
hl.window_rule({
  name = "windowrule-13",
  match = { title = "^(flameshot)" },
  float = true,
  move = "0 0", -- normalized from "(0) (0)"
  suppress_event = "fullscreen",
})

-- screengrab
hl.window_rule({
  name = "windowrule-14",
  match = { class = "^(screengrab)$" },
  float = true,
})

-- Swaync
hl.layer_rule({
  name = "layerrule-1",
  match = { namespace = "swaync-control-center" },
  blur = true,
  ignore_alpha = 0.5,
})

hl.layer_rule({
  name = "layerrule-2",
  match = { namespace = "swaync-notification-window" },
  blur = true,
  ignore_alpha = 0.5,
})

-- Wlogout
hl.layer_rule({
  name = "layerrule-3",
  match = { namespace = "logout_dialog" },
  blur = true,
})

-- Screen share
hl.window_rule({
  name = "windowrule-15",
  match = { class = "^(xwaylandvideobridge)$" },
  opacity = "0.0 override",
  no_anim = true,
  no_initial_focus = true,
  max_size = "1 1",
  no_blur = true,
})

-- Matplotlib
hl.window_rule({
  name = "windowrule-16",
  match = { title = "^(matplotlib)$" },
  float = true,
})

-- Steam
hl.window_rule({
  name = "windowrule-17",
  match = { class = "^(steam)$", title = "^(Friends List)$" },
  float = true,
})

-- QGIS
hl.window_rule({
  name = "windowrule-18",
  match = { class = "^(org\\.qgis\\.qgis)$", title = "^(QGIS3)$" },
  float = true,
})

hl.window_rule({
  name = "windowrule-19",
  match = { class = "^(org\\.qgis\\.qgis)$", title = "^(?!.*QGIS).*$$" },
  float = true,
})

-- Picard
hl.window_rule({
  name = "windowrule-20",
  match = {
    class = "^(Picard)$",
    title = "^(Track Search Results)|(Album Search Results)$",
  },
  size = "1800 600",
  move = "50 50",
})

-- PCManFM-qt
hl.window_rule({
  name = "windowrule-21",
  match = {
    class = "^(pcmanfm-qt)",
    title = "^(Preferences)|(File Properties)|(Copy Files)|(Move Files)|(Delete Files)|(Choose an Application)|(Edit Bookmarks)|(Connect to remote server)$",
  },
  float = true,
})

-- lxqt-archiver
hl.window_rule({
  name = "windowrule-22",
  match = {
    class = "^(lxqt-archiver)$",
    title = "^(Progress)|(Create Archive)$",
  },
  float = true,
})

-- Pomodoro
hl.window_rule({
  name = "windowrule-23",
  match = { class = "^(pomodorolm)$" },
  float = true,
  opacity = "1 0.5",
  no_blur = true,
})

-- PyQt
hl.window_rule({
  name = "windowrule-24",
  match = { title = "^(Abrir arquivos)$" },
  size = "600 500",
})

hl.window_rule({
  name = "windowrule-25",
  match = { title = "^(Salvar arquivo)$" },
  size = "600 500",
})

-- Gimp
hl.window_rule({
  name = "windowrule-26",
  match = { class = "^(file-png)$" },
  float = true,
})

-- Hyprpicker
hl.layer_rule({
  name = "layerrule-4",
  match = { namespace = "hyprpicker" },
  no_anim = true,
})

hl.layer_rule({
  name = "layerrule-5",
  match = { namespace = "selection" },
  no_anim = true,
})

-- Zenity
hl.window_rule({
  name = "windowrule-27",
  match = { class = "^(zenity)$" },
  float = true,
})

-- Arqiver
hl.window_rule({
  name = "windowrule-28",
  match = { class = "^(arqiver)$" },
  float = true,
})
