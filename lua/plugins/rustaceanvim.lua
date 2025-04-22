return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    opts = function() vim.g.rustaceanvim = { dap = { autoload_configurations = false } } end,
  },
}
