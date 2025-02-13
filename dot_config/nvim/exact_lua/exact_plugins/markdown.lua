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
    ft = { "markdown", "quarto" },
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
          path = os.getenv("PREFIX") == nil and "~/Documents/notes"
            or "/storage/emulated/0/Documents/notes",
        },
        {
          name = "no-vault",
          path = function()
            return assert(vim.fn.getcwd())
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
      attachments = {
        img_folder = "attachments",
        img_name_func = function()
          return string.format("%s-", os.time())
        end,
      },
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
