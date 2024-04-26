return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Spectre",
    keys = {
      {
        "<leader>ss",
        '<cmd>lua require("spectre").toggle()<CR>',
        desc = "Toggle Spectre",
        silent = true,
      },
      {
        "<leader>sw",
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        desc = "Search current word",
        silent = true,
      },
      {
        "<leader>sw",
        '<esc><cmd>lua require("spectre").open_visual()<CR>',
        desc = "Search current selection",
        silent = true,
        mode = "v",
      },
      {
        "<leader>sf",
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "Search on current file",
        silent = true,
      },
    },
  },
}
