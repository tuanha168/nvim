return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    opts = function()
      -- local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring")
      -- if commentstring_avail and commentstring then commentstring.setup {} end
      -- vim.g.skip_ts_context_commentstring_module = true
      -- local opts = {
      --   ignore = "^$",
      -- }
      -- local ft = require "Comment.ft"
      -- ft.set("json", "#%s")

      return opts
    end,
  },
}
