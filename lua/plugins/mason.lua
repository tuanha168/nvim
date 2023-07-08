-- customize mason plugins
return {
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      for _, plugin in ipairs {
        "mason-lspconfig",
        "mason-null-ls",
        -- "mason-nvim-dap",
      } do
        pcall(require, plugin)
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua_ls",

        -- web dev
        -- "tsserver",
        -- "angular-language-server",
        -- "vetur-vls",
        "volar",
        "cssls",
        -- "stylelint_lsp",
        "tailwindcss",
        "html",
        -- "emmet_ls",
        "jsonls",

        -- lint
        -- "eslint",

        -- php
        "intelephense",

        -- python
        -- "pyright",
        -- "python-lsp-server",

        "rust_analyzer",
      },
      automatic_installation = true,
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "stylua",
        "eslint_lsp",
        "pint",
      },
      automatic_installation = true,
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
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   -- overrides `require("mason-nvim-dap").setup(...)`
  --   enabled = false,
  --   opts = function(_, opts)
  --     opts.ensure_installed = { "node2" }
  --     opts.handlers = require("user.dap").handlers(opts.ensure_installed)
  --   end,
  -- },
}
