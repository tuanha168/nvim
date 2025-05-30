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

    -- Read the current and adjacent lines from the diff buffer
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

    -- Switch to the Lua file buffer (assume the alternate buffer is the target)
    local lua_buf = vim.fn.bufnr "#" -- Get buffer number of the alternate (previous) buffer

    if not vim.api.nvim_buf_is_valid(lua_buf) then
      print "Lua file buffer not found or valid!"
      return
    end

    -- Retrieve all lines from Lua buffer
    local lua_lines = vim.api.nvim_buf_get_lines(lua_buf, 0, -1, true)
    local modified_lines = {} -- Stores the modified lines
    local modified_line_index = nil -- Stores the index of the line that was changed

    -- Process content based on mode
    for i, line in ipairs(lua_lines) do
      if line:find(old_text) then
        if mode == "ci" then
          table.insert(modified_lines, line:gsub(old_text, old_text)) -- Keep "old"
          modified_line_index = i
        elseif mode == "ca" then
          table.insert(modified_lines, line:gsub(old_text, new_text)) -- Replace with "new"
          modified_line_index = i
        elseif mode == "<CR>" then
          table.insert(modified_lines, line:gsub(old_text, new_text)) -- Replace old → new
          modified_line_index = i
        end
      else
        table.insert(modified_lines, line) -- No changes
      end
    end

    -- Replace lines in Lua buffer
    vim.api.nvim_buf_set_lines(lua_buf, 0, -1, true, modified_lines)

    -- Focus the changed line in the Lua buffer
    if modified_line_index then
      local lua_win = vim.fn.bufwinid(lua_buf) -- Get window ID for the Lua buffer
      if lua_win ~= -1 then
        vim.api.nvim_win_set_cursor(lua_win, { modified_line_index, 0 }) -- Move cursor to changed line
      end
    end

    print("Applied diff block changes (" .. mode .. ")!")
  end

  -- Function to set local key bindings only for diff buffers
  local function set_diff_keymaps()
    -- Validate that the current buffer is of type 'diff'
    local filetype = vim.bo.filetype
    if filetype == "diff" then
      vim.keymap.set("n", "ci", function() apply_diff_changes "ci" end, { noremap = true, silent = true, buffer = 0 })
      vim.keymap.set("n", "ca", function() apply_diff_changes "ca" end, { noremap = true, silent = true, buffer = 0 })
      vim.keymap.set(
        "n",
        "<CR>",
        function() apply_diff_changes "<CR>" end,
        { noremap = true, silent = true, buffer = 0 }
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
