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
          "cmake",
          "comment",
          "cpp",
          "css",
          "csv",
          "diff",
          "dockerfile",
          "dot",
          "fish",
          "git_config",
          "git_rebase",
          "gitcommit",
          "gitignore",
          "gotmpl",
          "html",
          "htmldjango",
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
          "mermaid",
          "python",
          "requirements", -- pip-requirements
          "scss",
          "sql",
          "ssh_config",
          "strace",
          "toml",
          "tsv",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "xml",
          "yaml",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "latex", "markdown" },
        },
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
