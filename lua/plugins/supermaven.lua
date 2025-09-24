return {
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   event = "BufRead",
  --   opts = {
  --     -- keymaps = {
  --     --   accept_suggestion = "<C-F>",
  --     -- },
  --     -- ignore_filetypes = { cpp = true },
  --     -- color = {
  --     --   suggestion_color = "#ffffff",
  --     --   cterm = 244,
  --     -- },
  --     log_level = "off", -- set to "off" to disable logging completely
  --     -- disable_inline_completion = false, -- disables inline completion for use with cmp
  --     disable_keymaps = true, -- disables built in keymaps for more manual control
  --   },
  --   config = function(_, opts)
  --     require("supermaven-nvim").setup(opts or {})

  --     vim.keymap.set("i", "<C-f>", function()
  --       local suggestion = require "supermaven-nvim.completion_preview"
  --       suggestion.on_accept_suggestion()
  --     end, { noremap = true, silent = true })

  --     vim.keymap.set("i", "<C-j>", function()
  --       local suggestion = require "supermaven-nvim.completion_preview"
  --       suggestion.on_accept_suggestion_word()
  --     end, { noremap = true, silent = true })
  --   end,
  -- },
}
