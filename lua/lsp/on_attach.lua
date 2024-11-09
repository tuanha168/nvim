return function(client, bufnr)
  if client.server_capabilities.workspace then
    client.server_capabilities.workspace.didChangeWatchedFiles = client.server_capabilities.workspace.didChangeWatchedFiles
      or {}
    client.server_capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }
  end
  if client.name == "eslint" then
    client.server_capabilities = client.server_capabilities or {}
    client.server_capabilities.documentFormattingProvider = true
    client.config.capabilities = client.config.capabilities or {}
    client.config.capabilities.documentFormattingProvider = true
    require("null-ls").disable { "prettierd" }
  end

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(event)
      if vim.lsp.get_clients({ bufnr = event.buf, name = "eslint" })[1] then
        require("null-ls").disable { "prettierd" }
      else
        require("null-ls").enable { "prettierd" }
      end
    end,
  })

  -- if client.name == "rust_analyzer" then
  --   local rt = require "rust-tools"
  --   vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
  -- end
end
