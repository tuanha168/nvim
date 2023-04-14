-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua_ls",

        -- web dev
        "tsserver",
        -- "angular-language-server",
        -- "vetur-vls",
        "volar",
        "cssls",
        "html",
        -- "emmet_ls",
        "jsonls",

        -- lint
        "eslint",

        -- php
        "intelephense",

        -- python
        "pyright",
        -- "python-lsp-server",
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "prettier",
        "stylua",
        -- "eslint_d",
        "pint",
      },
      handlers = {
        pint = function()
          local null_ls = require "null-ls"
          null_ls.register(null_ls.builtins.formatting.pint.with {
            command = "pint",
            args = { "--preset", "psr12", "--no-interaction", "--quiet", "$FILENAME" },
          })
        end,
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    -- enabled = false,
    opts = {
      ensure_installed = { "node2" },
      automatic_setup = true,
      handlers = {
        node2 = function()
          local dap = require "dap"
          dap.set_log_level "TRACE"
          dap.configurations.typescript = {
            {
              type = "node2",
              request = "attach",
              name = "Attach Program (Node2 with ts-node)",
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
              skipFiles = { "<node_internals>/**" },
              port = 9229,
            },
            {
              type = "node2",
              name = "Debug NestJS",
              request = "launch",
              runtimeExecutable = "${workspaceFolder}/node_modules/.bin/nest",
              args = { "start", "--watch", "--debug" },
              outputCapture = "std",
              port = 9229,
              console = "integratedTerminal",
              internalConsoleOptions = "neverOpen",
            },
          }
        end,
      },
    },
  },
}
