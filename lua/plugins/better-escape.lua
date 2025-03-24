return {
  {
    "max397574/better-escape.nvim",
    commit = "7e86edafb8c7e73699e0320f225464a298b96d12",
    opts = function(_, opts)
      opts.mapping = { "jk", "jj", "kk" }
      opts.clear_empty_lines = true
      return opts
    end,
  },
}
