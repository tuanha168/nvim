local M = {}

M.handlers = function(packages, opts)
  opts.handlers = opts.handlers or {}
  for _, v in ipairs(packages) do
    local present, package = pcall(require, "user/dap/handlers/" .. v)
    if not present then goto continue end
    opts.handlers[v] = package
      ::continue::
  end
  return opts.handlers
end

return M
