local volarPath = require("mason-registry").get_package("vue-language-server"):get_install_path()

local inlayHints = {
  enumMemberValues = { enabled = "true" },
  propertyDeclarationTypes = { enabled = "true" },
  parameterNames = {
    enabled = "all",
    suppressWhenArgumentMatchesName = "true",
  },
  -- functionLikeReturnTypes = { enabled = "true" },
  -- variableTypes = {
  --   enabled = "true",
  --   suppressWhenTypeMatchesName = "true",
  -- },
  parameterTypes = { enabled = "true" },
}

---@type lspconfig.options.vtsls
return {
  enabled = vim.g.vue_hybrid,
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
            location = volarPath .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
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
}
