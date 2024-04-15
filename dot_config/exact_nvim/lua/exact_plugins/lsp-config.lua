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
      -- vim.cmd("MasonUpdateAll")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
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

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
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
        "fish",
        "fixjson",
        "hadolint",
        "isort",
        "markdownlint",
        "mypy",
        "prettierd",
        "ruff",
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
        handlers = {},
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   lazy = false,
  --   config = function()
  --     vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
  --     vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
  --     vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
  --     vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  --   end,
  -- },
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      require("actions-preview").setup({
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      })

      vim.keymap.set(
        { "v", "n" },
        "gf",
        require("actions-preview").code_actions
      )
    end,
  },
}
