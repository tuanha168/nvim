local lazy = require "pack.lazy-load"

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "cursortab.nvim" and (kind == "install" or kind == "update") then
      Print(ev.data.path .. "/server")
      vim.system({ "go", "build" }, { cwd = ev.data.path .. "/server" })
    end
  end,
})

lazy.on_event("https://github.com/cursortab/cursortab.nvim", "BufRead", function()
  vim.api.nvim_set_hl(0, "CursorTabAddition", { bg = "#1a3a1a" })
  require("cursortab").setup {
    provider = {
      -- type = "copilot",
      type = "zeta-2",
      url = "http://localhost:8000",
      temperature = 0.0,
      context_size = 2048,
      max_tokens = 64,
      top_k = 40,
      completion_timeout = 30000,
      max_diff_history_tokens = 256,
    },
    keymaps = {
      accept = "<C-f>",
    },
    ui = {
      jump = {
        symbol = "",
        text = " Ctrl + F ",
        show_distance = true,
      },
    },
  }
end)
