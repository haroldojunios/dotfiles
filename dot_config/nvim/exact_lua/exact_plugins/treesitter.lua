return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-refactor" },
    build = ":TSUpdate",
    config = function()
      local ensure_installed = {
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
        "hyprlang",
        "ini",
        "javascript",
        "json",
        "json5",
        "jsonc",
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
      }
      local ignore_installed = {}

      if os.getenv("PREFIX") == nil then
        table.insert(ensure_installed, "latex")
      else
        table.insert(ignore_installed, "latex")
      end

      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = ensure_installed,
        ignore_installed = ignore_installed,
        highlight = {
          enable = true,
          disable = { "csv" },
          -- additional_vim_regex_highlighting = { "latex", "markdown" },
        },
        indent = { enable = true },
        -- refactor
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufEnter",
    keys = {
      {
        "[c",
        function()
          require("treesitter-context").go_to_context(vim.v.count1)
        end,
        { silent = true },
      },
    },
  },
}
