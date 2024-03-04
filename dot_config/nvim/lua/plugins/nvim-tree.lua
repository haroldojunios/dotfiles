return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              folder_arrow = false,
            },
          },
        },
        filters = {
          custom = { "^.git$" },
        },
      })

      -- close if focused, open if closed, focus if not focused
      local nvimTreeFocusOrToggle = function()
        local nvimTree = require("nvim-tree.api")
        local currentBuf = vim.api.nvim_get_current_buf()
        local currentBufFt =
          vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
        if currentBufFt == "NvimTree" then
          nvimTree.tree.toggle()
        else
          nvimTree.tree.focus()
        end
      end

      vim.keymap.set("n", "<C-h>", nvimTreeFocusOrToggle)
    end,
  },
}
