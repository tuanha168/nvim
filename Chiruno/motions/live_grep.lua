function Chiruno.live_grep_motion()
  local text = Chiruno.get_text_selection().escaped
  require("telescope.builtin").live_grep {
    -- search = Chiruno.get_text_selection().text,
    hidden = true,
  }
  vim.schedule(function() vim.api.nvim_feedkeys(text .. "<ESC>", "i", false) end)
end

return Chiruno.live_grep_motion
