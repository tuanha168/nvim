return {
  {
    "folke/zen-mode.nvim",
    event = "BufEnter",
    opts = {
      window = {
        width = 0.60,
      },
    },
    keys = {
      {
        "<leader>z",
        function()
          -- close NeoTree
          local ok, neo = pcall(require, "neo-tree.command")
          if ok then neo.execute { action = "close" } end
          local Split = require "nui.split"
          local event = require("nui.utils.autocmd").event

          local highlights = require "neo-tree.ui.highlights"
          local split = Split {
            ns_id = highlights.ns_id,
            relative = "editor",
            position = "left",
            size = "20%",
          }

          -- mount/open the component
          split:mount()

          -- unmount component when cursor leaves buffer
          -- split:on(event.BufLeave, function() split:unmount() end)

          -- require("zen-mode").toggle()
        end,
        desc = "Zen Mode",
      },
    },
  },
  {
    "folke/twilight.nvim",
    opts = {
      context = 15,
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function_declaration",
        "if_statement",
        "try_statement",
        "arrow_function",
        "lexical_declaration",
      },
    },
  },
}
