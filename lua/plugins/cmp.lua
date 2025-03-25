---@type LazySpec
return {
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function( --[[ plugin, opts ]])
  --     -- require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     require("luasnip.loaders.from_vscode").lazy_load { paths = { "./" } } -- load snippets paths
  --   end,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     -- "SergioRibera/cmp-dotenv",
  --     { "hrsh7th/cmp-buffer", config = function() require "config.cmp.cmdbuffer" end },
  --     {
  --       "hrsh7th/cmp-cmdline",
  --       dependencies = {
  --         "hrsh7th/cmp-path",
  --       },
  --       config = function() require "config.cmp.cmdline" end,
  --     },
  --   },
  --   config = function()
  --     local cmp_ok, cmp = pcall(require, "cmp")
  --     if not cmp_ok then return end

  --     local snip_status_ok, luasnip = pcall(require, "luasnip")

  --     local opts = {
  --       formatting = {
  --         format = function(entry, vim_item)
  --           vim_item.menu = ({
  --             nvim_lsp = "[LSP]",
  --             luasnip = "[Snippet]",
  --             buffer = "[Buffer]",
  --             path = "[Path]",
  --           })[entry.source.name]

  --           vim_item.dup = ({
  --             nvim_lsp = 0,
  --             luasnip = 0,
  --             buffer = 0,
  --             path = 0,
  --           })[entry.source.name] or 0

  --           return vim_item
  --         end,
  --       },
  --       snippet = {
  --         expand = function(args)
  --           vim.snippet.expand(args.body)   -- For native neovim snippets (Neovim v0.10+)
  --           if snip_status_ok then
  --             luasnip.lsp_expand(args.body) -- For `luasnip` users.
  --           end
  --         end,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<CR>"] = cmp.mapping.confirm { select = false },
  --         -- ["<CR>"] = cmp.mapping(function(fallback)
  --         --   if cmp.visible() then
  --         --     local entry = cmp.get_selected_entry()
  --         --     if not entry then
  --         --       cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
  --         --       cmp.confirm()
  --         --     else
  --         --       cmp.confirm()
  --         --     end
  --         --   else
  --         --     fallback()
  --         --   end
  --         -- end, { "i", "s" }),
  --         ["<C-K>"] = cmp.mapping(function(fallback)
  --           cmp.mapping.close()
  --           fallback()
  --         end),
  --         ["<C-J>"] = cmp.mapping(function(fallback)
  --           cmp.mapping.close()
  --           fallback()
  --         end),
  --         ["<Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           elseif snip_status_ok and luasnip.expand_or_jumpable() then
  --             luasnip.expand_or_jump()
  --           elseif vim.fn.has "nvim-0.10" == 1 and vim.snippet.active { direction = 1 } then
  --             vim.snippet.jump(1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           elseif snip_status_ok and luasnip.jumpable(-1) then
  --             luasnip.jump(-1)
  --           elseif vim.snippet.active { direction = -1 } then
  --             vim.snippet.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<ESC>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.close()
  --             Chiruno.autocmd.get_auto_reload_cmp_timer():stop()
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --       }),
  --       sources = cmp.config.sources {
  --         { name = "nvim_lsp", priority = 1000 },
  --         -- { name = "codeium", priority = 850 },
  --         -- { name = "cmp_tabnine", priority = 850 },
  --         -- { name = "neorg", priority = 750 },
  --         { name = "luasnip",  priority = 750 },
  --         -- { name = "dotenv", priority = 750 },
  --         { name = "buffer",   priority = 500, keyword_length = 3 },
  --         { name = "path",     priority = 250 },
  --       },
  --     }

  --     opts.mapping["<Down>"] = opts.mapping["<Tab>"]
  --     opts.mapping["<Up>"] = opts.mapping["<S-Tab>"]

  --     cmp.setup(opts)
  --   end,
  -- },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "v0.*", -- REQUIRED `tag` needed to download pre-built binary

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- highlight = {
      --   -- supporting themes: tokyonight
      --   -- not supported: nightfox
      --   use_nvim_cmp_as_default = true,
      -- },
      sources = {
        -- completion = {
        --   enabled_providers = { "lsp", "path", "snippets", "buffer" },
        -- },
        providers = {
          snippets = {
            min_keyword_length = 1, -- don't show when triggered manually, useful for JSON keys
            score_offset = -1,
          },
          path = {
            opts = { get_cwd = vim.fn.getcwd },
          },
          buffer = {
            max_items = 4,
            min_keyword_length = 4,
            score_offset = -3,
          },
        },
      },
      keymap = {
        ["<D-c>"] = { "show" },
        ["<S-CR>"] = { "hide" },
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<PageDown>"] = { "scroll_documentation_down" },
        ["<PageUp>"] = { "scroll_documentation_up" },
      },
      -- windows = {
      --   documentation = {
      --     border = vim.g.borderStyle,
      --     min_width = 15,
      --     max_width = 45, -- smaller, due to https://github.com/Saghen/blink.cmp/issues/194
      --     max_height = 10,
      --     auto_show = true,
      --     auto_show_delay_ms = 250,
      --   },
      --   autocomplete = {
      --     border = vim.g.borderStyle,
      --     min_width = 10,               -- max_width controlled by draw-function
      --     max_height = 10,
      --     cycle = { from_top = false }, -- cycle at bottom, but not at the top
      --     draw = function(ctx)
      --       -- https://github.com/Saghen/blink.cmp/blob/9846c2d2bfdeaa3088c9c0143030524402fffdf9/lua/blink/cmp/types.lua#L1-L6
      --       -- https://github.com/Saghen/blink.cmp/blob/9846c2d2bfdeaa3088c9c0143030524402fffdf9/lua/blink/cmp/windows/autocomplete.lua#L298-L349
      --       -- differentiate LSP snippets from user snippets and emmet snippets
      --       local source, client = ctx.item.source_id, ctx.item.client_id
      --       if
      --           client and vim.lsp.get_client_by_id(client).name == "emmet_language_server"
      --       then
      --         source = "emmet"
      --       end

      --       local sourceIcons = { snippets = "󰩫", buffer = "󰦨", emmet = "" }
      --       local icon = sourceIcons[source] or ctx.kind_icon

      --       return {
      --         {
      --           " " .. ctx.item.label .. " ",
      --           fill = true,
      --           hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
      --           max_width = 40,
      --         },
      --         { icon .. " ", hl_group = "BlinkCmpKind" .. ctx.kind },
      --       }
      --     end,
      --   },
      -- },
      -- kind_icons = {
      --   Text = "",
      --   Method = "󰊕",
      --   Function = "󰊕",
      --   Constructor = "",
      --   Field = "󰇽",
      --   Variable = "󰂡",
      --   Class = "󰜁",
      --   Interface = "",
      --   Module = "",
      --   Property = "󰜢",
      --   Unit = "",
      --   Value = "󰎠",
      --   Enum = "",
      --   Keyword = "󰌋",
      --   Snippet = "󰒕",
      --   Color = "󰏘",
      --   Reference = "",
      --   File = "",
      --   Folder = "󰉋",
      --   EnumMember = "",
      --   Constant = "󰏿",
      --   Struct = "",
      --   Event = "",
      --   Operator = "󰆕",
      --   TypeParameter = "󰅲",
      -- },
    },
  },
}
