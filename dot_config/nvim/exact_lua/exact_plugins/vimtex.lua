return {
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      local au_group = vim.api.nvim_create_augroup("vimtex_events", {})

      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = au_group,
        pattern = { "bib", "tex" },
        callback = function()
          vim.wo.conceallevel = 2
        end,
      })

      -- Cleanup on quit
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventQuit",
        group = au_group,
        command = "VimtexClean",
      })

      -- Focus the terminal after inverse search
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventViewReverse",
        group = au_group,
        command = "call b:vimtex.viewer.xdo_focus_vim()",
      })

      -- Cleanup on quit
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventQuit",
        group = au_group,
        command = "VimtexClean",
      })

      -- Sync pdf with tex
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventCompileSuccess",
        group = au_group,
        command = "VimtexView",
      })

      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_mappings_enabled = 1
      vim.g.vimtex_indent_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_log_ignore = {
        "Underfull",
        "Overfull",
        "specifier changed to",
        "Token not allowed in a PDF string",
      }
      vim.g.vimtex_view_method = "zathura_simple"
      -- vim.g.latex_view_general_viewer = "zathura"
      -- vim.g.tex_flavor = "latex"
      -- vim.g.vimtex_compiler_progname = "nvr"
    end,
  },
}
