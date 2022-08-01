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
  ["nvim-telescope/telescope-project.nvim"] = {
    after = "telescope.nvim",
    config = function()
      require("custom.config.project").setup()
    end,
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },
  ["unblevable/quick-scope"] = {},
  ["gbprod/yanky.nvim"] = {
    config = function()
      require("yanky").setup {}
    end,
  },
  ["tpope/vim-fugitive"] = {},
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = {"jk", "jj", "kk"},
      }
    end,
  },
  ["glepnir/lspsaga.nvim"] = {
    config = function ()
      local saga = require 'lspsaga'
      saga.init_lsp_saga()
    end
  }
}
