function Chiruno.live_grep_motion(mode)
  -- require("telescope.builtin").grep_string {
  --   search = Chiruno.get_text_selection(mode).text,
  --   hidden = true,
  -- }
  -- vim.schedule(function() Chiruno.feedkeys("<ESC>", "i") end)

  local pattern_to_search = Chiruno.get_text_selection(mode).text
  -- Use strict pattern search.
  -- if Improved_search_operator_behaviour.strict then pattern_to_search = "\\<" .. pattern_to_search .. "\\>" end

  -- Set cursor to left part of selected text (for next search conviniece)
  local start_row, start_column = get_mark "["
  vim.api.nvim_win_set_cursor(0, { start_row, start_column })

  -- Set the selected text as a search text
  vim.fn.setreg("/", pattern_to_search)
  vim.opt.hlsearch = true
end

return Chiruno.live_grep_motion
