function Chiruno.func.setup_diff()
  local function apply_diff_changes(mode)
    -- Validate the current buffer is a diff buffer
    local filetype = vim.bo.filetype
    if filetype ~= "diff" then
      print "This function can only be used in a diff buffer!"
      return
    end

    -- Get cursor position (line number in the diff buffer)
    local diff_buf = vim.api.nvim_get_current_buf() -- Current buffer ID
    local diff_cursor_line = vim.api.nvim_win_get_cursor(0)[1] -- Cursor position line

    -- Read lines from the diff buffer
    local lines = vim.api.nvim_buf_get_lines(diff_buf, diff_cursor_line - 1, diff_cursor_line + 1, false)
    if #lines < 2 then
      print "Not inside a proper diff block!"
      return
    end

    -- Parse diff lines
    local old_text = string.match(lines[1], "^%- (.+)$") -- Extract '- old'
    local new_text = string.match(lines[2], "^%+ (.+)$") -- Extract '+ new'

    if not old_text or not new_text then
      print "Failed to parse diff block!"
      return
    end

    -- Retrieve the Lua file buffer (assume the previous buffer is the target)
    local lua_buf = vim.fn.bufnr "#" -- Get buffer number of the alternate (previous) buffer

    if not vim.api.nvim_buf_is_valid(lua_buf) then
      print "Lua file buffer not found!"
      return
    end

    -- Read all lines from the Lua buffer
    local lua_lines = vim.api.nvim_buf_get_lines(lua_buf, 0, -1, true)

    -- Generate modified Lua lines based on the mode
    local modified_lines = vim.tbl_map(function(line)
      if mode == "ci" then -- Apply "old" only
        return line:gsub(old_text, old_text)
      elseif mode == "ca" then -- Apply "new" only
        return line:gsub(old_text, new_text)
      elseif mode == "<CR>" then -- Apply both (replace old with new)
        return line:gsub(old_text, new_text)
      end
      return line
    end, lua_lines)

    -- Write modified lines back to the Lua buffer
    vim.api.nvim_buf_set_lines(lua_buf, 0, -1, true, modified_lines)

    print "Applied diff block changes!"
  end

  -- Function to set local key bindings only for diff buffers
  local function set_diff_keymaps()
    -- Validate that the current buffer is of type 'diff'
    local filetype = vim.bo.filetype
    if filetype == "diff" then
      vim.api.nvim_buf_set_keymap(0, "n", "ci", ':lua apply_diff_changes("ci")<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, "n", "ca", ':lua apply_diff_changes("ca")<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "<CR>",
        ':lua apply_diff_changes("<CR>")<CR>',
        { noremap = true, silent = true }
      )
      print "Keymaps set for diff buffer!"
    end
  end

  -- Automatically set keymaps when entering a diff buffer
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "diff",
    callback = set_diff_keymaps,
  })
end

return Chiruno.func.setup_diff()
