return {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.config.lspconfig"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.config.null-ls").setup()
    end,
  },
  ["hrsh7th/cmp-cmdline"] = {
    after = "nvim-cmp",
    config = function()
      require "custom.config.cmdline"
    end,
  },
  ["hrsh7th/nvim-cmp"] = {
    after = "alpha-nvim",
    config = function()
      require "plugins.configs.cmp"
    end,
  },
  ["lewis6991/gitsigns.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.config.gitsign").setup()
    end,
  },
  ["kylechui/nvim-surround"] = {
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  ["sindrets/diffview.nvim"] = {},
  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
      require("custom.config.telescope").setup()
    end,
  },
  ["nvim-telescope/telescope-project.nvim"] = {},
  ["gbprod/yanky.nvim"] = {
    config = function()
      require("custom.config.yanky").setup()
    end,
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  -- git
  ["tpope/vim-fugitive"] = {},
  ["TimUntersberger/neogit"] = {
    config = function()
      require("neogit").setup {
        disable_commit_confirmation = true,
        integrations = {
          diffview = true,
        },
      }
    end,
  },

  -- jk escape
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "jj", "kk" },
        clear_empty_lines = true,
      }
    end,
  },

  -- lspsaga
  ["glepnir/lspsaga.nvim"] = {
    config = function()
      require("custom.config.lspsaga").setup()
    end,
  },

  -- lightspeed
  ["ggandor/lightspeed.nvim"] = {
    config = function()
      require("custom.config.lightspeed").setup()
    end,
  },

  -- targets
  ["wellle/targets.vim"] = {},

  -- match-up
  ["andymass/vim-matchup"] = {
    after = "nvim-lspconfig",
    config = function()
      require('custom.config.vim-matchup').setup()
    end,
  },
}
