require "Chiruno"
require "options"

Chiruno.servers = {
  lua_ls = require "lsp.lua_ls",
  vue_ls = require "lsp.vue_ls",
  eslint = require "lsp.eslint",
  tailwindcss = require "lsp.tailwindcss",
  jsonls = {},
  intelephense = require "lsp.intelephense",
  yamlls = {},
  -- omnisharp = require "lsp.omnisharp",
  cssls = require "lsp.cssls",
  html = require "lsp.html",
  -- ts_ls = require "lsp.ts_ls",
  vtsls = require "lsp.vtsls",
  stylelint_lsp = require "lsp.stylelint_lsp",

  ---@reference lua/plugins/rustaceanvim.lua
  -- rust_analyzer = require "lsp.rust_analyzer",
}


-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
  { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
