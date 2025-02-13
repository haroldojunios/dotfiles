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

-- not remove indent when going to normal mode
map("i", "<CR>", "<CR>.<BS>")

-- delete without yanking
map({ "n", "v" }, "d", '"_d')

-- move by visual lines
map({ "n", "v" }, "<M-j>", "gj")
map({ "n", "v" }, "<M-k>", "gk")

-- exit insert mode with jk
map("i", "jk", "<Esc>")

-- remove s keymap
map({ "n", "v" }, "s", "<Nop>")

-- paste on new line
map("n", "<leader>p", ":pu<CR>")
map("n", "<leader>P", ":pu!<CR>")
