function Chiruno.live_grep_motion()
  local text = Chiruno.get_text_selection().text
  require("telescope.builtin").live_grep {
    -- search = Chiruno.get_text_selection().text,
    hidden = true,
  }
  vim.api.nvim_feedkeys(text .. "<ESC>", "i", false)
end

return Chiruno.live_grep_motion
