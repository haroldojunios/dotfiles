return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-refactor" },
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        ensure_installed = {
          "bash",
          "bibtex",
          "c",
          "csv",
          "dockerfile",
          "fish",
          "git_config",
          "git_rebase",
          "gitignore",
          "html",
          "ini",
          "javascript",
          "json",
          "json5",
          "jsonc",
          "latex",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
          "requirements", -- pip-requirements
          "sql",
          "ssh_config",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "xml",
          "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        -- refactor
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "grr",
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufEnter",
    keys = {
      {
        "n",
        "[c",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        { silent = true },
      },
    },
  },
}
