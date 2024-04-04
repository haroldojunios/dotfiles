return {
  {
    "kaplanz/retrail.nvim",
    config = function()
      require("retrail").setup()
    end,
  },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = {
      "MCstart",
      "MCvisual",
      "MCclear",
      "MCpattern",
      "MCvisualPattern",
      "MCunderCursor",
    },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>mm",
        "<cmd>MCstart<CR>",
        desc = "Create a selection for selected text or word under the cursor",
      },
      {
        mode = { "n" },
        "<Leader>mv",
        "<cmd>MCvisual<CR>",
        desc = "Create a selection for last visual mode selection",
      },
      {
        mode = { "n" },
        "<Leader>mp",
        "<cmd>MCpattern<CR>",
        desc = "Create a selection for a prompted pattern",
      },
      {
        mode = { "v", "n" },
        "<Leader>mc",
        "<cmd>MCclear<CR>",
        desc = "Clears all the selections",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "eslint_d", { "prettierd", "prettier" } },
          bash = { "shfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
      require("conform").formatters.shfmt = {
        prepend_args = { "-i", "2" },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
