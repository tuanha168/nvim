return {
  setup = function(dap)
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = vim.fn.exepath "js-debug-adapter",
        args = { "${port}" },
      },
    }

    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = vim.fn.exepath "js-debug-adapter",
        args = { "${port}" },
      },
    }
  end,
}
