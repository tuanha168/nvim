---@type vim.SystemObj
-- local dbUiSshConnection

vim.pack.add {
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/pbogut/vim-dadbod-ssh",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
}

vim.g.db_ui_use_nerd_fonts = 1

-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   pattern = "*",
--   callback = function()
--     if dbUiSshConnection then dbUiSshConnection:kill(9) end
--   end,
-- })

vim.keymap.set("n", "<leader>cdb", function()
  -- if not dbUiSshConnection then
  --   -- ssh -L 7000:localhost:3306 -N yopaz-dev
  --   local obj = vim.system({ "ssh", "-L", "7000:localhost:3306", "-N", "test-ec2" }, { text = true })
  --   dbUiSshConnection = obj
  -- end
  vim.cmd.DBUIToggle()
end, { desc = "DBUIToggle" })
