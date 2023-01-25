local M = {}

M.setup = function()
  require("mini.map").setup()
  local map = require "mini.map"
  map.setup {
    integrations = {
      map.gen_integration.builtin_search(),
      map.gen_integration.diagnostic {
        error = "DiagnosticFloatingError",
        warn = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
      },
    },
    symbols = {
      encode = nil,
    },
    window = {
      side = "right",
      width = 20, -- set to 1 for a pure scrollbar :)
      winblend = 15,
      show_integration_count = false,
    },
  }
  vim.api.nvim_create_autocmd({ "BufEnter", "Filetype" }, {
    desc = "Open mini.map and exclude some filetypes",
    pattern = { "*" },
    callback = function()
      local include_ft = {
        "vue",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
        "css",
        "scss",
        "less",
        "json",
        "php",
        "python",
        "go",
        "rust",
        "lua",
      }

      local ok, map = pcall(require, "mini.map")
      if not ok then
        return
      end
      if vim.o.buftype == "" and vim.tbl_contains(include_ft, vim.o.filetype) then
        map.open()
      else
        vim.b.minimap_disable = true
        map.close()
      end
    end,
  })
end

return M
