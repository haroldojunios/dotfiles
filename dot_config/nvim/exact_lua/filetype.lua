vim.g.do_filetype_lua = 1

vim.filetype.add({
  filename = {
    ["fish_variables"] = "fish",
  },
  pattern = {
    [".*%.sh%.tmpl"] = "bash",
    [".*%.fish%.tmpl"] = "fish",
    [".*%.py%.tmpl"] = "python",
    [".*%.toml%.tmpl"] = "toml",
    [".*%.yaml%.tmpl"] = "yaml",
    [".*%.ps1%.tmpl"] = "ps1",
    [".*bashrc%.tmpl"] = "bash",
    [".*gitconfig%.tmpl"] = "gitconfig",
    [".*aliases%.tmpl"] = "sh",
    [".*profile"] = "sh",
    [".*%.json"] = "jsonc",
    ["conky%.conf.*"] = "lua",
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".*"] = function(_, bufnr) -- function(path, bufnr, ext)
      if
        vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]:match("#!/bin/bash")
      then
        return "bash"
      end
    end,
  },
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function(ev)
--     print(string.format("event fired: %s", vim.inspect(ev)))
--
--     vim.opt_local.shiftwidth = 2
--     vim.opt_local.tabstop = 2
--     vim.opt_local.colorcolumn = 81
--
--     vim.b.minisurround_config = {
--       custom_surroundings = {
--         h = {
--           input = { "%=%=().-()%=%=" },
--           output = { left = "==", right = "==" },
--         },
--       },
--     }
--   end,
-- })
