return {
  {
    "stevearc/dressing.nvim",
    config = true,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      { "rcarriga/nvim-notify", opts = { background_colour = "#1e1e2e" } },
      "hrsh7th/nvim-cmp",
    },
    opts = {
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
        {
          filter = {
            find = "No code actions available",
          },
          opts = { skip = true },
        },
      },
      presets = {
        inc_rename = true,
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
    },
  },
  {
    "lukas-reineke/virt-column.nvim",
    opts = { char = "┊" },
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      {
        "lewis6991/gitsigns.nvim",
        opts = { current_line_blame = true },
      },
    },
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.search").setup()
      require("scrollbar.handlers.gitsigns").setup()

      vim.keymap.set(
        "n",
        "<leader>gp",
        ":Gitsigns preview_hunk<CR>",
        { silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>gt",
        ":Gitsigns toggle_current_line_blame<CR>",
        { silent = true }
      )
    end,
  },
}
