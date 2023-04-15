return function()
  local dap = require "dap"
  dap.set_log_level "TRACE"
  dap.configurations.typescript = {
    {
      type = "node2",
      request = "attach",
      name = "Attach Program (Node2 with ts-node)",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      port = 9229,
    },
    {
      type = "node2",
      name = "Debug NestJS",
      request = "launch",
      runtimeExecutable = "${workspaceFolder}/node_modules/.bin/nest",
      args = { "start", "--watch", "--debug" },
      outputCapture = "std",
      port = 9229,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end
