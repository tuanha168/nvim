local M = {}

M.setup = function()
  local saga = require "lspsaga"
  saga.setup {
    outline = {
      win_position = "right",
      win_with = "",
      win_width = 30,
      show_detail = true,
      auto_preview = true,
      auto_refresh = true,
      auto_close = true,
      custom_sort = nil,
      keys = {
        jump = "o",
        expand_collapse = "u",
        quit = "q",
      },
    },
  }
end

M.setKeymap = function(bufnr, opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>k", "<Cmd>Lspsaga hover_doc<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>Lspsaga code_action<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", "<cmd>Lspsaga rename<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
end

return M
