---@type LazySpec
return {
  {
    "mfussenegger/nvim-dap",
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
        "jay-babu/mason-nvim-dap.nvim",
        opts = { ensure_installed = { "js", "netcoredbg" } },
      },
    },
  },
  {
    "igorlfs/nvim-dap-view",
    keys = {
      {
        "<Leader>dk",
        function() require("config.nvim-dap-view").Dap_better_hover() end,
        desc = "Dap Hover",
      },
    },
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        opts = {},
      },
    },
    opts = {
      winbar = {
        show = true,
        sections = { "watches", "exceptions", "breakpoints", "threads", "repl" },
        -- Must be one of the sections declared above
        default_section = "repl",
      },
      windows = {
        height = 12,
        terminal = {
          -- 'left'|'right'|'above'|'below': Terminal position in layout
          position = "right",
          -- List of debug adapters for which the terminal should be ALWAYS hidden
          -- hide = { "chrome", "pwa-chrome" },
          -- Hide the terminal when starting a new session
          start_hidden = false,
        },
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "dap-view-term" },
        callback = function(event)
          vim.schedule(function()
            local session = require("dap").session()
            if not session then return end

            for _, adapter in ipairs { "pwa-chrome", "chrome" } do
              if session.config.type == adapter then vim.api.nvim_buf_delete(event.buf, { force = true }) end
            end
          end)
        end,
      })

      require("dap-view").setup(opts)
    end,
  },
}
