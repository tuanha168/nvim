-- Customize Treesitter

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      require "markid"
      require "treesitter-context"
      require "rainbow-delimiters"

      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
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
        "go",
        "xml",
        "c_sharp",
        "yuck",
      })
      opts.sync_install = true
      opts.ignore_install = {}
      opts.highlight = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
        additional_vim_regex_highlighting = { "markdown" },
      }
      opts.indent = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
      }
      opts.incremental_selection = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
        keymaps = {
          init_selection = "<S-Up>",
          node_incremental = "<S-Up>",
          scope_incremental = false,
          node_decremental = "<S-down>",
        },
      }

      opts.pickers = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
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
    -- event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "H", function() require("treesitter-context").go_to_context() end, desc = "Go to context" },
    },
    config = function()
      vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = true })
    end,
  },
  -- {
  --   "HiPhish/nvim-ts-rainbow2",
  --   event = "BufRead",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   config = require "config.nvim-ts-rainbow2",
  -- },
  {
    "hiphish/rainbow-delimiters.nvim",
    -- event = "BufRead",
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
    -- event = "BufRead",
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
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   event = "BufRead",
  --   config = require("config.nvim-treesitter-textobjects").config,
  -- },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = function()
      local ft = require("hlchunk.utils.filetype").exclude_filetypes
      local exclude_filetypes = Chiruno.func.extends_table(
        ft,
        { [Chiruno.constants.templateBuffer] = true, tmux = true, harpoon = true, minifiles = true, dbui = true }
      )
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

  -- {
  --   "code-biscuits/nvim-biscuits",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   event = { "InsertLeave", "CursorHoldI" },
  --   opts = {
  --     on_events = { "InsertLeave", "CursorHoldI" },
  --     show_on_start = true,
  --   },
  -- },
}
