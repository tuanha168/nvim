return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "vue",
        "scss",
        "regex",
        "php",
        "pug",
        "json",
        "jsonc",
        "css",
        "tsx",
        "html",
        "python",
        "rust",
        "markdown",
        "markdown_inline",
        "query",
        "norg",
        "vim",
        "kdl",
        "bash",
        "dockerfile",
        "yaml",
        "terraform",
        "ssh_config",
        "http",
      }
      opts.sync_install = true
      opts.ignore_install = {}
      opts.highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      }
      opts.indent = {
        enable = true,
      }
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<S-Up>",
          node_incremental = "<S-Up>",
          scope_incremental = false,
          node_decremental = "<S-down>",
        },
      }

      opts.pickers = {
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
        },
      }

      return opts
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "xml",
        "php",
        "markdown",
        "glimmer",
        "handlebars",
        "hbs",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    keys = {
      { "H", function() require("treesitter-context").go_to_context() end, desc = "Go to context" },
    },
    config = true,
  },
  -- {
  --   "HiPhish/nvim-ts-rainbow2",
  --   event = "BufRead",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   config = require "user.config.nvim-ts-rainbow2",
  -- },
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          vue = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterGreen",
          "RainbowDelimiterOrange",
          "RainbowDelimiterBlue",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        -- blacklist = { "c", "cpp" },
      }
    end,
  },
  {
    -- "David-Kunz/markid",
    "tuanha168/markid",
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
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local ft = require("hlchunk.utils.filetype").exclude_filetypes
      local exclude_filetypes = Chiruno.func.extends_table(ft, { Chiruno.constants.templateBuffer })
      return {
        indent = {
          -- chars = { "·", "·", "·", "·" }, -- more code can be found in https://unicodeplus.com/
          chars = { "│", "¦", "┆", "┊" }, -- more code can be found in https://unicodeplus.com/

          style = {
            "#333333",
          },
        },
        blank = {
          enable = false,
        },

        chunk = {
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = "─",
          },
          style = "#00ffff",
          exclude_filetypes = exclude_filetypes,
        },

        line_num = {
          style = "#fcb3ed",
        },
      }
    end,
  },

  {
    "jwalton512/vim-blade",
    ft = "blade",
  },
}
