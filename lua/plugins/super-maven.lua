return {
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      -- keymaps = {
      --   accept_suggestion = "<C-F>",
      -- },
      -- ignore_filetypes = { cpp = true },
      -- color = {
      --   suggestion_color = "#ffffff",
      --   cterm = 244,
      -- },
      -- log_level = "info", -- set to "off" to disable logging completely
      -- disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = true, -- disables built in keymaps for more manual control
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)

      vim.keymap.set("i", "<C-F>", function()
        local suggestion = require "supermaven-nvim.completion_preview"
        if suggestion.has_suggestion() then suggestion.on_accept_suggestion() end
      end, { noremap = true, silent = true })
    end,
  },
}
