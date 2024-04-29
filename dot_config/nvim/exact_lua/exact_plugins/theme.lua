return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        styles = {
          functions = { "italic" },
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
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
