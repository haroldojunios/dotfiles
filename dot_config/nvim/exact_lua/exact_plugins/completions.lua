return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-path",
      "kdheepak/cmp-latex-symbols",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip", --luasnip
      "rafamadriz/friendly-snippets", --luasnip
      "windwp/nvim-autopairs",
      "f3fora/cmp-spell",
      "brenoprata10/nvim-highlight-colors",
      "jmbuhr/otter.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          -- ["<CR>"] = cmp.mapping.confirm({
          --   select = true,
          -- }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "codeium" },
          { name = "otter" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          {
            name = "spell",
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
              preselect_correct_word = true,
            },
          },
          { name = "calc" },
          {
            name = "latex_symbols",
            option = {
              strategy = 0, -- mixed
            },
          },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(entry, item)
            local color_item = require("nvim-highlight-colors").format(
              entry,
              { kind = item.kind }
            )
            item = require("lspkind").cmp_format({
              mode = "symbol",
              maxwidth = 50,
              ellipsis_char = "...",
              symbol_map = { Codeium = "", otter = "[🦦]" },
            })(entry, item)
            if color_item.abbr_hl_group then
              item.kind_hl_group = color_item.abbr_hl_group
              item.kind = color_item.abbr
            end
            return item
          end,
        },
      })

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "Exafunction/codeium.nvim",
    enabled = os.getenv("PREFIX") == nil,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        bin_path = vim.fn.stdpath("data") .. "/codeium/bin",
        config_path = vim.fn.stdpath("data") .. "/codeium/config.json",
      })
    end,
  },
}
