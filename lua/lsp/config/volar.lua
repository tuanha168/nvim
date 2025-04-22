local util = require "lspconfig.util"
local home = os.getenv "HOME"

---@type lspconfig.options.volar
return {
  root_dir = util.root_pattern("tsconfig.json", "tsconfig.ts", "tsconfig.js", "package.json"),
  filetypes = {
    "vue",
  },
  init_options = { vue = { hybridMode = vim.g.vue_takeover_mode } },
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
    css = {
      customData = {
        home .. "/.config/nvim/.vscode/tailwind.json",
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
  },
}
