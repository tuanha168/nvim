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
      type = "pwa-chrome",
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
  },
}
