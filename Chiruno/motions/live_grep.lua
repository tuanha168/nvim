function Chiruno.live_grep_motion()
  local text = Chiruno.get_text_selection().text
  require("telescope.builtin").live_grep {
    -- search = Chiruno.get_text_selection().text,
    hidden = true,
  }
  Chiruno.feedkeys(text, "i")
end

return Chiruno.live_grep_motion
