---@type vim.SystemObj

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "sqmeow.nvim" and (ev.data.kind == "install" or ev.data.kind == "update") then
      require("sqmeow").install { callback = function() end }
    end
  end,
})

vim.pack.add {
  "https://github.com/MunifTanjim/nui.nvim",
  { src = "https://github.com/2giosangmitom/sqmeow.nvim", version = vim.version.range "*" },
}

require("sqmeow").setup {
  query = {
    max_rows = 100,
    timeout_ms = 5000, -- 0 disables timeout
    history_size = 32, -- results kept in memory
    persist_history = true, -- save log and results to disk
    history_limit = 500,
    confirm_destructive = true, -- ask before destructive statements
  },
}

vim.keymap.set("n", "<leader>cdb", function()
  vim.cmd "Sqmeow toggle"
end, { desc = "Toggle database UI" })
