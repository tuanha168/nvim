local userPlugins = require "custom.plugins"

local M = {}

M.plugins = {
  user = userPlugins,
  override = {
    ["nvim-treesitter/nvim-treesitter"] = require "custom.config.treesitter",
    ["NvChad/ui"] = {
      tabufline = {
        lazyload = false,
      },
    },
    ["williamboman/mason.nvim"] = {
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
      },
    },
    ["NvChad/nvterm"] = {
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
  },
  remove = {
    "folke/which-key.nvim",
    -- "kyazdani42/nvim-tree.lua",
  },
}

M.ui = {
  transparency = true,
  theme = "onedark",
  changed_themes = {
    onedark = {
      base_16 = {
        base08 = "#fc97b7",
      },
    },
  },
}

M.mappings = require "custom.keymaps"

return M
