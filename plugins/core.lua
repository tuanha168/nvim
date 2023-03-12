return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      opts.config = require("alpha.themes.startify").config
      -- customize the dashboard header
      opts.config.layout[2] = {
        type = "text",
        val = {
          [[                                  __]],
          [[     ___     ___    ___   __  __ /\_\    ___ ___]],
          [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
          [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
          [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
          [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        },
        opts = {
          hl = "Type",
          shrink_margin = false,
          -- wrap = "overflow";
        },
      }
      return opts
    end,
  },

  { "kylechui/nvim-surround", event = "BufEnter" },

  {
    "numToStr/Comment.nvim",
    opts = function(_, opts) require("Comment").setup(opts) end,
    config = function() require "user.config.comment" end,
  },

  {
    "max397574/better-escape.nvim",
    opts = function(_, opts)
      opts.mapping = { "jk", "jj", "kk" }
      opts.clear_empty_lines = true
      return opts
    end,
  },

  {
    "ggandor/leap.nvim",
    event = "BufEnter",
    opts = function(_, opts) require("leap").setup(opts) end,
    config = function() require("user.config.leap").setup() end,
  },

  { "wellle/targets.vim",     event = "BufEnter" },

  {
    "andymass/vim-matchup",
    event = "BufEnter",
    config = function() require("user.config.vim-matchup").setup() end,
  },

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    opts = function() vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>UndotreeToggle<CR>", { silent = true }) end,
  },

  {
    "RRethy/vim-illuminate",
    event = "BufEnter",
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = require "user.config.lsp_signature",
  },

  {
    "metakirby5/codi.vim",
    cmd = "Codi",
    build = "npm install -g tsun",
  },

  {
    "aserowy/tmux.nvim",
    opts = {
      copy_sync = {
        enable = false,
      },
    },
  },

  {
    "willothy/flatten.nvim",
    config = true,
  },

  {
    "folke/tokyonight.nvim",
    config = true,
    lazy = false,
  },

  -- {
  --   "folke/which-key.nvim",
  --   config = function(plugin, opts)
  --     plugin.default_config(opts)
  --     -- Add bindings which show up as group name
  --     local wk = require "which-key"
  --     wk.register({
  --       b = { name = "Buffer" },
  --     }, { mode = "n", prefix = "<leader>" })
  --   end,
  -- },
}
