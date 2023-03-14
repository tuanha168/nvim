return {
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
    },
    disable = true,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
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
      require("custom.config.nvim-cmp").setup()
    end,
  },
  ["lewis6991/gitsigns.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.config.gitsign").setup()
    end,
  },
  ["kylechui/nvim-surround"] = {
    after = "nvim-lspconfig",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  ["nvim-telescope/telescope.nvim"] = {
    override_options = require "custom.config.telescope",
  },
  ["nvim-telescope/telescope-project.nvim"] = {},
  ["aaronhallaert/advanced-git-search.nvim"] = {},
  ["gbprod/yanky.nvim"] = {
    after = "nvim-lspconfig",
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
  -- ["TimUntersberger/neogit"] = {
  --   config = function()
  --     require("neogit").setup {
  --       disable_commit_confirmation = true,
  --       integrations = {
  --         diffview = true,
  --       },
  --     }
  --   end,
  -- },

  -- ["sindrets/diffview.nvim"] = {
  --   event = "BufRead",
  -- },

  ["numToStr/Comment.nvim"] = {
    override_options = function()
      require "custom.config.comment"
      return {}
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
    after = "alpha-nvim",
    config = function()
      require("custom.config.lspsaga").setup()
    end,
  },
  -- leap
  ["ggandor/leap.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.config.leap").setup()
    end,
  },
  -- targets
  ["wellle/targets.vim"] = {},
  -- match-up
  ["andymass/vim-matchup"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.config.vim-matchup").setup()
    end,
  },
  ["David-Kunz/markid"] = {
    config = function()
      require("custom.config.markid").setup()
    end,
  },
  -- ["zbirenbaum/copilot.lua"] = {
  --   event = "InsertEnter",
  --   config = function()
  --     require("custom.config.copilot").setup()
  --   end,
  -- },

  -- Tabnine
  ["tzachar/cmp-tabnine"] = {
    event = "InsertEnter",
    run = "./install.sh",
    config = function()
      require("custom.config.tabnine").setupCmp()
    end,
  },
  -- ["codota/tabnine-nvim"] = {
  --   event = "InsertEnter",
  --   run = "./dl_binaries.sh",
  --   config = function()
  --     require("custom.config.tabnine").setupClient()
  --   end,
  -- },

  -- undotree
  ["mbbill/undotree"] = {
    cmd = "UndotreeToggle",
    setup = function()
      vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>UndotreeToggle<CR>", { silent = true })
    end,
  },
  -- documentations generator
  -- ["kkoomen/vim-doge"] = {
  --   run = ":call doge#install()",
  --   cmd = "DogeGenerate",
  --   config = function()
  --     require("custom.config.doge").setup()
  --   end,
  -- },
  ["danymat/neogen"] = {
    config = function()
      require("neogen").setup {}
    end,
  },
  ["nvim-tree/nvim-tree.lua"] = {
    override_options = require "custom.config.nvim-tree",
  },
  -- ["marilari88/twoslash-queries.nvim"] = {
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require("twoslash-queries").setup {
  --       multi_line = true, -- to print types in multi line mode
  --       is_enabled = true, -- to keep disabled at startup and enable it on request with the EnableTwoslashQueries
  --       vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>InspectTwoslashQueries<CR>", {}),
  --     }
  --   end,
  -- },
  ["b0o/schemastore.nvim"] = {},
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    after = "telescope.nvim",
    run = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },
  ["RRethy/vim-illuminate"] = {
    after = "nvim-lspconfig",
  },
  ["nacro90/numb.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("numb").setup()
    end,
  },
  ["ruifm/gitlinker.nvim"] = {
    event = "BufRead",
    config = function()
      require("custom.config.gitlinker").setup()
    end,
  },
  ["ray-x/lsp_signature.nvim"] = {
    config = function()
      require("custom.config.lsp_signature").setup()
    end,
  },
  ["metakirby5/codi.vim"] = {
    cmd = "Codi",
    run = "npm install -g tsun",
  },
  ["monaqa/dial.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.config.dial").setup()
    end,
  },
  ["karb94/neoscroll.nvim"] = {
    config = function()
      require("custom.config.neoscroll").setup()
    end,
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    config = function()
      require("custom.config.indent-blankline").setup()
    end,
  },
  -- ["jackMort/ChatGPT.nvim"] = {
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require("chatgpt").setup {}
  --   end,
  --   requires = {
  --     "MunifTanjim/nui.nvim",
  --   },
  -- },
  -- ["manzeloth/live-server"] = {
  --   after = "nvim-lspconfig",
  --   run = "npm install -g live-server",
  -- },
  ["kkoomen/vim-doge"] = {
    run = ":call doge#install()",
  },
  -- ["diepm/vim-rest-console"] = {},
  ["aserowy/tmux.nvim"] = {
    config = function()
      require("tmux").setup {
        copy_sync = {
          enable = false,
        },
      }
    end,
  },
  -- ["barrett-ruth/import-cost.nvim"] = {
  --   run = "sh ./install.sh yarn",
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require("import-cost").setup {
  --       filetypes = {
  --         "vue",
  --         "javascript",
  --         "javascriptreact",
  --         "typescript",
  --         "typescriptreact",
  --       },
  --     }
  --   end,
  -- },
  ["nvim-neorg/neorg"] = {
    after = "nvim-treesitter",
    run = ":Neorg sync-parsers", -- This is the important bit!
    config = function()
      require "custom.config.neorg"
    end,
  },
  ["willothy/flatten.nvim"] = {
    config = function()
      require "custom.config.flatten"
    end,
  },
}
