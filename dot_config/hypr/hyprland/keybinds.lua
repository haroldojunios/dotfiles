-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local programs = require("hyprland.programs")
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(
  mainMod .. " + SHIFT + M",
  hl.dsp.exec_cmd("sleep1; hyprctl dispatch dpms off")
)
hl.bind(
  mainMod .. " + SHIFT + F",
  hl.dsp.window.fullscreen({ mode = "fullscreen" })
)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + Super_L", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(
  mainMod .. " + V",
  hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy")
)
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Swap window with mainMod + shift + arrow keys
-- UNCONFIRMED: window.swap() is not shown in the official example
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "d" }))

-- Swap window with mainMod + shift + vim keys
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(
    mainMod .. " + SHIFT + " .. key,
    hl.dsp.window.move({ workspace = i })
  )
end

-- -- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Scroll through existing workspaces with mainMod + tab
hl.bind("ALT + TAB", hl.dsp.focus({ workspace = "previous_per_monitor" }))
hl.bind("ALT + SHIFT + TAB", hl.dsp.exec_cmd("~/.config/hypr/scripts/switch"))
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("ddcutil setvcp 10 + 5"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("ddcutil setvcp 10 - 5"),
  { locked = true, repeating = true }
)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(
  "XF86AudioPause",
  hl.dsp.exec_cmd("playerctl play-pause"),
  { locked = true }
)
hl.bind(
  "XF86AudioPlay",
  hl.dsp.exec_cmd("playerctl play-pause"),
  { locked = true }
)
hl.bind(
  "XF86AudioPrev",
  hl.dsp.exec_cmd("playerctl previous"),
  { locked = true }
)
hl.bind("XF86Explorer", hl.dsp.exec_cmd(programs.fileManager))
hl.bind("XF86Search", hl.dsp.exec_cmd(programs.browser))
hl.bind("XF86Calculator", hl.dsp.exec_cmd(programs.calculator))
hl.bind("XF86Tools", hl.dsp.exec_cmd("qbittorrent"))

-- Multimedia keys with swayosd
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("swayosd-client --output-volume +5"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("swayosd-client --output-volume -5"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),
  { locked = true, repeating = true }
)
hl.bind(
  "CAPS + Caps_Lock",
  hl.dsp.exec_cmd("swayosd-client --caps-lock"),
  { release = true }
)
hl.bind(
  "MOD2 + Num_Lock",
  hl.dsp.exec_cmd("swayosd-client --num-lock"),
  { release = true }
) -- xmodmap

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot sc"))
hl.bind(
  mainMod .. " + Print",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot rf")
)
hl.bind("CTRL + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot ri"))
hl.bind(
  "SHIFT + Print",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot rc")
)
hl.bind(
  mainMod .. " + SHIFT + Print",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot sf")
)
hl.bind(
  "CTRL + SHIFT + Print",
  hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot si")
)
hl.bind("ALT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot p"))

hl.bind(mainMod .. " + z", hl.dsp.submap("passthru"))
hl.define_submap("passthru", function()
  hl.bind(mainMod .. " + escape", hl.dsp.submap("reset"))
end)
