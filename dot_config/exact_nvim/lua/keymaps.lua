-- -- Navigate vim panes better
-- vim.keymap.set("n", "<A-k>", ":wincmd k<CR>", { silent = true })
-- vim.keymap.set("n", "<A-j>", ":wincmd j<CR>", { silent = true })
-- vim.keymap.set("n", "<A-h>", ":wincmd h<CR>", { silent = true })
-- vim.keymap.set("n", "<A-l>", ":wincmd l<CR>", { silent = true })

-- -- Move lines
-- vim.keymap.set("n", "<C-j>", ":m+<CR>==", { silent = true })
-- vim.keymap.set("n", "<C-k>", ":m-2<CR>==", { silent = true })
-- vim.keymap.set("i", "<C-j>", "<Esc>:m+<CR>==gi", { silent = true })
-- vim.keymap.set("i", "<C-k>", "<Esc>:m-2<CR>==gi", { silent = true })
-- vim.keymap.set("n", "<C-Down>", ":m+<CR>==", { silent = true })
-- vim.keymap.set("n", "<C-Up>", ":m-2<CR>==", { silent = true })
-- vim.keymap.set("i", "<C-Down>", "<Esc>:m+<CR>==gi", { silent = true })
-- vim.keymap.set("i", "<C-Up>", "<Esc>:m-2<CR>==gi", { silent = true })

-- erase word with ^BS
vim.keymap.set("i", "<C-BS>", "<C-w>", { silent = true })

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })

-- map ^S to save
vim.keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>gi", { silent = true })

-- map ^Q to quit
vim.keymap.set("n", "<C-q>", ":qa<CR>", { silent = true })
vim.keymap.set("i", "<C-q>", "<Esc>:qa<CR>", { silent = true })

-- code action keymaps
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
