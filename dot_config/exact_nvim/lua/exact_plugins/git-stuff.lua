return {
  {
    "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
      vim.keymap.set(
        "n",
        "<leader>gt",
        ":Gitsigns toggle_current_line_blame<CR>",
        {}
      )
    end,
  },
  {
    {
      "kdheepak/lazygit.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("telescope").load_extension("lazygit")

        vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
      end,
    },
  },
}
