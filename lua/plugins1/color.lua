---@type LazySpec
return {
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup {
        render = "virtual",
      }
      vim.cmd "HighlightColors On"
    end,
  },
}
