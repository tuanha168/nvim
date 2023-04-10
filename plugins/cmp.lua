return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = {
        { name = "nvim_lsp" },
        { name = "codeium" },
        { name = "cmp_tabnine" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      }

      return opts
    end,
  },
  { "hrsh7th/cmp-cmdline", lazy = false, config = function() require "user.config.cmdline" end },
}
