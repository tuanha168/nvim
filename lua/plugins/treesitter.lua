return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    opts = function()
      require("nvim-treesitter.configs").setup {
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
        auto_install = true,
        ignore_install = {},
        autotag = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
        highlight = {
          enable = true,
          disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
          additional_vim_regex_highlighting = { "markdown" },
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<S-Up>",
            node_incremental = "<S-Up>",
            scope_incremental = false,
            node_decremental = "<S-down>",
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = require "config.nvim-ts-rainbow2",
  },
  {
    "David-Kunz/markid",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = require "config.markid",
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
}
