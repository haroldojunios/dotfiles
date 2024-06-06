return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float",
      open_mapping = [[<C-'>]],
      float_opts = {
        border = "curved",
      },
      on_open = function(t)
        vim.wo[t.window].cc = ""
        if package.loaded["virt-column"] then
          require("virt-column").setup_buffer({ virtcolumn = "" })
        end
      end,
    })
  end,
}
