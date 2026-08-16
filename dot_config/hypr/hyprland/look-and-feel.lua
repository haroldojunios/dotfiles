-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

-- See https://wiki.hypr.land/Configuring/Basics/Variables/#general
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 5,

    border_size = 2,

    col = {
      active_border = {
        colors = { "rgba(89b4faee)", "rgba(cba6f7ee)" },
        angle = 45,
      },
      inactive_border = "rgba(6c7086aa)",
    },

    layout = "dwindle",
  },

  decoration = {
    rounding = 10,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 2,
      -- UNCONFIRMED: kept as the same rgba() string your .conf used.
      -- The official example's shadow.color is a numeric 0xAARRGGBB
      -- literal (0xee1a1a1a) rather than an rgba() string, so if this
      -- doesn't render right, try: color = 0xee1e1e2e
      color = "rgba(1e1e2eee)",
    },

    -- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Blur/
    blur = {
      enabled = true,
      size = 5,
      passes = 1,
    },
  },

  misc = {
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
  },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve(
  "myBezier",
  { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } }
)

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 7,
  bezier = "myBezier",
})
hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 7,
  bezier = "default",
  style = "popin 80%",
})
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({
  leaf = "borderangle",
  enabled = true,
  speed = 8,
  bezier = "default",
})
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 6,
  bezier = "default",
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})
