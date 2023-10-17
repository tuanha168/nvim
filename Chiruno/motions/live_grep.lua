function Chiruno.live_grep_motion()
  require("telescope.builtin").live_grep {
    -- search = Chiruno.get_text_selection().text,
    hidden = true,
  }
  Chiruno.print(Chiruno.get_text_selection().text)
  -- Chiruno.feedkeys(Chiruno.get_text_selection().text, "i")
end

return Chiruno.live_grep_motion
