vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "*.sh.tmpl", command = "set filetype=bash" }
)
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "*.fish.tmpl", command = "set filetype=fish" }
)
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "*.py.tmpl", command = "set filetype=python" }
)
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "*.toml.tmpl", command = "set filetype=toml" }
)
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "*.ps1.tmpl", command = "set filetype=ps1" }
)
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "*aliases.tmpl", command = "set filetype=sh" }
)
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "*bashrc.tmpl", command = "set filetype=sh" }
)
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "conky.conf*", command = "set filetype=lua" }
)
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { pattern = "fish_variables", command = "set filetype=fish" }
)
