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
        bash = { "trim_whitespace", "shfmt" },
        sh = { "trim_whitespace", "shfmt" },
        css = { "prettierd" },
        fish = { "fish_indent" },
        html = { "prettierd" },
        javascript = { "eslint_d", "prettierd" },
        javascriptreact = { "eslint_d", "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        lua = { "stylua" },
        markdown = { "mdformat", "injected" },
        prisma = { "prisma" },
        python = { "ruff_fix", "ruff_format" },
        -- tex = { "latexindent" },
        typescript = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
        ["_"] = { "trim_newlines", "trim_whitespace" },
      },
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
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
        prisma = {
          command = "prisma",
          args = { "format", "--schema", "$FILENAME" },
          stdin = false,
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
