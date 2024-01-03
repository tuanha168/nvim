local js_debuggers = {
  {
    type = "js",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**" },
    restart = true,
  },
  {
    type = "js",
    request = "attach",
    name = "Attach",
    processId = require("dap.utils").pick_process,
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**" },
    restart = true,
  },
  {
    type = "js",
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
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**", "**/**/*.js" },
    protocol = "inspector",
    sourceMaps = true,
    userDataDir = false,
  },
  {
    type = "js",
    request = "attach",
    name = "Attach Program (port 9229)",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    restart = true,
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**" },
    port = 9229,
  },
  {
    type = "js",
    request = "attach",
    name = "Attach Program From Docker (port 9229)",
    cwd = "${workspaceFolder}",
    sourceMaps = true,
    restart = true,
    skipFiles = { "<node_internals>/**", "!**/node_modules/**", "**/$KNOWN_TOOLS$/**" },
    port = 9229,
    localRoot = "${workspaceFolder}",
    remoteRoot = "/var/www",
  },
}

return {
  setup = function(dap)
    dap.configurations = {
      javascript = js_debuggers,
      typescript = js_debuggers,
      javascriptreact = js_debuggers,
      typescriptreact = js_debuggers,
      vue = js_debuggers,
    }
  end,
}
