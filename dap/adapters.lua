return {
  setup = function(dap)
    dap.adapters["pwa-node"] = {
      type = "executable",
      command = "js-debug-adapter",
    }

    dap.adapters["pwa-chrome"] = {
      type = "server",
      command = "js-debug-adapter",
    }
  end,
}
