-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({ output = "", mode = "highrr", position = "auto", scale = "auto" })
hl.monitor({ output = "DP-1", mode = "highrr", position = "0x0", scale = 1 })
hl.monitor({
  output = "HDMI-A-1",
  mode = "highrr",
  position = "1920x0",
  scale = 1,
})

-- Workspaces per monitor
hl.workspace_rule({ workspace = 1, monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = 2, monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = 3, monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = 4, monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = 5, monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = 6, monitor = "HDMI-A-1", default = true })
