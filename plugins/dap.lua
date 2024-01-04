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
      local dap = require "dap"
      require("user.dap.adapters").setup(dap)
      require("user.dap.config").setup(dap)
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
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
          opts.ensure_installed = { "js" }
          return opts
        end,
      },
      {
        "rcarriga/nvim-dap-ui",
        opts = function(_, opts)
          local dap, dapui = require "dap", require "dapui"
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
            vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.DapUi, modeline = false })
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
            vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.DapUi, modeline = false })
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
            vim.api.nvim_exec_autocmds("User", { pattern = Chiruno.constants.events.DapUi, modeline = false })
          end
          opts.layout = opts.layout or { element = {} }
          opts.layout.element.size = 0.3
          return opts
        end,
      },
    },
  },
}
