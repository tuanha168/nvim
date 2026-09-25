---@type vim.SystemObj
-- local dbUiSshConnection

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "sqmeow.nvim" and (ev.data.kind == "install" or ev.data.kind == "update") then
      require("sqmeow").install {
        query = {
          max_rows = 100,
          timeout_ms = 5000, -- 0 disables timeout
          history_size = 32, -- results kept in memory
          persist_history = true, -- save log and results to disk
          history_limit = 500,
          confirm_destructive = true, -- ask before destructive statements
        },
      }
    end
  end,
})

vim.pack.add {
  "https://github.com/MunifTanjim/nui.nvim",
  { src = "https://github.com/2giosangmitom/sqmeow.nvim", version = vim.version.range "*" },
}

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
  vim.cmd "Sqmeow toggle"
end, { desc = "Toggle database UI" })
