return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      inlay_hints = { enabled = true },
    },
    dependencies = {
      {
        "folke/neoconf.nvim",
        opts = {},
      },
      {
        "williamboman/mason.nvim",
        opts = {},
      },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local haveCmp, cmp = pcall(require, "cmp_nvim_lsp")
      local haveBlink, blink = pcall(require, "blink.cmp")

      if haveCmp then capabilities = vim.tbl_deep_extend("force", capabilities, cmp.default_capabilities()) end
      if haveBlink then capabilities = blink.get_lsp_capabilities(capabilities) end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
        volar = require "lsp.config.volar",
        eslint = require "lsp.config.eslint",
        tailwindcss = require "lsp.config.tailwindcss",
        jsonls = {},
        intelephense = require "lsp.config.intelephense",
        yamlls = {},
        omnisharp = require "lsp.config.omnisharp",
        cssls = require "lsp.config.cssls",
        html = require "lsp.config.html",
        ts_ls = require "lsp.config.ts_ls",
        stylelint_lsp = require "lsp.config.stylelint_lsp",
      }

      require("mason-lspconfig").setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            if server.enabled == false then return end
            server.capabilities = vim.tbl_deep_extend("force", {
              workspace = {
                workspaceFolders = true,
                didChangeWatchedFiles = {
                  dynamicRegistration = true,
                },
              },
            }, capabilities, server.capabilities or {})
            -- server.on_attach = require "lsp.on_attach"
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }

      vim.diagnostic.config {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        show_diagnostic_autocmds = { "InsertLeave", "TextChanged" },
      }

      vim.lsp.inlay_hint.enable(true)
    end,
  },

  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   dependencies = {
  --     "williamboman/mason-lspconfig.nvim",
  --   },
  --   opts = {
  --     ensure_installed = {
  --       "prettierd",
  --       "stylua",
  --       -- "pint",
  --       "tfsec",
  --     }
  --   }
  -- },
}
