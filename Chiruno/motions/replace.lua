function Chiruno.motions.replace_motion(mode)
  local textSelection = Chiruno.func.get_text_selection()
  if not textSelection then return end

  local text, selection = textSelection.text, textSelection.selection
  if text == nil then return end
  if mode == "line" and selection.finishRow - selection.startRow ~= 0 then return end

  vim.ui.input({ prompt = "Enter replacement: ", default = text }, function(replaceWord)
    if replaceWord == nil or replaceWord == "" or replaceWord == text then return end
    if vim.api.nvim_get_mode().mode ~= "v" then
      vim.api.nvim_cmd({ cmd = "normal", bang = true, args = { "v" } }, {})
    end

    vim.api.nvim_win_set_cursor(0, { selection.startRow, selection.startCol })
    vim.cmd "norm! o"
    vim.api.nvim_win_set_cursor(0, { selection.finishRow, selection.finishCol })
    Chiruno.func.feedkeys('"ayh/<c-r>a<CR>cgn' .. replaceWord .. "<ESC>", "n")
  end)

  ----------------- VimGrep ----------------
  -- vim.cmd("vimgrep /" .. cword .. "/g **/*")
  -- vim.cmd "copen"
  -- vim.schedule(function()
  --   vim.cmd("cdo %s/" .. cword .. "/" .. replaceWord .. "/gce")
  --   vim.cmd "cclose"
  -- end)

  ---------------- Telescope ----------------
  -- require('telescope.builtin').grep_string { search = cword }
  -- Chiruno.set_quickfix_items(
  --   1,
  --   "utils/motions/replace.lua|20 col 21| ----------------- VimGrep ----------------",
  --   "test"
  -- )
  -- vim.schedule(function() Chiruno.open_quickfix "test" end)
end

return Chiruno.motions.replace_motion
