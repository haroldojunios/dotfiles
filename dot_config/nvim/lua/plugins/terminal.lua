return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      open_mapping = [[<c-\>]],
      float_opts = {
        border = "curved",
      },
    })
  end,
}
