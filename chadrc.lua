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
        "vetur-vls",
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
  },
  remove = {
    "folke/which-key.nvim",
  },
}

M.ui = {
  transparency = true,
  theme = "onedark",
}

M.mappings = require "custom.keymaps"

return M
