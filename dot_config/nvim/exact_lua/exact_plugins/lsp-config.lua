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
        "hyprls",
        "jsonls",
        "pyright",
        "ts_ls",
        "yamlls",
      }

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
        automatic_enable = true,
      })

      -- local lspconfig = require("lspconfig")
      --
      -- require("mason-lspconfig").setup_handlers({
      --   function(server_name)
      --     lspconfig[server_name].setup({})
      --   end,
      --   ["ltex"] = function()
      --     lspconfig.ltex.setup({
      --       settings = {
      --         ltex = {
      --           language = "auto",
      --         },
      --       },
      --     })
      --   end,
      --   ["pyright"] = function()
      --     lspconfig.pyright.setup({
      --       settings = {
      --         pyright = {
      --           disableOrganizeImports = true, -- Using Ruff
      --         },
      --         python = {
      --           analysis = {
      --             ignore = { "*" }, -- Using Ruff
      --             typeCheckingMode = "off", -- Using mypy
      --           },
      --         },
      --       },
      --     })
      --   end,
      --   ["tinymist"] = function()
      --     lspconfig.tinymist.setup({
      --       settings = {
      --         formatterMode = "typstyle",
      --         exportPdf = "onType",
      --         semanticTokens = "disable",
      --       },
      --     })
      --   end,
      -- })
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
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.mypy.with({
            extra_args = function()
              local virtual = os.getenv("VIRTUAL_ENV")
                or os.getenv("CONDA_PREFIX")
                or "/usr"
              return { "--python-executable", virtual .. "/bin/python3" }
            end,
          }),
        },
      })

      require("mason-null-ls").setup({
        handlers = {},
      })
    end,
  },
  {
    "ray-x/navigator.lua",
    dependencies = {
      "neovim/nvim-lspconfig",
      { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
    },
    opts = {
      keymaps = {
        {
          key = "<Space>ft",
          func = vim.lsp.buf.format,
          mode = "n",
          desc = "format",
        },
        {
          key = "<Space>ft",
          func = vim.lsp.buf.range_formatting,
          mode = "v",
          desc = "range format",
        },
        {
          key = "gK",
          func = vim.lsp.buf.signature_help,
          mode = "n",
          desc = "signature_help",
        },
      },
      mason = true,
      lsp = {
        enable = true,
        disable_lsp = "all",
        format_on_save = false,
        document_highlight = false,
      },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    config = function()
      require("inc_rename").setup({
        --input_buffer_type = "dressing",
      })

      vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true })
    end,
  },
  {
    -- for lsp features in code cells / embedded code
    "jmbuhr/otter.nvim",
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
    },
  },
}
