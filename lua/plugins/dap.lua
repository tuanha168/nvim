---@type LazySpec
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
      require("dap.adapters").setup(dap)
      require("dap.config").setup(dap)
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
          opts.ensure_installed = { "js", "netcoredbg" }
          return opts
        end,
      },
      {
        "igorlfs/nvim-dap-view",
        config = true,
        opts = {
          winbar = {
            show = true,
            sections = { "watches", "exceptions", "breakpoints", "threads", "repl" },
            -- Must be one of the sections declared above
            default_section = "watches",
          },
          windows = {
            height = 12,
            terminal = {
              -- 'left'|'right'|'above'|'below': Terminal position in layout
              position = "left",
              -- List of debug adapters for which the terminal should be ALWAYS hidden
              hide = {},
              -- Hide the terminal when starting a new session
              start_hidden = false,
            },
          },
        },
      },
      -- {
      --   "rcarriga/nvim-dap-ui",
      --   dependencies = { "nvim-neotest/nvim-nio" },
      --   config = function(_, opts)
      --     local dapui = require "dapui"
      --     opts.layouts = {
      --       {
      --         -- You can change the order of elements in the sidebar
      --         elements = {
      --           -- Provide IDs as strings or tables with "id" and "size" keys
      --           { id = "repl", size = 0.5 },
      --           { id = "console", size = 0.25 },
      --           {
      --             id = "watches",
      --             size = 0.25,
      --           },
      --         },
      --         size = 0.25,
      --         position = "left", -- Can be "left" or "right"
      --       },
      --       -- {
      --       --   elements = {
      --       --     "repl",
      --       --     "console",
      --       --   },
      --       --   size = 10,
      --       --   position = "bottom", -- Can be "bottom" or "top"
      --       -- },
      --     }
      --     dapui.setup(opts)
      --   end,
      -- },
    },
  },
}
