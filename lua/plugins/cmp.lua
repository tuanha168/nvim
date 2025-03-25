---@type LazySpec
return {
  {
    "L3MON4D3/LuaSnip",
    config = function( --[[ plugin, opts ]])
      -- require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./" } } -- load snippets paths
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- "SergioRibera/cmp-dotenv",
      { "hrsh7th/cmp-buffer", config = function() require "config.cmp.cmdbuffer" end },
      {
        "hrsh7th/cmp-cmdline",
        dependencies = {
          "hrsh7th/cmp-path",
        },
        config = function() require "config.cmp.cmdline" end,
      },
    },
    config = function()
      local cmp_ok, cmp = pcall(require, "cmp")
      if not cmp_ok then return end

      local snip_status_ok, luasnip = pcall(require, "luasnip")

      local opts = {
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]

            vim_item.dup = ({
              nvim_lsp = 0,
              luasnip = 0,
              buffer = 0,
              path = 0,
            })[entry.source.name] or 0

            return vim_item
          end,
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)   -- For native neovim snippets (Neovim v0.10+)
            if snip_status_ok then
              luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm { select = false },
          -- ["<CR>"] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     local entry = cmp.get_selected_entry()
          --     if not entry then
          --       cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          --       cmp.confirm()
          --     else
          --       cmp.confirm()
          --     end
          --   else
          --     fallback()
          --   end
          -- end, { "i", "s" }),
          ["<C-K>"] = cmp.mapping(function(fallback)
            cmp.mapping.close()
            fallback()
          end),
          ["<C-J>"] = cmp.mapping(function(fallback)
            cmp.mapping.close()
            fallback()
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif snip_status_ok and luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif vim.fn.has "nvim-0.10" == 1 and vim.snippet.active { direction = 1 } then
              vim.snippet.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif snip_status_ok and luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif vim.snippet.active { direction = -1 } then
              vim.snippet.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<ESC>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.close()
              Chiruno.autocmd.get_auto_reload_cmp_timer():stop()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources {
          { name = "nvim_lsp", priority = 1000 },
          -- { name = "codeium", priority = 850 },
          -- { name = "cmp_tabnine", priority = 850 },
          -- { name = "neorg", priority = 750 },
          { name = "luasnip",  priority = 750 },
          -- { name = "dotenv", priority = 750 },
          { name = "buffer",   priority = 500, keyword_length = 3 },
          { name = "path",     priority = 250 },
        },
      }

      opts.mapping["<Down>"] = opts.mapping["<Tab>"]
      opts.mapping["<Up>"] = opts.mapping["<S-Tab>"]

      cmp.setup(opts)
    end,
  },
}
