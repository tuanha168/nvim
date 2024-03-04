return {
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
    event = "User AstroFile",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "User AstroFile",
    config = function()
      require("nvim-highlight-colors").setup {
        render = "background",
        enable_tailwind = true,
      }
      vim.cmd "HighlightColors On"
    end,
  },
}
