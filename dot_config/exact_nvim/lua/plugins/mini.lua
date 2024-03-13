return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup()
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup()
    end,
  },
}
