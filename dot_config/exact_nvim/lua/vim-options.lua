vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set foldmethod=indent")
vim.cmd("set nofoldenable")

vim.g.mapleader = " "

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

-- Navigate vim panes better
vim.keymap.set("n", "<A-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<A-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<A-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<A-l>", ":wincmd l<CR>", { silent = true })

-- Move lines
vim.keymap.set("n", "<C-j>", ":m+<CR>==", { silent = true })
vim.keymap.set("n", "<C-k>", ":m-2<CR>==", { silent = true })
vim.keymap.set("i", "<C-j>", "<Esc>:m+<CR>==gi", { silent = true })
vim.keymap.set("i", "<C-k>", "<Esc>:m-2<CR>==gi", { silent = true })
vim.keymap.set("n", "<C-Down>", ":m+<CR>==", { silent = true })
vim.keymap.set("n", "<C-Up>", ":m-2<CR>==", { silent = true })
vim.keymap.set("i", "<C-Down>", "<Esc>:m+<CR>==gi", { silent = true })
vim.keymap.set("i", "<C-Up>", "<Esc>:m-2<CR>==gi", { silent = true })

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })
vim.wo.number = true

vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", ":w<CR>", { silent = true })

if vim.fn.has("unix") then
  local node_dir = vim.env.HOME .. ".local/share/nvm/lts/bin/"
  if vim.fn.isdirectory(node_dir) then
    vim.env.PATH = node_dir .. ":" .. vim.env.PATH
  end
end
