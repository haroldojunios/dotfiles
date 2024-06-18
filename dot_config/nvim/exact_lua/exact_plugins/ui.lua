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
      "hrsh7th/nvim-cmp",
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
          hover = {
            enabled = false,
          },
          progress = {
            enabled = false,
          },
        },
        routes = {
          {
            filter = {
              find = "Ruff failed to handle a request from the editor",
            },
            opts = { skip = true },
          },
        },
        -- views = {
        --   cmdline_popup = {
        --     position = {
        --       row = 5,
        --       col = "50%",
        --     },
        --     size = {
        --       width = 60,
        --       height = "auto",
        --     },
        --   },
        --   popupmenu = {
        --     relative = "editor",
        --     position = {
        --       row = 8,
        --       col = "50%",
        --     },
        --     size = {
        --       width = 60,
        --       height = 10,
        --     },
        --     border = {
        --       style = "rounded",
        --       padding = { 0, 1 },
        --     },
        --     win_options = {
        --       winhighlight = {
        --         Normal = "Normal",
        --         FloatBorder = "DiagnosticInfo",
        --       },
        --     },
        --   },
        -- },
      })
    end,
  },
  {
    "lukas-reineke/virt-column.nvim",
    opts = { char = "┊" },
  },
}
