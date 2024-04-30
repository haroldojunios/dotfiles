return {
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
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>ft",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        bash = { "shfmt" },
        sh = { "shfmt" },
        css = { { "prettierd", "prettier" } },
        fish = { "fish_indent" },
        html = { { "prettierd", "prettier" } },
        javascript = { "eslint_d", { "prettierd", "prettier" } },
        javascriptreact = { "eslint_d", { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        jsonc = { { "prettierd", "prettier" } },
        lua = { "stylua" },
        markdown = { "mdformat", "injected" },
        python = { { "ruff_fix", "isort" }, { "ruff_format", "black" } },
        -- tex = { "latexindent" },
        typescript = { "eslint_d", { "prettierd", "prettier" } },
        typescriptreact = { "eslint_d", { "prettierd", "prettier" } },
        ["_"] = { "trim_newlines", "trim_whitespace" },
      },
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      format_after_save = { lsp_fallback = true },
      formatters = {
        mdformat = {
          prepend_args = { "--number", "--wrap", "80" },
        },
        ruff_fix = {
          args = {
            "check",
            "--fix",
            "--select",
            "I",
            "--force-exclude",
            "--exit-zero",
            "--no-cache",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
        },
        ruff_format = {
          args = {
            "format",
            "--line-length",
            "79",
            "--force-exclude",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
        },
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
