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
          dap.adapters.node2 = {
            type = "executable",
            command = "yarn",
            args = {
              "start:debug",
            },
          }

          dap.configurations.typescript = {
            {
              name = "Node2: Launch",
              type = "node2",
              request = "launch",
              program = "${file}",
              cwd = vim.fn.getcwd(),
              sourceMaps = true,
              protocol = "inspector",
              console = "integratedTerminal",
            },
            {
              -- For this to work you need to make sure the node process is started with the `--inspect` flag.
              name = "Node2: Attach to process",
              type = "node2",
              request = "attach",
              processId = require("dap.utils").pick_process,
            },
          }
        end,
      },
    },
  },
}
