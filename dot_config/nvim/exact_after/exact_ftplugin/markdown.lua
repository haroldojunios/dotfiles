local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true, buffer = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.colorcolumn = "81"

local has_mini_surround, mini_surround = pcall(require, "mini.surround")
if has_mini_surround then
  vim.b.minisurround_config = {
    custom_surroundings = {
      -- bold
      b = {
        input = { "%*%*().-()%*%*" },
        output = { left = "**", right = "**" },
      },
      -- italic
      i = { input = { "%_().-()%_" }, output = { left = "_", right = "_" } },
      -- strikethrough
      s = {
        input = { "%~%~().-()%~%~" },
        output = { left = "~~", right = "~~" },
      },
      -- highlight
      h = {
        input = { "%=%=().-()%=%=" },
        output = { left = "==", right = "==" },
      },
      -- code
      c = { input = { "%`().-()%`" }, output = { left = "`", right = "`" } },
      C = {
        input = { "%`%`%`().-()%`%`%`" },
        output = { left = "```\n", right = "\n```" },
      },
      -- link
      l = {
        input = { "%[().-()%]%(.-%)" },
        output = function()
          local link = mini_surround.user_input("Link: ")
          return { left = "[", right = "](" .. link .. ")" }
        end,
      },
    },
  }

  map("n", "<M-b>", "saiwb", { desc = "Surround with bold" })
  map("v", "<M-b>", "sab", { desc = "Surround with bold" })
  map("i", "<M-b>", "<Esc>lsaiwbgi", { desc = "Surround with bold" })
  map("n", "<M-i>", "saiwi", { desc = "Surround with italic" })
  map("v", "<M-i>", "sai", { desc = "Surround with italic" })
  map("i", "<M-i>", "<Esc>lsaiwigi", { desc = "Surround with italic" })
end

-- use latex symbol on markdown
local has_cmp, cmp = pcall(require, "cmp")
if has_cmp then
  local sources = cmp.get_config().sources
  for i = #sources, 1, -1 do
    if sources[i].name == "latex_symbols" then
      sources[i].option = {
        strategy = 2, -- latex
      }
    end
  end
  cmp.setup.buffer({ sources = sources })
end

-- render markdown on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  buffer = 0,
  callback = function()
    if vim.fn.executable("pandoc") == 1 then
      local cur_cwd = vim.fn.getcwd()

      if cur_cwd:match("Documents/notes") then
        local filename = vim.fn.expand("%:p")
        local path, _ = filename:match("^(.+)%.(.+)$")
        local folder, _ = filename:match("^(.+)/(.+)$")
        local output = path .. ".html"

        vim.fn.jobstart(
          { "pandoc", filename, "-d", "notes-html", "-o", output },
          { cdw = folder }
        )
      end
    end
  end,
})

local has_zk, _ = pcall(require, "zk")
if has_zk then
  if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
    -- open the link at the cursor
    map(
      "n",
      "<CR>",
      "<Cmd>lua vim.lsp.buf.definition()<CR>",
      { desc = "Open link" }
    )
    -- create the note in the same directory as the current buffer
    map(
      "n",
      "<leader>zn",
      "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
      { desc = "Create new note" }
    )
    -- Open notes linking to the current buffer.
    map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", { desc = "Open backlinks" })
    -- Open notes linked by the current buffer.
    map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", { desc = "Open links" })
    -- Open the code actions for a visual selection.
    map(
      "v",
      "<leader>za",
      ":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
      { desc = "Open code actions" }
    )
  end
end
