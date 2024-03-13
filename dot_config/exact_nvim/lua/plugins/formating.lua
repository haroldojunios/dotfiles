return {
  {
    "kaplanz/retrail.nvim",
    config = function()
      require("retrail").setup()
    end,
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
          timeout_ms = 2500,
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
