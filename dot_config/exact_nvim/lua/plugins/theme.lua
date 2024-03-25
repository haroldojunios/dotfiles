return {
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        -- highlights = {
        --   Comment = { italic = true },
        --   Directory = { bold = true },
        --   ErrorMsg = { italic = true, bold = true },
        -- },
        highlights = {
          Identifier = { fg = "${fg}" },
        },
        styles = {
          types = "NONE",
          methods = "NONE",
          numbers = "NONE",
          strings = "NONE",
          comments = "italic",
          keywords = "bold,italic",
          constants = "NONE",
          functions = "italic",
          operators = "NONE",
          variables = "NONE",
          parameters = "NONE",
          conditionals = "italic",
          virtual_text = "NONE",
        },
        colors = {
          bg = "#161926", -- add 1 to get opaque bg
          fg = "#c3c7d1",
          black = "#282c34",
          blue = "#7cb7ff",
          cyan = "#00c1e4",
          gray = "#5c6370",
          green = "#71f79f",
          orange = "#ff6a00",
          purple = "#c74ded",
          red = "#ed254e",
          white = "#dcdfe4",
          yellow = "#f9dc5c",
          comment = "#828997",
          highlight = "#5c6370",
        },
        options = {
          cursorline = true,
          terminal_colors = false,
          highlight_inactive_windows = true,
        },
      })
      vim.cmd.colorscheme("onedark")
    end,
  },
  -- {
  --   "svermeulen/text-to-colorscheme.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = "dark"
  --
  --     require("text-to-colorscheme").setup({
  --       ai = {
  --         openai_api_key = os.getenv("OPENAI_API_KEY"),
  --       },
  --       hex_palettes = {
  --         {
  --           name = "circus",
  --           background_mode = "dark",
  --           background = "#2b2a2f",
  --           foreground = "#f7f7f7",
  --           accents = {
  --             "#ffcb6b",
  --             "#4dd279",
  --             "#cfd485",
  --             "#57c7ff",
  --             "#ff6ac1",
  --             "#9a79d7",
  --             "#ff5c57",
  --           },
  --         },
  --       },
  --       default_palette = "circus",
  --     })
  --
  --     vim.cmd.colorscheme("text-to-colorscheme")
  --   end,
  -- },
  -- {
  --   "echasnovski/mini.base16",
  --   version = false,
  --   config = function()
  --     require("mini.base16").setup({
  --       palette = {
  --         base00 = "#112641",
  --         base01 = "#3a475e",
  --         base02 = "#606b81",
  --         base03 = "#8691a7",
  --         base04 = "#d5dc81",
  --         base05 = "#e2e98f",
  --         base06 = "#eff69c",
  --         base07 = "#fcffaa",
  --         base08 = "#ffcfa0",
  --         base09 = "#cc7e46",
  --         base0A = "#46a436",
  --         base0B = "#9ff895",
  --         base0C = "#ca6ecf",
  --         base0D = "#42f7ff",
  --         base0E = "#ffc4ff",
  --         base0F = "#00a5c5",
  --       },
  --       use_cterm = true,
  --       plugins = {
  --         default = true,
  --       },
  --     })
  --   end,
  -- },
}
