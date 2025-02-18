return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_markdown_css =
        vim.fn.expand("~/.local/share/markdown/mkdp/markdown.css")
      vim.g.mkdp_highlight_css =
        vim.fn.expand("~/.local/share/markdown/mkdp/highlight.css")
      vim.g.mkdp_browser = "qutebrowser"
    end,
    ft = { "markdown" },
  },
  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        picker = "telescope",
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      render_modes = { "n", "c", "t" },
      file_types = { "markdown", "quarto" },
      pipe_table = { preset = "round", cell = "trimmed" },
      bullet = {
        icons = { "●", "◼", "⧫", "○", "◻", "◊" },
      },
      link = {
        image = "󰋵 ",
        email = " ",
        hyperlink = "󰌷 ",
        custom = {
          python = { pattern = "%.py$", icon = "󰌠 " },
        },
      },
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
        min_width = 80,
      },
      dash = { width = 80 },
      quote = { repeat_linebreak = true },
      latex = { enabled = false },
      win_options = {
        conceallevel = {
          default = vim.api.nvim_get_option_value("conceallevel", {}),
          rendered = 2,
        },
        showbreak = { default = "", rendered = "  " },
        breakindent = { default = false, rendered = true },
        breakindentopt = { default = "", rendered = "" },
      },
    },
  },
  {
    "3rd/image.nvim",
    build = false,
    ft = { "markdown", "quarto" },
    enabled = os.getenv("PREFIX") == nil,
    opts = {
      processor = "magick_cli",
      integrations = {
        markdown = {
          filetypes = { "markdown", "quarto", "vimwiki" },
          only_render_image_at_cursor = true,
        },
      },
      max_width = 50,
      window_overlap_clear_enabled = true,
    },
  },
  {
    "Thiago4532/mdmath.nvim",
    ft = { "markdown", "quarto" },
    enabled = os.getenv("PREFIX") == nil,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      filetypes = { "markdown", "quarto" },
    },
  },
  {
    "jannis-baum/vivify.vim",
    ft = { "markdown", "quarto" },
    enabled = os.getenv("PREFIX") == nil,
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
