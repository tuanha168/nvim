require("lazy").setup {
  spec = {
    { import = "plugins" },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      config = true,
      opts = {
        library = {
          "~/.local/share/nvim/lazy/",
        },
      },
    },
    {
      "tuanha168/magenta-history.nvim",
      dev = true,
      dependencies = {
        "dlants/magenta.nvim",
        "folke/snacks.nvim",
      },
      opts = {},
    },
  },
  dev = {
    path = "~/.local/share/nvim/dev-plugins",
  },
  -- Configure any other `lazy.nvim` configuration options here
  install = { colorscheme = { "Mofiqul/dracula.nvim" } },
  -- automatically check for plugin updates
  -- checker = { enabled = true },
}
