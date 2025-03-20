---@type LazySpec

return {
  {
    "L3MON4D3/LuaSnip",
    config = function(--[[ plugin, opts ]])
      -- require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./" } } -- load snippets paths
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "SergioRibera/cmp-dotenv",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
    	{"hrsh7th/cmp-cmdline",
    config = function() require "config.cmdline" end,
    },
    },
    config = function()
    	local opts = {
    	mapping = {}}

      opts.sources = {
        { name = "nvim_lsp", priority = 1000 },
        -- { name = "codeium", priority = 850 },
        -- { name = "cmp_tabnine", priority = 850 },
        -- { name = "neorg", priority = 750 },
        -- { name = "luasnip", priority = 750 },
        { name = "dotenv", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
      }

      local cmp_ok, cmp = pcall(require, "cmp")
      if not cmp_ok then return end

      opts.mapping["<CR>"] = cmp.mapping(function(fallback)
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

      opts.mapping["<C-K>"] = cmp.mapping(function(fallback)
        cmp.abort()
        fallback()
      end)
      opts.mapping["<C-J>"] = cmp.mapping(function(fallback)
        cmp.abort()
        fallback()
      end)

      local snip_status_ok, luasnip = pcall(require, "luasnip")

      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif snip_status_ok and luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif vim.fn.has "nvim-0.10" == 1 and vim.snippet.active { direction = 1 } then
          vim.snippet.jump(1)
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif snip_status_ok and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        elseif vim.snippet.active { direction = -1 } then
          vim.snippet.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<Down>"] = opts.mapping["<Tab>"]
      opts.mapping["<Up>"] = opts.mapping["<S-Tab>"]

      opts.mapping["<ESC>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.close()
          Chiruno.autocmd.get_auto_reload_cmp_timer():stop()
        else
          fallback()
        end
      end, { "i", "s" })

      cmp.setup(opts)
    end,
  },
}
