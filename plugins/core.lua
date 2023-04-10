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

  { "kylechui/nvim-surround", event = "BufEnter", opts = {} },

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
    event = "BufEnter",
    config = function() vim.api.nvim_set_keymap("n", "<C-y>", "<cmd>UndotreeToggle<CR>", { silent = true }) end,
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
    "willothy/flatten.nvim",
    lazy = false,
    opts = {
      callbacks = {
        -- Called when a request to edit file(s) is received
        pre_open = function() vim.cmd ":q" end,
        -- Called after a file is opened
        -- Passed the buf id, win id, and filetype of the new window
        -- post_open = function(bufnr, winnr, filetype)
        -- post_open = function() end,
        -- Called when a file is open in blocking mode, after it's done blocking
        -- (after bufdelete, bufunload, or quitpre for the blocking buffer)
        block_end = function()
          local openLazygit = vim.api.nvim_replace_termcodes("<leader>gg", true, false, true)
          local quit = vim.api.nvim_replace_termcodes("i<Enter>q", true, false, true)
          vim.api.nvim_feedkeys(openLazygit, "m", false)
          vim.defer_fn(function() vim.api.nvim_feedkeys(quit, "m", false) end, 500)
        end,
      },
      window = {
        open = "current",
        focus = "first",
      },
    },
  },

  {
    "chrisgrieser/nvim-spider",
    event = "BufEnter",
    opts = { skipInsignificantPunctuation = false },
    config = function()
      -- Keymaps
      vim.keymap.set({ "n", "o", "x" }, "w", function() require("spider").motion "w" end, { desc = "Spider-w" })
      vim.keymap.set({ "n", "o", "x" }, "e", function() require("spider").motion "e" end, { desc = "Spider-e" })
      vim.keymap.set({ "n", "o", "x" }, "b", function() require("spider").motion "b" end, { desc = "Spider-b" })
      vim.keymap.set({ "n", "o", "x" }, "ge", function() require("spider").motion "ge" end, { desc = "Spider-ge" })
    end,
  },

  -- {
  --   -- Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}
  --   "knubie/vim-kitty-navigator",
  --   build = "cp ./*.py ~/.config/kitty/",
  --   lazy = false,
  -- },

  {
    "aserowy/tmux.nvim",
    opts = {
      copy_sync = {
        enable = false,
      },
    },
  },

  -- {
  --   "mg979/vim-visual-multi",
  --   branch = "master",
  --   event = "BufEnter",
  -- },

  -- {
  --   "chrisgrieser/nvim-various-textobjs",
  --   event = "BufEnter",
  --   opts = { useDefaultKeymaps = true },
  -- },

  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   event = "BufEnter",
  --   opts = {},
  -- },

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
