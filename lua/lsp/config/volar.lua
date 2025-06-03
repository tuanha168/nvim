local util = require "lspconfig.util"
local home = os.getenv "HOME"

local filetypes = vim.g.vue_hybrid and {
  "vue",
} or {
  "javascript",
  "javascript.jsx",
  "javascriptreact",
  "typescript",
  "typescript.tsx",
  "typescriptreact",
  "vue",
}

---@type lspconfig.options.volar
return {
  enabled = false,
  root_dir = util.root_pattern(".git", "tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json"),
  filetypes = filetypes,
  init_options = { vue = { hybridMode = vim.g.vue_hybrid } },
  settings = {
    vue = {
      inlayHints = {
        missingProps = true,
        optionsWrapper = true,
        vBindShorthand = true,
        destructuredProps = true,
        inlineHandlerLeading = true,
      },
    },
    typescript = {
      tsserver = {
        web = {
          projectWideIntellisense = {
            enabled = "true",
          },
        },
      },
      inlayHints = {
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
      },
    },
    javascript = {
      inlayHints = {
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
      },
    },
    css = {
      customData = {
        home .. "/.config/nvim/.vscode/tailwind.json",
      },
    },
  },
}
