return {
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
      })
    end,
  },
  {
    "xiyaowong/virtcolumn.nvim",
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   config = function()
  --     require("ibl").setup()
  --   end,
  -- },
}
