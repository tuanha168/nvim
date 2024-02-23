local haveJson, json = pcall(require, "json")
if not haveJson then return end

local home = os.getenv "HOME"
local file = io.open(home .. "/.config/nvim/lua/user/neoconf.json", "w")
if not file then return end

local config = {
  lspconfig = {
    volar = {
      takeOverMode = {
        extension = "Vue.volar",
      },
      vue = {
        inlayHints = {
          missingProps = "true",
          inlineHandlerLeading = "true",
          optionsWrapper = "true",
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
          functionLikeReturnTypes = { enabled = "true" },
          propertyDeclarationTypes = { enabled = "true" },
          parameterNames = {
            enabled = "all",
            suppressWhenArgumentMatchesName = "true",
          },
          variableTypes = {
            enabled = "true",
            suppressWhenTypeMatchesName = "true",
          },
          parameterTypes = { enabled = "true" },
        },
      },
      css = { customData = {
        home .. "/.config/nvim/lua/user/.vscode/tailwind.json",
      } },
      javascript = {
        inlayHints = {
          enumMemberValues = { enabled = "true" },
          functionLikeReturnTypes = { enabled = "true" },
          propertyDeclarationTypes = { enabled = "true" },
          parameterNames = {
            enabled = "all",
            suppressWhenArgumentMatchesName = "true",
          },
          variableTypes = {
            enabled = "true",
            suppressWhenTypeMatchesName = "true",
          },
          parameterTypes = { enabled = "true" },
        },
      },
    },
    tailwindcss = {
      tailwindCSS = {
        classAttributes = {
          "class",
          "className",
          "ngClass",
          ".*[cC]lass.*",
          ".*[cC]lasses.*",
        },
        experimental = {
          classRegex = {
            "[a-zA-Z]*[cC]lass\\s*=\\s*'([^']*)'",
            '[a-zA-Z]*[cC]lass\\s*=\\s*"([^"]*)"',
            "[a-zA-Z]*[cC]lass\\s*=\\s*\\{(['`\"][^\\{\\}'`\"]*['`\"])*\\}",
          },
        },
        emmetCompletions = "true",
      },
    },
    intelephense = {
      intelephense = {
        diagnostics = {
          undefinedFunctions = "false",
          undefinedConstants = "false",
          undefinedClassConstants = "false",
          undefinedMethods = "false",
          undefinedProperties = "false",
          undefinedVariables = "false",
          undefinedTypes = "false",
        },
      },
    },
    rust_analyzer = {
      ["rust-analyzer"] = {
        lens = {
          enable = "true",
        },
        checkOnSave = {
          command = "clippy",
          enable = "true",
        },
      },
    },
    tsserver = {
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
          functionLikeReturnTypes = { enabled = "true" },
          propertyDeclarationTypes = { enabled = "true" },
          parameterNames = {
            enabled = "all",
            suppressWhenArgumentMatchesName = "true",
          },
          variableTypes = {
            enabled = "true",
            suppressWhenTypeMatchesName = "true",
          },
          parameterTypes = { enabled = "true" },
        },
      },
      javascript = {
        inlayHints = {
          enumMemberValues = { enabled = "true" },
          functionLikeReturnTypes = { enabled = "true" },
          propertyDeclarationTypes = { enabled = "true" },
          parameterNames = {
            enabled = "all",
            suppressWhenArgumentMatchesName = "true",
          },
          variableTypes = {
            enabled = "true",
            suppressWhenTypeMatchesName = "true",
          },
          parameterTypes = { enabled = "true" },
        },
      },
    },
    cssls = {
      less = {
        validate = "false",
      },
      css = {
        validate = "false",
      },
      scss = {
        validate = "false",
      },
    },
  },
}

file:write(json.encode(config))

file:close()
