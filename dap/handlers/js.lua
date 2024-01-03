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
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      restart = true,
    },
    {
      type = "chrome",
      request = "launch",
      name = "Launch & Debug Chrome",
      url = function()
        local co = coroutine.running()
        return coroutine.create(function()
          vim.ui.input({ prompt = "URL: ", default = "http://localhost:3000" }, function(url)
            if url == nil or url == "" then return end

            coroutine.resume(co, url)
          end)
        end)
      end,
      port = 9222,
      webRoot = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**" },
      protocol = "inspector",
      sourceMaps = true,
      userDataDir = false,
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Program (port 9229)",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      restart = true,
      skipFiles = { "<node_internals>/**" },
      port = 9229,
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Program From Docker (port 9229)",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      restart = true,
      skipFiles = { "<node_internals>/**" },
      port = 9229,
      localRoot = "${workspaceFolder}",
      remoteRoot = "/var/www",
    },
  },
}
