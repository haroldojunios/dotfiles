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

      -- install mdformat plugins
      local registry_status_ok, mason_registry =
        pcall(require, "mason-registry")
      if not registry_status_ok then
        return
      end

      mason_registry.refresh(function()
        local mdformat = mason_registry.get_package("mdformat")
        local mdformat_extensions = {
          "mdformat-gfm",
          "mdformat-toc",
          -- "mdformat-myst",
          "mdformat-admon",
          "mdformat-frontmatter",
          "mdformat-footnote",
          "mdformat-gfm-alerts",
        }
        mdformat:on("install:success", function()
          -- Create the installation command.
          vim.notify("Installing mdformat extensions.", vim.log.levels.INFO)
          local extensions = table.concat(mdformat_extensions, " ")
          local python = mdformat:get_install_path() .. "/venv/bin/python"
          local pip_cmd =
            string.format("%s -m pip install %s", python, extensions)

          vim.notify(pip_cmd, vim.log.levels.INFO)

          -- vim.fn.jobstart doesn't work in callback so use popen instead.
          local handle = io.popen(pip_cmd)
          if not handle then
            vim.notify(
              "Could not install mdformat extensions.",
              vim.log.levels.ERROR
            )
            return
          end
          local _ = handle:read("*a")
          handle:close()

          vim.notify("Mdformat extensions were successfully installed.")
        end)
      end)
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
        "ltex",
        "prismals",
        "pyright",
        -- "tailwindcss",
        "ruff_lsp",
        "ts_ls",
        "yamlls",
      }
      if os.getenv("PREFIX") == nil then
        table.insert(ensure_installed, "lua_ls")
      end

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
        ["ltex"] = function()
          lspconfig.ltex.setup({
            settings = {
              ltex = {
                language = "auto",
              },
            },
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            settings = {
              pyright = {
                disableOrganizeImports = true, -- Using Ruff
              },
              python = {
                analysis = {
                  ignore = { "*" }, -- Using Ruff
                  typeCheckingMode = "off", -- Using mypy
                },
              },
            },
          })
        end,
      })

      -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      -- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
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
        -- "codespell",
        "eslint_d",
        "fish",
        "fixjson",
        "hadolint",
        "isort",
        "markdownlint",
        "mdformat",
        "mypy",
        "prettierd",
        "ruff",
        "shellcheck",
        "shfmt",
        "sqlfmt",
        "taplo",
        "yamlfmt",
      }
      if os.getenv("PREFIX") == nil then
        table.insert(ensure_installed, "latexindent")
        table.insert(ensure_installed, "stylua")
      end

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
        ensure_installed = ensure_installed,
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
}
