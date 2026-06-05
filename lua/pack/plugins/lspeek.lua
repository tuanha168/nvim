local lazy = require "pack.lazy-load"
local plugin = "https://github.com/r4ppz/lspeek.nvim"

local opts = {
  window = {
    width = 70,
    height = 15,
    border = "single",
  },
  stack_limit = 5,
  select_first = false,
  keymaps = {
    close = "q",
    split = "s",
    vsplit = "v",
    enter = "<CR>",
    tab = "t",
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    lazy.on_key(plugin, {
      {
        "gd",
        function() require("lspeek").peek_definition() end,
        buffer = ev.buf,
        desc = "Peek Definition (lspeek)",
      },
      {
        "gT",
        function() require("lspeek").peek_type_definition() end,
        buffer = ev.buf,
        desc = "Peek Type Definition (lspeek)",
      },
    }, function()
      require("lspeek").setup(opts)
    end)
  end,
})
