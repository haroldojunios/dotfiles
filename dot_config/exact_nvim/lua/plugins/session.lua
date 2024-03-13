return {
  "Shatur/neovim-session-manager",
  config = function()
    local config = require("session_manager.config")
    local session_manager = require("session_manager")
    session_manager.setup({
      autoload_mode = config.AutoloadMode.CurrentDir,
    })

    local config_group = vim.api.nvim_create_augroup("SessionSaveGroup", {})

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = config_group,
      callback = function()
        if
          vim.bo.filetype ~= "git"
          and not vim.bo.filetype ~= "gitcommit"
          and not vim.bo.filetype ~= "gitrebase"
        then
          session_manager.autosave_session()
        end
      end,
    })
  end,
}
