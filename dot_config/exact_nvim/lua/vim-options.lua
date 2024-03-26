vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set foldmethod=indent")
vim.cmd("set nofoldenable")

vim.g.mapleader = " "

-- disable netrw
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
vim.wo.colorcolumn = "80"

vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>gi", { silent = true })

vim.keymap.set(
  { "n", "v" },
  "<space>a",
  vim.lsp.buf.code_action,
  { desc = "code action" }
)
vim.keymap.set(
  "n",
  "<space>n",
  vim.diagnostic.goto_next,
  { desc = "next diagnostic" }
)
vim.keymap.set(
  "n",
  "<space>p",
  vim.diagnostic.goto_next,
  { desc = "previous diagnostic" }
)

-- Disable swapfile and save undo files
vim.cmd("set noswapfile")
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
