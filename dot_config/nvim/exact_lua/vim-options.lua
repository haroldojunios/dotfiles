local g = vim.g
local opt = vim.opt

-- change leader key to space
g.mapleader = " "
g.maplocalleader = " "

-- disable netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- disable markdown style recommendations
g.markdown_recommended_style = 0

-- enable 24-bit colour
opt.termguicolors = true

-- use 2 spaces instead of tabs
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- enable softwrap
opt.wrap = true
opt.linebreak = true

-- enable line numbers
opt.number = true
opt.relativenumber = true

-- enable color column
opt.colorcolumn = "80"

-- increase scrollback
opt.scrollback = 20000

-- enable cursor line
opt.cursorline = true

-- use system clipboard
-- opt.clipboard = "unnamedplus"

-- set splitting mode
opt.splitbelow = true
opt.splitright = true

-- set casing on search
opt.ignorecase = true
opt.smartcase = true

-- set spellcheck
opt.spell = true
opt.spelllang = { "en", "pt_br" }
opt.spelloptions:append("camel")
opt.spellfile = {
  vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/pt.utf-8.add",
}

-- set folding
opt.foldmethod = "indent"
opt.foldenable = false

-- set conceal
opt.conceallevel = 2
opt.concealcursor = "nc"

-- set scrolloff
opt.scrolloff = 7
opt.sidescrolloff = 7

-- set listchars
opt.list = true
opt.listchars = {
  tab = "▸-",
  trail = "·",
  lead = "·",
  precedes = "«",
  extends = "»",
  nbsp = "␣",
}

-- set inccommand to split
opt.inccommand = "split"

-- set Mouse Event for bufferline hover
opt.mousemoveevent = true

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
