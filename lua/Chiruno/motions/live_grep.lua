function Chiruno.motions.live_grep_motion(mode)
  local telescope_ok, telescope = pcall(require, "telescope")
  if telescope_ok then
    telescope.grep_string {
      search = Chiruno.func.get_text_selection(mode).text,
      hidden = true,
    }
    vim.schedule(function() Chiruno.func.feedkeys("<ESC>", "i") end)
    return
  end

  local fzf_ok, fzf = pcall(require, "fzf-lua")
  if fzf_ok then fzf.grep { search = Chiruno.func.get_text_selection(mode).text } end
end

return Chiruno.motions.live_grep_motion
