return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },

        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then return { "buffer" } end
          -- Commands
          if type == ":" then return { "cmdline" } end
          return {}
        end,
      },
      fuzzy = {
        prebuilt_binaries = {
          download = true,
        },
      },
    },
  },
}
