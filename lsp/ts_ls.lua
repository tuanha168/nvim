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

local home = os.getenv "HOME"

---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  -- Enable tsgo LSP
  cmd = { home .. "/typescript-go/built/local/tsgo", "--lsp", "--stdio" },

  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
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
}
