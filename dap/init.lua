local M = {}

M.handlers = function()
  -- local dap = require("dap")
  -- local adapters = require("user.dap.adapters")
  -- for k, v in pairs(adapters) do
  --   dap.adapters[k] = v
  -- end

  local handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require("mason-nvim-dap").default_setup(config)
    end,
  }

  local adapters = require "user.dap.handlers.adapters"
  local configurations = require "user.dap.handlers.configurations"
  local filetypes = require "user.dap.handlers.filetypes"

  for k, v in pairs(adapters) do
    handlers["js"] = function(config)
      config.adapters = v
      config.filetypes = filetypes
      config.configurations = configurations
      require("mason-nvim-dap").default_setup(config)
    end
  end

  return handlers
end

return M
