return {
  {
    "L3MON4D3/LuaSnip",
    config = function(--[[ plugin, opts ]])
      -- require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./lua/user" } } -- load snippets paths
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = function(_, opts)
      opts.sources = {
        { name = "cmp-nvim-lsp-signature-help", priority = 2000 },
        { name = "nvim_lsp", priority = 1000 },
        -- { name = "codeium", priority = 850 },
        -- { name = "cmp_tabnine", priority = 850 },
        -- { name = "neorg", priority = 750 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }

      local cmp = require "cmp"

      opts.mapping["<CR>"] = cmp.mapping(function(fallback)
        -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            cmp.confirm()
          else
            cmp.confirm()
          end
        else
          fallback()
        end
      end, { "i", "s" })
      opts.mapping["<C-k>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() }
      opts.mapping["<C-j>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() }

      local lspkind = require "lspkind"

      opts.formatting = {
        format = lspkind.cmp_format {
          mode = "symbol_text",
          before = function(entry, vim_item)
            if entry.source.name == "nvim_lsp" then vim_item.dup = 0 end
            return vim_item
          end,
          menu = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
          },
        },
      }

      return opts
    end,
  },
  { "hrsh7th/cmp-cmdline", event = "VeryLazy", config = function() require "user.config.cmdline" end },
}
