local haveJson, json = pcall(require, "json")
if not haveJson then return end

local home = os.getenv "HOME"
local file = io.open(home .. "/.config/nvim/neoconf.json", "w")
if not file then return end

local config = {
  neodev = {
    library = {
      enabled = true,
      plugins = true,
    },
  },
  neoconf = {
    plugins = {
      lua_ls = {
        enabled = true,
      },
    },
  },
  lspconfig = {
    volar = {
      vue = {
        inlayHints = false,
      },
      typescript = {
        ts_ls = {
          web = {
            projectWideIntellisense = {
              enabled = "true",
            },
          },
        },
        -- inlayHints = {
        --   enumMemberValues = { enabled = "true" },
        --   propertyDeclarationTypes = { enabled = "true" },
        --   parameterNames = {
        --     enabled = "all",
        --     suppressWhenArgumentMatchesName = "true",
        --   },
        --   -- functionLikeReturnTypes = { enabled = "true" },
        --   -- variableTypes = {
        --   --   enabled = "true",
        --   --   suppressWhenTypeMatchesName = "true",
        --   -- },
        --   parameterTypes = { enabled = "true" },
        -- },
      },
      css = {
        customData = {
          home .. "/.config/nvim/.vscode/tailwind.json",
        },
      },
      javascript = {
        -- inlayHints = {
        --   enumMemberValues = { enabled = "true" },
        --   propertyDeclarationTypes = { enabled = "true" },
        --   parameterNames = {
        --     enabled = "all",
        --     suppressWhenArgumentMatchesName = "true",
        --   },
        --   -- functionLikeReturnTypes = { enabled = "true" },
        --   -- variableTypes = {
        --   --   enabled = "true",
        --   --   suppressWhenTypeMatchesName = "true",
        --   -- },
        --   parameterTypes = { enabled = "true" },
        -- },
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
        format = { braces = "k&r" },
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
    cssls = {
      less = {
        validate = "true",
        lint = {
          unknownAtRules = "ignore",
        },
      },
      css = {
        validate = "true",
        lint = {
          unknownAtRules = "ignore",
        },
      },
      scss = {
        validate = "true",
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
    eslint = {
      eslint = {
        experimental = {
          -- allows to use flat config format
          useFlatConfig = true,
        },
      },
    },
  },
}

file:write(json.encode(config))

file:close()
