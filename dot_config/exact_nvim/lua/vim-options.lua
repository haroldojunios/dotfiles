local opt = vim.opt

-- change leader key to space
vim.g.mapleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
opt.termguicolors = true

-- use 2 spaces instead of tabs
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- enable line numbers
opt.number = true
opt.relativenumber = true

-- enable color column
opt.colorcolumn = "80"

-- enable cursor line
opt.cursorline = true

-- set splitting mode
opt.splitbelow = true
opt.splitright = true

-- set casing on search
opt.ignorecase = true
opt.smartcase = true

-- set folding
opt.foldmethod = "indent"
opt.foldenable = false

-- set conceal
opt.conceallevel = 2
opt.concealcursor = "nc"

-- disable swapfile and save undo files
opt.swapfile = false
local undopath = vim.fn.stdpath("data") .. "/undo"
opt.undodir = undopath
if vim.fn.isdirectory(undopath) == 0 then
  vim.fn.mkdir(undopath)
end
opt.undofile = true

if vim.fn.has("unix") then
  local node_dir = vim.env.HOME .. ".local/share/nvm/lts/bin/"
  if vim.fn.isdirectory(node_dir) then
    vim.env.PATH = node_dir .. ":" .. vim.env.PATH
  end
end
