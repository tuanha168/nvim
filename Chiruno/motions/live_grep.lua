function Chiruno.live_grep_motion()
  require("telescope.builtin").grep_string {
    search = Chiruno.get_text_selection().escaped,
    hidden = true,
  }
  vim.schedule(function() Chiruno.feedkeys("<ESC>", "i") end)
end

return Chiruno.live_grep_motion
