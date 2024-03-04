return {
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
    event = "User AstroFile",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "User AstroFile",
    opts = {
      render = "background",
      enable_tailwind = true,
    },
    init = function()
      vim.schedule(function()
        vim.cmd "HighlightColors On"
        Print('ok')
      end)
    end,
  },
}
