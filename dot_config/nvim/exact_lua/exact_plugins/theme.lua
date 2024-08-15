return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        functions = { "italic" },
      },
      term_colors = true,
      dim_inactive = {
        enabled = true,
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
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
