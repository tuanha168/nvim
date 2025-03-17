local M = {}
local api = vim.api

---@param expr nil|string|fun():string
---@return string
local function dap_eval_expression(expr)
  local mode = api.nvim_get_mode()
  if mode.mode == "v" then
    -- [bufnum, lnum, col, off]; 1-indexed
    local start = vim.fn.getpos "v"
    local end_ = vim.fn.getpos "."

    local start_row = start[2]
    local start_col = start[3]

    local end_row = end_[2]
    local end_col = end_[3]

    if start_row == end_row and end_col < start_col then
      end_col, start_col = start_col, end_col
    elseif end_row < start_row then
      start_row, end_row = end_row, start_row
      start_col, end_col = end_col, start_col
    end

    api.nvim_feedkeys(api.nvim_replace_termcodes("<ESC>", true, false, true), "n", false)

    -- buf_get_text is 0-indexed; end-col is exclusive
    local lines = api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
    return table.concat(lines, "\n")
  end
  expr = expr or "<cexpr>"
  if type(expr) == "function" then
    return expr()
  else
    return vim.fn.expand(expr)
  end
end

function M.Dap_better_hover(expr)
  local value = dap_eval_expression(expr)

  local bufnr, winid = vim.lsp.util.open_floating_preview({}, "dap-float", {
    focusable = true,
    close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
    focus_id = "dappp",
    focus = true,
    width = 100,
    height = 5,
  })

  local buffer_lines = vim.api.nvim_buf_get_lines(bufnr, 1, 999, false)
  if #buffer_lines ~= 0 then
    -- If buffer already existed, then we just jumped into it and can return early to avoid creating duplicated content.
    return
  end

  -- Buffer options
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].filetype = "dap-float"
  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].buftype = "nofile"
  vim.api.nvim_buf_set_name(bufnr, "dap-hover-" .. tostring(bufnr) .. ": " .. value)

  -- Window options
  vim.wo[winid].scrolloff = 0

  -- Key mappings for the buffer
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<CR>",
    "<Cmd>lua require('dap.ui').trigger_actions({ mode = 'first' })<CR>",
    {}
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "a", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "o", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<2-LeftMouse>", "<Cmd>lua require('dap.ui').trigger_actions()<CR>", {})

  local view = require("dap.ui.widgets")
    .builder(require("dap.ui.widgets").expression)
    .new_buf(function() return bufnr end)
    .new_win(require("dap.ui.widgets").with_resize(function() return winid end))
    .build()
  view.open(value)
  return view
end

return M
