function Chiruno.motions.live_grep_motion(mode)
  local ok, telescope = pcall(require, "telescope")
  if ok then
    telescope.grep_string {
      search = Chiruno.func.get_text_selection(mode).text,
      hidden = true,
    }
    vim.schedule(function() Chiruno.func.feedkeys("<ESC>", "i") end)
  end
end

return Chiruno.motions.live_grep_motion
