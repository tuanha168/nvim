-- Customize Treesitter

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    dependencies = {
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
          require("treesitter-context").setup {
            max_lines = 5,
          }
        end,
      },
    },
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
        "git_config",
        "ssh_config",
        "http",
        "go",
        "xml",
        "c_sharp",
        "yuck",
        "dot",
        "ini",
        "hyprlang",
        "nu",
        "regex",
      },
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
      },
      incremental_selection = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
        keymaps = {
          init_selection = "<S-Up>",
          node_incremental = "<S-Up>",
          scope_incremental = false,
          node_decremental = "<S-down>",
        },
      },
      pickers = {
        enable = true,
        disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
        },
      },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
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

  { "wellle/targets.vim", event = "BufEnter" },

  {
    "jwalton512/vim-blade",
    ft = "blade",
  },
  {
    "davidmh/mdx.nvim",
    ft = { "md", "mdx" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  {
    "RRethy/vim-illuminate",
    event = "BufRead",
  },
}
