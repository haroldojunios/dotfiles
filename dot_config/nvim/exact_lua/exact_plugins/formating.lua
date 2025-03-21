local slow_format_filetypes = {}

return {

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
        markdown = { "prettierd", "injected" },
        -- prisma = { "prisma" },
        python = { "ruff_fix", "ruff_format" },
        quarto = { "prettierd", "injected" },
        tex = { "latexindent" },
        toml = { "taplo" },
        typescript = { "eslint_d", "prettierd" },
        typescriptreact = { "eslint_d", "prettierd" },
        yaml = { "prettierd" },
        ["_"] = { "trim_newlines", "trim_whitespace" },
      },
      -- format_on_save = { timeout_ms = 500, lsp_fallback = true },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if
          vim.g.disable_autoformat
          or vim.b[bufnr].disable_autoformat
          or slow_format_filetypes[vim.bo[bufnr].filetype]
        then
          return
        end
        local function on_format(err)
          if err and err:match("timeout$") then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end
        return { timeout_ms = 500, lsp_format = "fallback" }, on_format
      end,
      format_after_save = function(bufnr)
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { lsp_format = "fallback" }
      end,
      formatters = {
        mdformat = {
          prepend_args = { "--number", "--wrap", "79" },
        },
        -- prettierd = {
        --   append_args = { "--print-width", "79", "--prose-wrap", "always" },
        -- },
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
        latexindent = {
          prepend_args = { "-m" },
        },
        prisma = {
          command = "prisma",
          args = { "format", "--schema", "$FILENAME" },
          stdin = false,
        },
        prettierd = {
          args = function(self, ctx)
            if vim.bo[ctx.buf].filetype == "jsonc" then
              return { "$FILENAME.json" }
            end
            return { "$FILENAME" }
          end,
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
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { enable_check_bracket_line = false, fast_wrap = { map = "<M-s>" } },
  },
}
