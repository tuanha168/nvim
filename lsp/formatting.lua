-- customize lsp formatting options
return {
  -- control auto formatting on save
  format_on_save = {
    enabled = true, -- enable or disable format on save globally
    -- allow_filetypes = { -- enable format on save for specified filetypes only
    --   "typescript",
    --   "javascript",
    --   "typescriptreact",
    --   "javascriptreact",
    --   "vue",
    --   "tsx",
    --   "jsx",
    -- },
    ignore_filetypes = { -- disable format on save for specified filetypes
      "php",
      "minifiles",
    },
  },
  disabled = { -- disable formatting capabilities for the listed language servers
    "lua_ls",
    "jsonls",
    "intelephense",
    "eslint",
    "volar",
    "tailwindcss",
  },
  timeout_ms = 1000, -- default format timeout
  -- filter = function(client) -- fully override the default formatting function
  --   return true
  -- end
}
