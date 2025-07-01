---@type LazySpec
return {
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

  --     local opts = {
  --       formatting = {
  --         format = function(entry, vim_item)
  --           vim_item.menu = ({
  --             nvim_lsp = "[LSP]",
  --             luasnip = "[Snippet]",
  --             buffer = "[Buffer]",
  --             path = "[Path]",
  --           })[entry.source.name]

  --           -- vim_item.dup = ({
  --           --   nvim_lsp = 0,
  --           --   luasnip = 0,
  --           --   buffer = 0,
  --           --   path = 0,
  --           -- })[entry.source.name] or 0

  --           return vim_item
  --         end,
  --       },
  --       snippet = {
  --         expand = function(args)
  --           vim.snippet.expand(args.body)   -- For native neovim snippets (Neovim v0.10+)
  --         end,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  --         ["<CR>"] = cmp.mapping(cmp.mapping.confirm { select = false }, { "i", "c" }),
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
  --           elseif vim.snippet.active { direction = 1 } then
  --             vim.snippet.jump(1)
  --           else
  --             fallback()
  --           end
  --         end, { "i", "s" }),
  --         ["<S-Tab>"] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
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
    event = { "InsertEnter", "CmdlineEnter" },
    build = "cargo build --release", -- for delimiters
    -- version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "none",
        ["<C-space>"] = { function(cmp) cmp.show { providers = { "lsp", "snippets" } } end },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-y>"] = { "select_and_accept" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

        -- ["<Tab>"] = { "select_next", "fallback_to_mappings" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.accept() end

            return cmp.select_and_accept()
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },

        ["<CR>"] = { "accept", "fallback" },

        ["<C-j>"] = { "hide", "fallback" },
        ["<C-k>"] = { "hide", "fallback" },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        menu = {
          auto_show = true,
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = { auto_show = true },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        ghost_text = {
          enabled = false,
          hl_group = "Comment",
        },
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = true,
          },
          list = {
            selection = {
              preselect = false,
            },
          },
          ghost_text = { enabled = true },
        },
        keymap = {
          ["<CR>"] = { "accept_and_enter", "fallback" },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
      -- prebuilt_binaries = {
      --   download = true,
      -- },
    },
    opts_extend = { "sources.default" },
  },
}
