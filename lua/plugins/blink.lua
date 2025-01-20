---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    build = "cargo build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = {
          "select_next",
          "fallback",
        },
        ["<S-Tab>"] = {
          "select_prev",
          "fallback",
        },
        -- ["<CR>"] = { "select_and_accept", "fallback" },
      },
      -- completion = {
      --   list = {
      --     selection = "auto_insert",
      --   },
      -- },
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
    },
  },
}
