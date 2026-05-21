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
      temperature = 0.0, -- Sampling temperature
      context_size = 0, -- Max input context size in tokens (0 = use max_tokens)
      max_tokens = 512, -- Max tokens to generate
      top_k = 50, -- Top-k sampling
      completion_timeout = 5000, -- Timeout in ms for completion requests
      max_diff_history_tokens = 512, -- Max tokens for diff history (0 = no limit)
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
