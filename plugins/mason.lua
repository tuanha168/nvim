-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    -- dependencies = {
    --   "creativenull/efmls-configs-nvim",
    -- },
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua_ls",

        -- "tsserver",
        -- "angular-language-server",
        -- "vetur-vls",
        "volar",
        -- "cssls",
        -- "stylelint_lsp",
        "tailwindcss",
        -- "html",
        -- "emmet_ls",
        "jsonls",

        -- lint
        "eslint",

        -- php
        "intelephense",
        -- "phpactor",

        -- python
        "pyright",
        "python-lsp-server",

        "rust_analyzer",

        "yamlls",

        -- "efm",

        "terraformls",
        "tflint",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   enabled = false,
  -- },
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    -- enabled = false,
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "pint",
        "tfsec",
      },
      handlers = {
        pint = function()
          local null_ls = require "null-ls"
          null_ls.register(null_ls.builtins.formatting.pint)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    enabled = false,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    enabled = false,
    opts = function(_, opts)
      opts.ensure_installed = { "node2" }
      opts.handlers = require("user.dap").handlers(opts.ensure_installed)
    end,
  },
}
