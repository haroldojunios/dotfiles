return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float",
    open_mapping = [[<C-'>]],
    auto_scroll = false,
    float_opts = {
      border = "curved",
    },
    on_open = function(t)
      vim.wo[t.window].cc = ""
      if package.loaded["virt-column"] then
        require("virt-column").setup_buffer({ virtcolumn = "" })
      end
    end,
  },
}
