return {
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup()
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup()
    end,
  },
  {
    "echasnovski/mini.cursorword",
    version = false,
    config = function()
      require("mini.cursorword").setup()
    end,
  },
  {
    "echasnovski/mini.sessions",
    version = false,
    config = function()
      require("mini.sessions").setup({ autoread = true })
    end,
  },
  {
    "echasnovski/mini.move",
    version = false,
    config = function()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode
          left = "<C-h>",
          right = "<C-l>",
          down = "<C-j>",
          up = "<C-k>",

          -- Move current line in Normal mode
          line_left = "<C-h>",
          line_right = "<C-l>",
          line_down = "<C-j>",
          line_up = "<C-k>",
        },
      })
    end,
  },
  {
    "echasnovski/mini.files",
    version = false,
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (directory of current file)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.loop.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    config = function()
      require("mini.files").setup({
        windows = {
          preview = true,
          width_preview = 100,
        },
      })
    end,
  },
}
