return {
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  configurations = {
    -- {
    --   type = "node2",
    --   name = "Debug NestJS",
    --   request = "launch",
    --   runtimeExecutable = "yarn",
    --   args = { "dev:debug" },
    --   outputCapture = "std",
    --   port = 9229,
    --   restart = true,
    --   console = "integratedTerminal",
    --   internalConsoleOptions = "neverOpen",
    -- },
    {
      type = "node2",
      request = "attach",
      name = "Attach Program (port 9229)",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      restart = true,
      skipFiles = { "<node_internals>/**" },
      port = 9229,
      localRoot = "${workspaceFolder}",
      remoteRoot = "/var/www",
    },
  },
}
