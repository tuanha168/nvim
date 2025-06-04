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
        cmd = "Mason",
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
        lua_ls = require "lsp.config.lua_ls",
        vue_ls = require "lsp.config.volar",
        eslint = require "lsp.config.eslint",
        tailwindcss = require "lsp.config.tailwindcss",
        jsonls = {},
        intelephense = require "lsp.config.intelephense",
        yamlls = {},
        -- omnisharp = require "lsp.config.omnisharp",
        cssls = require "lsp.config.cssls",
        html = require "lsp.config.html",
        -- ts_ls = require "lsp.config.ts_ls",
        vtsls = require "lsp.config.vtsls",
        stylelint_lsp = require "lsp.config.stylelint_lsp",

        ---@reference lua/plugins/rustaceanvim.lua
        -- rust_analyzer = require "lsp.config.rust_analyzer",
      }

      require("mason-lspconfig").setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = {
          exclude = {},
        },
        automatic_installation = true,
        handlers = {
          rust_analyzer = function() end,
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
              textDocument = {
                foldingRange = {
                  dynamicRegistration = false,
                  lineFoldingOnly = true,
                },
              },
            }, capabilities, server.capabilities or {})
            server.on_attach = require "lsp.on_attach"
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

  -- C#
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:Crashdummyy/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    opts = function()
      return {
        config = {
          settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,
              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
            },
          },
        },
      }
    end,
  },
}
