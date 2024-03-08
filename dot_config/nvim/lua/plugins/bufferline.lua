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
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
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

    vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
    vim.keymap.set(
      "n",
      "<S-Tab>",
      ":BufferLineCyclePrev<CR>",
      { silent = true }
    )

    vim.keymap.set(
      "n",
      "<leader>1",
      ":BufferLineGoToBuffer 1<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>2",
      ":BufferLineGoToBuffer 2<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>3",
      ":BufferLineGoToBuffer 3<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>4",
      ":BufferLineGoToBuffer 4<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>5",
      ":BufferLineGoToBuffer 5<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>6",
      ":BufferLineGoToBuffer 6<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>7",
      ":BufferLineGoToBuffer 7<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>8",
      ":BufferLineGoToBuffer 8<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>9",
      ":BufferLineGoToBuffer 9<CR>",
      { silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>0",
      ":BufferLineGoToBuffer -1<CR>",
      { silent = true }
    )
  end,
}
