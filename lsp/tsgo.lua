local inlayHints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayEnumMemberValueHints = true,
  -- includeInlayVariableTypeHints = true,
  -- includeInlayFunctionLikeReturnTypeHints = true,

  importModuleSpecifierPreference = "non-relative",
}

-- local home = os.getenv "HOME"

---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
  compilerOptions = {
    noErrorTruncate = true,
  },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
        languages = { "vue" },
      },
    },
  },
  settings = {
    typescript = {
      tsserver = {
        web = {
          projectWideIntellisense = {
            enabled = true,
          },
        },
      },
      inlayHints = inlayHints,
    },
    javascript = {
      inlayHints = inlayHints,
    },
  },
  on_init = function(_client)
    local old_on_attach = _client.on_attach
    _client.on_attach = function(client, buf)
      -- disable this server (tsgo) if vtsls is active
      for _, active_client in pairs(vim.lsp.get_clients { bufnr = buf }) do
        if active_client.name == "vtsls" then
          vim.schedule(function()
            vim.lsp.buf_detach_client(buf, client.id)
            vim.lsp.stop_client(client.id, true)
          end)
          return
        end
      end

      old_on_attach(client, buf)
    end
  end,
}
