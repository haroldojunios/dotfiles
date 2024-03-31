return {
  {
    "nvim-treesitter/nvim-treesitter",
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
      })
    end,
  },
}
