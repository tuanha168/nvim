return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "vue",
        "scss",
        "regex",
        "php",
        "pug",
        "json",
        "css",
        "tsx",
        "html",
        "python",
        "markdown",
        "markdown_inline",
        "query",
        "norg",
      },
      sync_install = true,
      ignore_install = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = {
        enable = true,
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = require "user.config.nvim-ts-autotag",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
  },
}
