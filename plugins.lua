return {
  ["folke/which-key.nvim"] = false,
  ["nvim-treesitter/nvim-treesitter"] = require "custom.config.treesitter",
  -- ["NvChad/ui"] = {
  --   override_options = {
  --     tabufline = {
  --       lazyload = false,
  --     },
  --   }
  -- },
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev
        "typescript-language-server",
        "angular-language-server",
        -- "vetur-vls",
        "vue-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "json-lsp",
        -- lint
        "eslint-lsp",
        "prettier",

        -- php
        "intelephense",

        -- python
        "pyright",
        "python-lsp-server",
      },
    }
  },
  ["NvChad/nvterm"] = {
    override_options = {
      terminals = {
        type_opts = {
          float = {
            relative = "editor",
            row = 0.6,
            col = 0.25,
            width = 1,
            height = 1,
            border = "single",
          },
        },
      },
    }
  },
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
  ["sindrets/diffview.nvim"] = {},

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
  -- ["ggandor/lightspeed.nvim"] = {
  --   config = function()
  --     require("custom.config.lightspeed").setup()
  --   end,
  -- },

  -- targets
  ["wellle/targets.vim"] = {},

  -- match-up
  ["andymass/vim-matchup"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.config.vim-matchup").setup()
    end,
  },

  -- CamelCaseMotion
  -- ["bkad/CamelCaseMotion"] = {
  --   config = function()
  --     require("custom.config.CamelCaseMotion").setup()
  --   end,
  -- },

  ["David-Kunz/markid"] = {
    config = function()
      require("custom.config.markid").setup()
    end,
  },
}
