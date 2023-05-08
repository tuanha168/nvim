Chiruno.live_grep_motion = function()
  require("telescope.builtin").grep_string { search = Chiruno.get_text_selection().text }
  vim.api.nvim_feedkeys("<ESC>", "i", false)
end
