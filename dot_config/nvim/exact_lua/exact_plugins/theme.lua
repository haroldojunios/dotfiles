return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        comments = { "italic" },
        functions = { "italic" },
        -- ["@markup.italic"] = { "italic" },
        -- ["@markup.bold"] = { "bold" },
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
        lsp_trouble = true,
        which_key = true,
      },
      highlight_overrides = {
        mocha = function(mocha)
          return {
            LineNr = { fg = mocha.overlay2 },
            texStyleArgConcat = { fg = mocha.green },
            ["@markup.italic"] = { fg = mocha.sapphire },
            RenderMarkdownInlineHighlight = {
              bg = mocha.red,
              fg = mocha.base,
            },
          }
        end,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
      vim.o.pumblend = 0
      vim.o.winblend = 0
    end,
  },
}
