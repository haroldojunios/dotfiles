return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        auto_sync = true,
        ensure_installed = {
          -- lua
          "lua-language-server",
          "stylua",
          -- bash
          "bash-language-server",
          "shfmt",
          "shellcheck",
          -- python
          "pyright",
          "autopep8",
          -- others
          "codespell",
          -- web-developments
          -- "prettier",
          "prettierd",
          "eslint-lsp",
          "css-lsp",
          "html-lsp",
          "typescript-language-server",
          "emmet-ls",
          "json-lsp",
          "tailwindcss-language-server",
        },
        ui = {
          check_outdated_packages_on_open = true,
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        },
        max_concurrent_installers = 10,
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
