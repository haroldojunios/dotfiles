return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    -- opts = ,
    config = function()
      local utils = require("catppuccin.utils.colors")

      require("catppuccin").setup({
        styles = {
          comments = { "italic" },
          functions = { "italic" },
        },
        transparent_background = true,
        term_colors = true,
        dim_inactive = {
          enabled = false,
        },
        integrations = {
          gitsigns = true,
          mason = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          neotree = true,
          noice = true,
          nvim_surround = true,
          render_markdown = true,
          lsp_trouble = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          return {
            LineNr = { fg = colors.overlay2 },
            texStyleArgConcat = { fg = colors.green },
            ["@markup.italic"] = { fg = colors.sapphire },
            ["@markup.strong"] = { fg = colors.lavender },
            ["@markup.strikethrough"] = { fg = colors.red },
            ["@markup.quote.markdown"] = { fg = colors.mauve },
            RenderMarkdownQuote = { fg = colors.mauve },
            RenderMarkdownBullet = { fg = colors.pink },
            RenderMarkdownInlineHighlight = {
              bg = colors.lavender,
              fg = colors.base,
            },
            ["@markup.heading.1.markdown"] = { fg = colors.mauve },
            ["@markup.heading.2.markdown"] = { fg = colors.blue },
            ["@markup.heading.3.markdown"] = { fg = colors.green },
            ["@markup.heading.4.markdown"] = { fg = colors.peach },
            ["@markup.heading.5.markdown"] = { fg = colors.yellow },
            ["@markup.heading.6.markdown"] = { fg = colors.pink },
            RenderMarkdownH1 = { fg = colors.mauve },
            RenderMarkdownH2 = { fg = colors.blue },
            RenderMarkdownH3 = { fg = colors.green },
            RenderMarkdownH4 = { fg = colors.peach },
            RenderMarkdownH5 = { fg = colors.yellow },
            RenderMarkdownH6 = { fg = colors.pink },
            RenderMarkdownH1Bg = {
              fg = colors.mauve,
              bg = utils.darken(colors.mauve, 0.33),
            },
            RenderMarkdownH2Bg = {
              fg = colors.blue,
              bg = utils.darken(colors.blue, 0.33),
            },
            RenderMarkdownH3Bg = {
              fg = colors.green,
              bg = utils.darken(colors.green, 0.33),
            },
            RenderMarkdownH4Bg = {
              fg = colors.peach,
              bg = utils.darken(colors.peach, 0.33),
            },
            RenderMarkdownH5Bg = {
              fg = colors.yellow,
              bg = utils.darken(colors.yellow, 0.33),
            },
            RenderMarkdownH6Bg = {
              fg = colors.pink,
              bg = utils.darken(colors.pink, 0.33),
            },
            RenderMarkdownDash = { fg = colors.lavender },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
      vim.o.pumblend = 0
      vim.o.winblend = 0
    end,
  },
}
