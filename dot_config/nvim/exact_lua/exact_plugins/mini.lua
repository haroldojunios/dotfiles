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
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "echasnovski/mini.sessions",
    version = false,
    config = function()
      require("mini.sessions").setup({ autowrite = false })
      if next(vim.fn.argv()) == nil then
        local session_name = vim.loop.cwd():gsub("/", "_")
        local session_file = vim.fn.stdpath("data")
          .. "/session/"
          .. session_name
        if vim.loop.fs_stat(session_file) then
          MiniSessions.read(session_name)
        end

        local autowrite = function()
          -- -- write session with default name even if not currently in session
          -- if vim.v.this_session == "" then
          --   session_name = vim.loop.cwd():gsub("/", "_")
          -- end
          MiniSessions.write(session_name, { force = true })
        end
        vim.api.nvim_create_autocmd(
          "VimLeavePre",
          { callback = autowrite, desc = "Autowrite session" }
        )
      end
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
