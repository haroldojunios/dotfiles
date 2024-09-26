return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "notes",
          path = "~/Documents/notes",
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {
      render_modes = { "n", "i", "c" },
      pipe_table = { preset = "round" },
      bullet = { left_pad = 2 },
      link = { image = "󰋵 ", email = " ", hyperlink = "󰌷 " },
      checkbox = {
        unchecked = { icon = "🗴 " },
        checked = { icon = "🗸 " },
        -- custom = { todo = { rendered = "◯ " } },
      },
      code = {
        width = "block",
        min_width = 45,
        left_pad = 2,
        language_pad = 2,
      },
      heading = {
        width = "block",
        min_width = 45,
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  -- {
  --   "vhyrro/luarocks.nvim",
  --   priority = 1001, -- this plugin needs to run before anything else
  --   enabled = os.getenv("PREFIX") == nil,
  --   opts = {
  --     rocks = { "magick" },
  --   },
  -- },
  -- {
  --   "3rd/image.nvim",
  --   dependencies = {
  --     "luarocks.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   enabled = os.getenv("PREFIX") == nil,
  --   config = function()
  --     -- ...
  --   end,
  -- },
}
