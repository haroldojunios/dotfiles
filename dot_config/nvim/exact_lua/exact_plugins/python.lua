return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python",
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  config = function()
    require("venv-selector").setup({})

    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Auto select virtualenv Nvim open",
      pattern = "*",
      callback = function()
        local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
        if venv ~= "" then
          require("venv-selector").retrieve_from_cache()
        end
      end,
      once = true,
    })
  end,
  event = "VeryLazy",
  branch = "regexp",
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
    -- Keymap to retrieve the venv from a cache.
    { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  },
}
