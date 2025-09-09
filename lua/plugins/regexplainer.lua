---@type LazySpec
return {
  "bennypowers/nvim-regexplainer",
  opts = {
    auto = true,
    mappings = {
      toggle = "<Leader>gR",
      -- examples, not defaults:
      -- show = 'gS',
      -- hide = 'gH',
      -- show_split = 'gP',
      -- show_popup = 'gU',
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
  },
}
