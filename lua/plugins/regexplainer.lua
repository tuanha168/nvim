---@type LazySpec
return {
  "bennypowers/nvim-regexplainer",
  opts = {
    mode = "graphical",
    auto = true,
    graphical = {
      -- Optional: customize image generation
      generation_width = 1200, -- Initial generation width (default: 1200)
      generation_height = 800, -- Initial generation height (default: 800)
    },
    debug = true,
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
    "edluffy/hologram.nvim",
  },
}
