local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, {})
end

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = augroup("auto_cursorline_show"),
  callback = function(event)
    if vim.bo[event.buf].buftype == "" then
      vim.opt_local.cursorline = true
    end
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = augroup("auto_cursorline_hide"),
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- create directories when needed, when saving a file (except for URIs "://").
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- ensure that the binary spl file is up-to-date with the source add file
vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
  group = augroup("update_spell"),
  callback = function()
    local config_path = vim.fn.stdpath("config") -- Get Neovim's config path
    for _, lang in pairs({ "en", "pt" }) do
      local add_file = config_path .. "/spell/" .. lang .. ".utf-8.add"
      local spl_file = config_path .. "/spell/" .. lang .. ".utf-8.add.spl"

      if vim.fn.filereadable(add_file) == 1 then
        local add_mtime = vim.fn.getftime(add_file) -- Get modification time of .add file
        local spl_mtime = vim.fn.getftime(spl_file) -- Get modification time of .add.spl file

        -- Run mkspell! only if .add is newer than .add.spl or .add.spl doesn't exist
        if add_mtime > spl_mtime or spl_mtime == -1 then
          vim.cmd("silent! runtime spell/cleanadd.vim")
          vim.cmd("silent! mkspell! " .. spl_file .. " " .. add_file)
        end
      end
    end
  end,
})
