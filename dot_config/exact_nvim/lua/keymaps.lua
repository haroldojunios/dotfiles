local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Navigate vim panes better
map("n", "<A-k>", ":wincmd k<CR>")
map("n", "<A-j>", ":wincmd j<CR>")
map("n", "<A-h>", ":wincmd h<CR>")
map("n", "<A-l>", ":wincmd l<CR>")

-- erase word to the start with ^BS
map("n", "<C-BS>", '"_db')
map("i", "<C-BS>", "<C-w>")

--erase word to the end with ^Del
map("n", "<C-Del>", '"_dw')
map("i", "<C-Del>", '<C-o>"_dw')

-- remove highlight search
map("n", "<leader>h", ":nohlsearch<CR>")

-- map ^S to save
map("n", "<C-s>", ":w<CR>")
map("i", "<C-s>", "<Esc>:w<CR>gi")

-- map ^Q to quit
map("n", "<C-q>", ":qa<CR>")
map("i", "<C-q>", "<Esc>:qa<CR>")

-- code action keymaps
map(
  { "n", "v" },
  "<leader>a",
  vim.lsp.buf.code_action,
  { desc = "code action" }
)
map("n", "<leader>n", vim.diagnostic.goto_next, { desc = "next diagnostic" })
map(
  "n",
  "<leader>p",
  vim.diagnostic.goto_next,
  { desc = "previous diagnostic" }
)
