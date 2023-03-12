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
    opts = require("user.config.nvim-ts-autotag").opts,
    config = require("user.config.nvim-ts-autotag").config(),
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    event = "BufEnter",
    config = require "user.config.nvim-ts-rainbow2",
  },
  {
    "David-Kunz/markid",
    event = "BufEnter",
    config = require "user.config.markid",
  },
  -- {
  --   "nvim-treesitter/playground",
  --   event = "BufEnter",
  --   config = function()
  --     require("nvim-treesitter.configs").setup {
  --       playground = {
  --         enable = true,
  --         disable = {},
  --         updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  --         persist_queries = false, -- Whether the query persists across vim sessions
  --         keybindings = {
  --           toggle_query_editor = "o",
  --           toggle_hl_groups = "i",
  --           toggle_injected_languages = "t",
  --           toggle_anonymous_nodes = "a",
  --           toggle_language_display = "I",
  --           focus_language = "f",
  --           unfocus_language = "F",
  --           update = "R",
  --           goto_node = "<cr>",
  --           show_help = "?",
  --         },
  --       },
  --     }
  --   end,
  -- },
}
