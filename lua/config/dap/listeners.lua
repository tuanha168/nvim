return {
  setup = function(dap)
    local ok, dv = pcall(require, "dap-view")
    if not ok then return end

    dap.listeners.before.attach["dap-view-config"] = function() dv.open() end
    dap.listeners.before.launch["dap-view-config"] = function()
      vim.keymap.set("n", "<leader>k", function() require("dap.ui.widgets").hover() end, { buffer = 0 })
      dv.open()
    end
    dap.listeners.before.event_terminated["dap-view-config"] = function()
      vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.hover() end, { buffer = 0 })
      dv.close()
    end
    dap.listeners.before.event_exited["dap-view-config"] = function() dv.close() end
  end,
}
