local M = {}

M.handlers = function(packages)
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

  for _, v in ipairs(packages) do
    local is_ok, dap_handlers = pcall(require, "user/dap/handlers/" .. v)
    if not is_ok then goto continue end
    handlers[v] = function(config)
      config = vim.tbl_deep_extend("force", config or {}, dap_handlers)
      config.adapters = require("user.dap.adapters")
      require("mason-nvim-dap").default_setup(config)
    end
    ::continue::
  end
  return handlers
end

return M
