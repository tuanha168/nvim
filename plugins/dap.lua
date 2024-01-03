return {
  {
    "mfussenegger/nvim-dap",
    -- enabled = false,
    config = function()
      require("dap.ext.vscode").load_launchjs(nil, {
        ["python"] = {
          "python",
        },
        ["pwa-node"] = {
          "javascript",
          "typescript",
        },
        ["pwa-chrome"] = {
          "javascript",
          "typescript",
        },
        ["node"] = {
          "javascript",
          "typescript",
        },
        ["chrome"] = {
          "javascript",
          "typescript",
        },
      })
      require("user.dap.adapters").setup()
      require("user.dap.configurations").setup()
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
      -- {
      --   "mxsdev/nvim-dap-vscode-js",
      --   config = function()
      --     ---@diagnostic disable-next-line: missing-fields
      --     require("dap-vscode-js").setup {
      --       adapters = { "pwa-node", "pwa-chrome" },
      --       debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
      --     }
      --     local js_dap = require "user.dap.handlers.js"
      --     for _, language in ipairs(js_dap.filetypes) do
      --       require("dap").configurations[language] = js_dap.configurations
      --     end
      --   end,
      --   dependencies = {
      --     {
      --       "microsoft/vscode-js-debug",
      --       version = "1.x",
      --       build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
      --     },
      --   },
      -- },
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
          opts.ensure_installed = { "js" }
          -- opts.handlers = require("user.dap").handlers(opts.ensure_installed)
          return opts
        end,
      },
    },
  },
}
