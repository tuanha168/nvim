function Chiruno.motions.live_grep_motion(mode)
  local ok, telescope = pcall(require, "telescope")
  if not ok then return end

  telescope.grep_string {
    search = Chiruno.func.get_text_selection(mode).text,
    hidden = true,
  }
  vim.schedule(function() Chiruno.func.feedkeys("<ESC>", "i") end)
end

return Chiruno.motions.live_grep_motion
