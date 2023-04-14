return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = {
        { name = "nvim_lsp" },
        -- { name = "codeium" },
        -- { name = "cmp_tabnine" },
        -- { name = "luasnip" },
        { name = "buffer" },
        -- { name = "nvim_lua" },
        { name = "path" },
      }

      opts.mapping["<C-k>"] = {}
      opts.mapping["<C-j>"] = {}

      return opts
    end,
  },
  { "hrsh7th/cmp-cmdline", event = "VeryLazy", config = function() require "user.config.cmdline" end },
}
