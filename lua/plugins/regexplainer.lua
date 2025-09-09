---@type LazySpec
return {
  "bennypowers/nvim-regexplainer",
  opts = {
    debug = true,
    auto = true,
    mappings = {
      toggle = "<Leader>gR",
      -- examples, not defaults:
      -- show = 'gS',
      -- hide = 'gH',
      -- show_split = 'gP',
      -- show_popup = 'gU',
    },
    -- filetypes (i.e. extensions) in which to run the autocommand
    filetypes = {
      "html",
      "js",
      "cjs",
      "mjs",
      "ts",
      "jsx",
      "tsx",
      "cjsx",
      "mjsx",
    },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
  },
}
