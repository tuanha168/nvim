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
        "html",
        -- "emmet_ls",
        "jsonls",

        -- lint
        "eslint",

        -- php
        "intelephense",
        -- "phpactor",

        -- python
        -- "pyright",
        "pylsp",

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
        -- "pint",
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
    dependencies = {
      {
        "mxsdev/nvim-dap-vscode-js",
        -- enabled = false,
        lazy = false,
        config = function()
          require("dap-vscode-js").setup {
            adapters = { "pwa-node", "pwa-chrome" },
            debugger_path = "",
            debugger_cmd = { "js-debug-adapter" },
          }
          local js_dap = require "user.dap.handlers.js"
          for _, language in ipairs(js_dap.filetypes) do
            require("dap").configurations[language] = js_dap.configurations
          end
        end,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        -- overrides `require("mason-nvim-dap").setup(...)`
        opts = function(_, opts)
          opts.ensure_installed = { "js" }
          -- opts.handlers = require("user.dap").handlers(opts.ensure_installed)
        end,
      },
    },
  },
}
