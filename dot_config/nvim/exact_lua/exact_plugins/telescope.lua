return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>xx",
        function()
          require("trouble").toggle()
        end,
        { silent = true },
      },
      {
        "<leader>xw",
        function()
          require("trouble").toggle("workspace_diagnostics")
        end,
        { silent = true },
      },
      {
        "<leader>xd",
        function()
          require("trouble").toggle("document_diagnostics")
        end,
        { silent = true },
      },
      {
        "<leader>xq",
        function()
          require("trouble").toggle("quickfix")
        end,
        { silent = true },
      },
      {
        "<leader>xl",
        function()
          require("trouble").toggle("loclist")
        end,
        { silent = true },
      },
      {
        "gR",
        function()
          require("trouble").toggle("lsp_references")
        end,
        { silent = true },
      },
    },
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    config = function()
      local trouble = require("trouble.sources.telescope")

      require("telescope").setup({
        defaults = {
          mappings = {
            i = { ["<c-t>"] = trouble.open },
            n = { ["<c-t>"] = trouble.open },
          },
        },
        pickers = {
          live_grep = {
            file_ignore_patterns = { "node_modules", ".git", ".venv", "venv" },
            additional_args = function(_)
              return { "--hidden" }
            end,
          },
          find_files = {
            file_ignore_patterns = { "node_modules", ".git", ".venv", "venv" },
            hidden = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf" },
            find_cmd = "fd",
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set(
        "n",
        "<C-p>",
        builtin.find_files,
        { desc = "Search files" }
      )
      vim.keymap.set(
        "n",
        "<leader>ff",
        builtin.find_files,
        { desc = "Search files" }
      )
      vim.keymap.set(
        "n",
        "<C-f>",
        builtin.live_grep,
        { desc = "Search in files" }
      )
      vim.keymap.set(
        "n",
        "<leader>fg",
        builtin.live_grep,
        { desc = "Search in files" }
      )
      vim.keymap.set(
        "n",
        "<leader>fb",
        builtin.buffers,
        { desc = "Search buffers" }
      )
      vim.keymap.set(
        "n",
        "<leader>fd",
        builtin.lsp_document_symbols,
        { desc = "Search document symbols" }
      )
      vim.keymap.set(
        "n",
        "<leader>fw",
        builtin.lsp_workspace_symbols,
        { desc = "Search workspace symbols" }
      )
      vim.keymap.set(
        "n",
        "<leader>fq",
        builtin.quickfix,
        { desc = "Open quickfix" }
      )

      vim.api.nvim_create_autocmd(
        "FileType",
        { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] }
      )

      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("notify")
      require("telescope").load_extension("media_files")
    end,
  },
}
