return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle",
  event = { "InsertLeave", "TextChanged" },
  keys = {
    { "<leader>as", ":ASToggle<CR>", desc = "Toggle auto-save" },
  },
  opts = {
    enabled = false,
  },
}
