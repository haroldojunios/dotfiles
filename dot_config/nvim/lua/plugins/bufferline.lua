return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local groups = require("bufferline.groups")

    require("bufferline").setup({
      options = {
        separator_style = "slant",
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(
          count,
          level,
          diagnostics_dict,
          context
        )
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" }),
            groups.builtin.ungrouped, -- other items
          },
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Directory",
            separator = true,
          },
        },
      },
    })
  end,
}
