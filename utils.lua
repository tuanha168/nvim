M = {}

M.quote_textobj = require("user.q_textobject").quote_textobj

M.buf_vtext = function()
  local a_orig = vim.fn.getreg "a"
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" then vim.cmd [[normal! gv]] end
  vim.cmd [[normal! "aygv]]
  local text = vim.fn.getreg "a"
  vim.fn.setreg("a", a_orig)
  return text
end

M.table_print = function(tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs(tt) do
      table.insert(sb, string.rep(" ", indent)) -- indent it
      if type(value) == "table" and not done[value] then
        done[value] = true
        table.insert(sb, key .. " = {\n")
        table.insert(sb, M.table_print(value, indent + 2, done))
        table.insert(sb, string.rep(" ", indent)) -- indent it
        table.insert(sb, "}\n")
      elseif "number" == type(key) then
        table.insert(sb, string.format('"%s"\n', tostring(value)))
      else
        table.insert(sb, string.format('%s = "%s"\n', tostring(key), tostring(value)))
      end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

M.to_string = function(tbl)
  if "nil" == type(tbl) then
    return tostring(nil)
  elseif "table" == type(tbl) then
    return M.table_print(tbl)
  elseif "string" == type(tbl) then
    return tbl
  else
    return tostring(tbl)
  end
end

M.print = function(tbl) vim.notify(M.to_string(tbl), vim.log.levels.WARN) end

M.operatorfunc_lua = function(function_name)
  if function_name == nil then return end
  vim.go.operatorfunc = "v:lua.require'user.utils'." .. function_name
  vim.api.nvim_feedkeys("g@", "n", false)
end

M.get_selection = function()
  local startRow, startCol = unpack(vim.api.nvim_buf_get_mark(0, "["))
  local finishRow, finishCol = unpack(vim.api.nvim_buf_get_mark(0, "]"))
  local currentLine = vim.api.nvim_buf_get_lines(0, startRow - 1, finishRow, false)
  if #currentLine == 0 then return end
  local startText, endText
  if #currentLine == 1 then
    startText = string.sub(currentLine[1], startCol + 1, finishCol + 1)
  else
    startText = string.sub(currentLine[1], startCol + 1)
    endText = string.sub(currentLine[#currentLine], 1, finishCol + 1)
  end

  return {
    currentLine = currentLine,
    startRow = startRow,
    startCol = startCol,
    finishRow = finishRow,
    finishCol = finishCol,
    startText = startText,
    endText = endText,
  }
end

M.get_text_selection = function()
  local selection = M.get_selection()
  if selection == nil then return end

  local selectedText = { selection.startText }
  if #selection.currentLine > 2 then
    vim.list_extend(selectedText, vim.list_slice(selection.currentLine, 2, #selection.currentLine - 1))
  end
  table.insert(selectedText, selection.endText)
  return { text = table.concat(selectedText, "\n"), selection = selection }
end

M.live_grep_motion = function()
  require("telescope.builtin").grep_string { search = M.get_text_selection().text }
  vim.api.nvim_feedkeys("<ESC>", "i", false)
end

M.format_motion = function()
  local opts = require("astronvim.utils.lsp").format_opts
  local selection = M.get_selection()
  if selection ~= nil then
    opts.range = {
      ["start"] = { selection.startRow, selection.startCol },
      ["end"] = { selection.finishRow, selection.finishCol },
    }
  end

  vim.lsp.buf.format(opts)
end

M.replace_motion = function(mode)
  local cword, selection = M.get_text_selection().text, M.get_text_selection().selection
  if cword == nil then return end
  if mode == "line" and selection.finishRow - selection.startRow ~= 0 then return end

  local replaceWord = vim.fn.input { prompt = "Enter replacement: ", default = cword }
  if replaceWord == "" or replaceWord == cword then return end

  if vim.api.nvim_get_mode().mode ~= "v" then vim.api.nvim_cmd({ cmd = "normal", bang = true, args = { "v" } }, {}) end

  vim.api.nvim_win_set_cursor(0, { selection.startRow, selection.startCol })
  vim.cmd "norm! o"
  vim.api.nvim_win_set_cursor(0, { selection.finishRow, selection.finishCol })
  vim.api.nvim_feedkeys("*", "v", false)

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("cgn" .. replaceWord .. "<ESC>", true, true, true), "n", false)
end

return M
