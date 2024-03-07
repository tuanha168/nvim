return {
  {
    "bloznelis/before.nvim",
    keys = {
      {
        "<C-o>",
        function()
          local before = require "before"
          before.jump_to_last_edit()
        end,
        mode = "n",
        desc = "Go to previous edit",
      },
      {
        "<C-z>i",
        function()
          local before = require "before"
          before.jump_to_next_edit()
        end,
        mode = "n",
        desc = "Go to next edit",
      },
    },
    opts = {
      -- history_size = 100
    },
  },
}
