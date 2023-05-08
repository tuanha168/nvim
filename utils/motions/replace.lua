Chiruno.replace_motion = function(mode)
  local cword, selection = Chiruno.get_text_selection().text, Chiruno.get_text_selection().selection
  if cword == nil then return end
  if mode == "line" and selection.finishRow - selection.startRow ~= 0 then return end

  local replaceWord = vim.fn.input { prompt = "Enter replacement: ", default = cword }
  if replaceWord == "" or replaceWord == cword then return end

  if vim.api.nvim_get_mode().mode ~= "v" then vim.api.nvim_cmd({ cmd = "normal", bang = true, args = { "v" } }, {}) end

  vim.api.nvim_win_set_cursor(0, { selection.startRow, selection.startCol })
  vim.cmd "norm! o"
  vim.api.nvim_win_set_cursor(0, { selection.finishRow, selection.finishCol })
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes('"ayh/<c-r>a<CR>cgn' .. replaceWord .. "<ESC>", true, true, true),
    "n",
    false
  )

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
