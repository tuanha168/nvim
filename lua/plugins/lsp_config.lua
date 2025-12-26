local servers = {
  lua_ls = true,
  vue_ls = true,
  eslint = true,
  tailwindcss = true,
  jsonls = true,
  intelephense = true,
  yamlls = true,
  -- omnisharp = false,
  -- cssls = false,
  -- html = false,
  tsgo = true,

  vtsls = true,
  pyright = true,

  -- stylelint_lsp = false,

  ---@reference lua/plugins/rustaceanvim.lua
  -- rust_analyzer = false,
  qmlls = true,

  copilot = true,
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = vim.tbl_keys(servers),
          automatic_enable = vim.tbl_filter(function(server) return servers[server] end, vim.tbl_keys(servers)),
        },
      },
    },
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
      local test = "ok"
      Print(test)
      local test2 = "not ok"
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
