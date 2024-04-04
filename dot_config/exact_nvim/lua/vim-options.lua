-- change leader key to space
vim.g.mapleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

-- use 2 spaces instead of tabs
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- enable line numbers
vim.wo.number = true

-- enable color column
vim.wo.colorcolumn = "80"

-- enable cursor line
vim.opt.cursorline = true

-- set folding
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false

-- disable swapfile and save undo files
vim.opt.swapfile = false
local undopath = vim.fn.stdpath("data") .. "/undo"
vim.opt.undodir = undopath
if vim.fn.isdirectory(undopath) == 0 then
  vim.fn.mkdir(undopath)
end
vim.opt.undofile = true

if vim.fn.has("unix") then
  local node_dir = vim.env.HOME .. ".local/share/nvm/lts/bin/"
  if vim.fn.isdirectory(node_dir) then
    vim.env.PATH = node_dir .. ":" .. vim.env.PATH
  end
end
