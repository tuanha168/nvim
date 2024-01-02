return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  configurations = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      restart = true,
    },
    {
      type = "pwa-node",
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
