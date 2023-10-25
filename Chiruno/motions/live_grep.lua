function Chiruno.live_grep_motion(mode)
  require("telescope.builtin").grep_string {
    search = Chiruno.func.get_text_selection(mode).text,
    hidden = true,
  }
  vim.schedule(function() Chiruno.func.feedkeys("<ESC>", "i") end)
end

return Chiruno.live_grep_motion
