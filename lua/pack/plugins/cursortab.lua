local lazy = require "pack.lazy-load"

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "cursortab.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "go", "build" }, { cwd = ev.data.path + "/server" })
    end
  end,
})

lazy.on_event("https://github.com/cursortab/cursortab.nvim", "BufRead", function()
  vim.api.nvim_set_hl(0, "CursorTabAddition", { bg = "#1a3a1a" })
  require("cursortab").setup {
    provider = {
      type = "copilot",
      -- type = "zeta-2",
      -- url = "http://localhost:8000",
    },
  }
end)
