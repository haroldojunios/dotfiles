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
        {
          name = "no-vault",
          path = function()
            -- alternatively use the CWD:
            -- return assert(vim.fn.getcwd())
            return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
          end,
          overrides = {
            notes_subdir = vim.NIL,
            new_notes_location = "current_dir",
            templates = {
              folder = vim.NIL,
            },
            disable_frontmatter = true,
          },
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      new_notes_location = "current_dir",
      preferred_link_style = "markdown",
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      note_frontmatter_func = function(note)
        local date_time = os.date("%Y-%m-%dT%T")
        local utc_offset = tostring(os.date("%z"))
        date_time = date_time
          .. string.sub(utc_offset, 1, -3)
          .. ":"
          .. string.sub(utc_offset, -2, -1)
        local title = note.metadata and note.metadata.title
          or note.title
          or note.path.stem
        local out =
          { id = note.id, title = title, ["date created"] = date_time }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
      note_id_func = function(title)
        if title ~= nil then
          return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          return tostring(os.time())
        end
      end,
      note_path_func = function(spec)
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
      end,
      follow_url_func = function(url)
        vim.ui.open(url)
      end,
      follow_img_func = function(img)
        vim.ui.open(img)
      end,
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      render_modes = { "n", "c", "t" },
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
    enabled = os.getenv("PREFIX") == nil,
    opts = {
      processor = "magick_cli",
    },
  },
  {
    "Thiago4532/mdmath.nvim",
    ft = "markdown",
    enabled = os.getenv("PREFIX") == nil,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "jannis-baum/vivify.vim",
    ft = "markdown",
    enabled = os.getenv("PREFIX") == nil,
  },
}
