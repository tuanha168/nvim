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
    -- enabled = false,
    config = function()
      -- # Sign
      vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟧", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "🟩", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "🈁", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "⬜", texthl = "", linehl = "", numhl = "" })
      require("dap.ext.vscode").load_launchjs(nil, {
        ["python"] = {
          "python",
        },
        ["pwa-node"] = {
          "javascript",
          "typescript",
        },
        ["node"] = {
          "javascript",
          "typescript",
        },
      })
    end,
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          enabled = true,
          enabled_commands = true,
          highlight_changed_variables = true,
          highlight_new_as_changed = false,
          show_stop_reason = true,
          commented = false,
          only_first_definition = true,
          all_references = false,
          filter_references_pattern = "<module",
          virt_text_pos = "eol",
          all_frames = false,
          virt_lines = false,
          virt_text_win_col = nil,
        },
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup {
            adapters = { "pwa-node", "pwa-chrome" },
            debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
          }
          local js_dap = require "user.dap.handlers.js"
          for _, language in ipairs(js_dap.filetypes) do
            require("dap").configurations[language] = js_dap.configurations
          end
          Chiruno.func.print(require("dap").adapters)
        end,
        dependencies = {
          {
            "microsoft/vscode-js-debug",
            version = "1.x",
            build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
          },
        },
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        enabled = false,
        opts = function(_, opts)
          opts.ensure_installed = { "js" }
          -- opts.handlers = require("user.dap").handlers(opts.ensure_installed)
        end,
      },
    },
  },
}
