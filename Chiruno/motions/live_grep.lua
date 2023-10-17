function Chiruno.live_grep_motion(mode)
  require("telescope.builtin").grep_string {
    search = Chiruno.get_text_selection(mode).text,
    hidden = true,
  }
  vim.schedule(function() Chiruno.feedkeys("<ESC>", "i") end)
end

return Chiruno.live_grep_motion
