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

  vim.keymap.set(
    "n",
    "<M-b>",
    "saiwb",
    { remap = true, desc = "Surround with bold" }
  )
  vim.keymap.set(
    "v",
    "<M-b>",
    "sab",
    { remap = true, desc = "Surround with bold" }
  )
  vim.keymap.set(
    "i",
    "<M-b>",
    "<Esc>lsaiwbgi",
    { remap = true, desc = "Surround with bold" }
  )
  vim.keymap.set(
    "n",
    "<M-i>",
    "saiwi",
    { remap = true, desc = "Surround with italic" }
  )
  vim.keymap.set(
    "v",
    "<M-i>",
    "sai",
    { remap = true, desc = "Surround with italic" }
  )
  vim.keymap.set(
    "i",
    "<M-i>",
    "<Esc>lsaiwigi",
    { remap = true, desc = "Surround with italic" }
  )
end
