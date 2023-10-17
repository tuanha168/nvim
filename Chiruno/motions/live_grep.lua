function Chiruno.live_grep_motion()
  local search = vim.api.nvim_replace_termcodes(Chiruno.get_text_selection().text, true, false, true)
  require("telescope.builtin").grep_string {
    search = search,
    hidden = true,
  }
  vim.api.nvim_feedkeys("<ESC>", "i", false)
end

return Chiruno.live_grep_motion
