vim.pack.add { { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } }

vim.api.nvim_create_autocmd({ "InsertEnter", "CmdlineEnter" }, {
  callback = function()
    local cmp = require "blink.cmp"
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    local opts = {
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

        ["<Up>"] = { "select_prev" },
        ["<Down>"] = { "select_next" },
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
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        prebuilt_binaries = {
          download = true,
        },
      },
    }
    cmp.setup(opts)
  end,
  once = true,
})
