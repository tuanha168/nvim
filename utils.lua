M = {}

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

M.op_func_formatting = function(test)
  print(test)
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

  local selection = { startText }
  if #currentLine > 2 then vim.list_extend(selection, vim.list_slice(currentLine, 2, #currentLine - 1)) end
  table.insert(selection, endText)

  require("telescope.builtin").grep_string { search = table.concat(selection, "\n") }
end

return M
