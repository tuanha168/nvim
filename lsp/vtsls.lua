local inlayHints = {
  enumMemberValues = { enabled = "true" },
  propertyDeclarationTypes = { enabled = "true" },
  parameterNames = {
    enabled = "all",
    suppressWhenArgumentMatchesName = "true",
  },
  functionLikeReturnTypes = { enabled = "true" },
  -- variableTypes = {
  --   enabled = "true",
  --   suppressWhenTypeMatchesName = "true",
  -- },
  parameterTypes = { enabled = "true" },
}
local vue_language_server_path = vim.fn.expand "$MASON/packages"
  .. "/vue-language-server"
  .. "/node_modules/@vue/language-server"

---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  compilerOptions = {
    noErrorTruncate = true,
  },
  settings = {
    vtsls = {
      -- autoUseWorkspaceTsdk = true,
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
      experimental = { maxInlayHintLength = 20 },
    },
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
      local enabled = Chiruno.func.vueCheck(client, buf)

      if enabled == client.name then
        old_on_attach(client, buf)
      end
    end
  end,
}
