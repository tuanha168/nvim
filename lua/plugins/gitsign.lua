---@type LazySpec
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      local conf = require "config.gitsign"
      for k, v in pairs(conf) do
        opts[k] = v
      end
      local default_on_attach = opts.on_attach

      opts.on_attach = function(bufnr)
        default_on_attach(bufnr)
        local haveRepoLink, _ = pcall(require, "repolink")
        if not haveRepoLink then return end

        local keys = require("config.repolink").lazyKeys
        for _, key in ipairs(keys) do
          vim.keymap.set(key.mode, key[1], key[2], { buffer = bufnr, desc = key.desc })
        end
      end

      return opts
    end,
  },
}
