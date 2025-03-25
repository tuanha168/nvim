---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
    -- enabled = false,
    keys = {
      { "<Leader>dc", function() end, desc = "Continue" },
    },
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
      require("dap.listeners").setup(dap)
    end,
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        lazy = true,
        opts = function(_, opts)
          opts.ensure_installed = { "js", "netcoredbg" }
          return opts
        end,
      },
      -- {
      --   "igorlfs/nvim-dap-view",
      --   keys = {
      --     {
      --       "<Leader>dk",
      --       function() require("config.nvim-dap-view").Dap_better_hover() end,
      --       desc = "Dap Hover",
      --     },
      --   },
      --   opts = {
      --     winbar = {
      --       show = true,
      --       sections = { "watches", "exceptions", "breakpoints", "threads", "repl" },
      --       -- Must be one of the sections declared above
      --       default_section = "repl",
      --     },
      --     windows = {
      --       height = 12,
      --       terminal = {
      --         -- 'left'|'right'|'above'|'below': Terminal position in layout
      --         position = "right",
      --         -- List of debug adapters for which the terminal should be ALWAYS hidden
      --         -- hide = { "chrome", "pwa-chrome" },
      --         -- Hide the terminal when starting a new session
      --         start_hidden = false,
      --       },
      --     },
      --   },
      --   config = function(_, opts)
      --     vim.api.nvim_create_autocmd({ "FileType" }, {
      --       pattern = { "dap-view-term" },
      --       callback = function(event)
      --         vim.schedule(function()
      --           local session = require("dap").session()
      --           if not session then return end

      --           for _, adapter in ipairs { "pwa-chrome", "chrome" } do
      --             if session.config.type == adapter then vim.api.nvim_buf_delete(event.buf, { force = true }) end
      --           end
      --         end)
      --       end,
      --     })

      --     require("dap-view").setup(opts)
      --   end,
      -- },
      {
        "rcarriga/nvim-dap-ui",
        enabled = false,
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function(_, opts)
          local dapui = require "dapui"
          opts.layouts = {
            {
              -- You can change the order of elements in the sidebar
              elements = {
                -- Provide IDs as strings or tables with "id" and "size" keys
                { id = "repl", size = 0.5 },
                { id = "console", size = 0.25 },
                {
                  id = "watches",
                  size = 0.25,
                },
              },
              size = 0.25,
              position = "left", -- Can be "left" or "right"
            },
            -- {
            --   elements = {
            --     "repl",
            --     "console",
            --   },
            --   size = 10,
            --   position = "bottom", -- Can be "bottom" or "top"
            -- },
          }
          dapui.setup(opts)
        end,
      },
    },
  },
}
