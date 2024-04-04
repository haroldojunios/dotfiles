return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    dependencies = {
      "RubixDev/mason-update-all",
    },
    config = function()
      require("mason").setup({
        auto_sync = true,
        ui = {
          check_outdated_packages_on_open = true,
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        max_concurrent_installers = 10,
      })

      require("mason-update-all").setup()
      vim.cmd("MasonUpdateAll")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      local ensure_installed = {
        "bashls",
        "cssls",
        "emmet_ls",
        "eslint",
        "html",
        "jsonls",
        "pyright",
        "tailwindcss",
        "tsserver",
        "yamlls",
      }
      if os.getenv("PREFIX") == nil then
        table.insert(ensure_installed, "lua_ls")
      end

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      local ensure_installed = {
        "black",
        "clang_format",
        "cmake_format",
        "codespell",
        "fixjson",
        "hadolint",
        "isort",
        "markdownlint",
        "mypy",
        "prettierd",
        "shellcheck",
        "shfmt",
        "sqlfmt",
        "yamlfmt",
      }
      if os.getenv("PREFIX") == nil then
        table.insert(ensure_installed, "latexindent")
        table.insert(ensure_installed, "stylua")
      end

      require("mason-null-ls").setup({
        ensure_installed = ensure_installed,
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
