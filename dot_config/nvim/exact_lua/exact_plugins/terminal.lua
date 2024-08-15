return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float",
    open_mapping = [[<C-'>]],
    auto_scroll = false,
    float_opts = {
      border = "curved",
    },
    on_open = function(t)
      vim.wo[t.window].cc = ""
      if package.loaded["virt-column"] then
        require("virt-column").setup_buffer({ virtcolumn = "" })
      end
    end,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Lazygit: https://github.com/kdheepak/lazygit.nvim/issues/106
    local term = nil

    local function lg_toggle()
      local Terminal = require("toggleterm.terminal").Terminal

      local size = 90
      local direction = "float"

      if not term then
        term = Terminal:new({
          cmd = "lazygit",
          hidden = true,
          on_exit = function()
            term = nil
          end,
        })
        if term then
          term:toggle(size, direction)

          vim.cmd("set ft=lazygit")
          vim.keymap.set("t", "<C-'>", function()
            term:toggle(size, direction)
          end, { buffer = true })
        end
      else
        term:toggle(size, direction)
      end
    end

    vim.api.nvim_create_user_command("LazyGitToggle", lg_toggle, {})
    vim.keymap.set("n", "<leader>gg", "<cmd>LazyGitToggle<cr>", {})
  end,
}
