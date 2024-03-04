return {
  "Shatur/neovim-session-manager",
  config = function()
    local config = require("session_manager.config")
    require("session_manager").setup({
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
          session_manager.delete_current_session()
          session_manager.save_current_session()
        end
      end,
    })
  end,
}
