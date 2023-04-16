return {
  configurations = {
    {
      type = "node2",
      name = "Debug NestJS",
      request = "launch",
      runtimeExecutable = "yarn",
      args = { "dev:debug" },
      outputCapture = "std",
      port = 9229,
      restart = true,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "node2",
      request = "attach",
      name = "Attach Program (Node2 with ts-node)",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      restart = true,
      skipFiles = { "<node_internals>/**" },
      port = 9229,
    },
  },
}
