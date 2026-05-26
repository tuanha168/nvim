local lazy = require("pack.lazy-load")

local function is_raspberry_pi()
  local model_paths = {
    "/proc/device-tree/model",
    "/sys/firmware/devicetree/base/model",
  }

  for _, path in ipairs(model_paths) do
    if vim.fn.filereadable(path) == 1 then
      local ok, lines = pcall(vim.fn.readfile, path)
      if ok and #lines > 0 and table.concat(lines, " "):find("Raspberry Pi", 1, true) then
        return true
      end
    end
  end

  return false
end

if not is_raspberry_pi() then return end

lazy.on_event("https://github.com/ojroques/nvim-osc52", "VimEnter", function()
  local osc52 = require("osc52")

  osc52.setup()

  local function copy()
    if vim.v.event.operator == "y" and vim.v.event.regname == "" then
      osc52.copy_register("")
    end
  end

  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = copy,
  })
end)
