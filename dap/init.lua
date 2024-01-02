local M = {}

local js_languages = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "vue"
}

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

  for _, v in ipairs(js_languages) do
    local present, package = pcall(require, "user/dap/handlers/" .. v)
    if not present then goto continue end
    handlers[v] = function(config)
      config = vim.tbl_deep_extend("force", config or {}, package)
      require("mason-nvim-dap").default_setup(config)
    end
    ::continue::
  end
  return handlers
end

return M
