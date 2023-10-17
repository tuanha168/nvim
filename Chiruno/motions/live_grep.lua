function Chiruno.live_grep_motion()
  require("telescope.builtin").live_grep {
    default_text = Chiruno.get_text_selection().escaped,
    hidden = true,
  }
  vim.schedule(function() Chiruno.feedkeys("<ESC>", "i") end)
end

return Chiruno.live_grep_motion
