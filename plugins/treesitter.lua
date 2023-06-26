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
        "vim",
        "bash",
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
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = require("user.config.nvim-ts-autotag").opts,
    config = require("user.config.nvim-ts-autotag").config(),
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = require "user.config.nvim-ts-rainbow2",
  },
  {
    "David-Kunz/markid",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = require "user.config.markid",
  },
  -- {
  --   "ckolkey/ts-node-action",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   event = "BufRead",
  --   opts = {},
  --   config = function()
  --     vim.keymap.set({ "n" }, "<leader>m", require("ts-node-action").node_action, { desc = "Trigger Node Action" })
  --
  --     require("null-ls").register {
  --       name = "more_actions",
  --       method = { require("null-ls").methods.CODE_ACTION },
  --       filetypes = { "_all" },
  --       generator = {
  --         fn = require("ts-node-action").available_actions,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   event = "BufRead",
  --   config = require("user.config.nvim-treesitter-textobjects").config,
  -- },
}
