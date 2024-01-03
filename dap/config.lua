return {
  setup = function(dap)
    dap.configurations = {
      javascript = jsOrTs,
      typescript = jsOrTs,
      javascriptreact = chrome_debugger,
      vue = chrome_debugger,
      go = go,
    }
  end,
}
