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

local has_wk, wk = pcall(require, "which-key")

local has_zk, _ = pcall(require, "zk")
if has_zk then
  -- Create a new note after asking for its title.
  map(
    "n",
    "<leader>zn",
    "<Cmd>ZkNew { title=vim.fn.input('Title: ') }<CR>",
    { desc = "Create a new note" }
  )
  -- Create a new daily note.
  map(
    "n",
    "<leader>zd",
    "<Cmd>ZkNew { group = 'daily' }<CR>",
    { desc = "Create a new daily note" }
  )
  -- Create a new daily note for any date.
  map(
    "n",
    "<leader>zD",
    "<Cmd>ZkNew { group = 'daily', date = vim.fn.input('Date: ') }<CR>",
    { desc = "Create a new daily note for any date" }
  )
  -- Open notes.
  map(
    "n",
    "<leader>zo",
    "<Cmd>ZkNotes { sort = { 'modified' } }<CR>",
    { desc = "Open notes" }
  )
  -- Open notes associated with the selected tags.
  map("n", "<leader>zt", "<Cmd>ZkTags<CR>", { desc = "Open tags" })
  -- Search for the notes matching a given query.
  map(
    "n",
    "<leader>zf",
    "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
    { desc = "Search notes" }
  )
  -- Search for the notes matching the current visual selection.
  map("v", "<leader>zf", ":'<,'>ZkMatch<CR>", { desc = "Search notes" })
  -- Index notes.
  map("n", "<leader>zi", "<Cmd>ZkIndex<CR>", { desc = "Index notes" })

  if has_wk then
    wk.add({ { "<leader>z", group = "zk", mode = "n", desc = "Zettelkasten" } })
  end
end
