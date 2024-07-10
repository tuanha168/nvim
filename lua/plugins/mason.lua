-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "folke/neoconf.nvim" },
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        -- lua stuff
        "lua_ls",

        "tsserver",
        -- "angular-language-server",
        -- "vuels",
        "volar",
        "cssls",
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

        "gopls",

        -- C# .NET
        "omnisharp",
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "prettierd",
        "stylua",
        "pint",
        "tfsec",
      })
      opts.handlers.prettierd = function()
        local h = require "null-ls.helpers"
        require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
          condition = function()
            vim.defer_fn(function()
              Print(vim.lsp.get_clients())
              Print "test"
              return true
            end, 1000)
          end,
          runtime_condition = h.cache.by_bufnr(function(params)
            Print(params)
            Print(vim.lsp.get_clients())
            return false
          end),
        })
      end
    end,
  },
}
