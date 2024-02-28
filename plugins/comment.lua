return {
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    opts = function()
      local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      local opts = {
        ignore = "^$",
      }
      if commentstring_avail and commentstring then opts.pre_hook = commentstring.create_pre_hook() end
      local ft = require('Comment.ft')
      ft.set('json', '#%s')

      return opts
    end,
  },
}
