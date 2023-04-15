local M = {}

M.handlers = function(packages)
  local handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require("mason-nvim-dap").default_setup(config)
    end,
  }
  for _, v in ipairs(packages) do
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
