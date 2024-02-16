local json = require "neoconf.json"
local test = json.encode {
  ["lspconfig"] = {
    ["volar"] = {
      ["takeOverMode.extension"] = "Vue.volar",
      ["vue"] = {
        ["inlayHints"] = {
          ["missingProps"] = "true",
          ["inlineHandlerLeading"] = "true",
          ["optionsWrapper"] = "true",
        },
      },
      ["typescript"] = {
        ["tsserver"] = {
          ["web"] = {
            ["projectWideIntellisense"] = {
              ["enabled"] = "true",
            },
          },
        },
        ["inlayHints"] = {
          ["enumMemberValues.enabled"] = "true",
          ["functionLikeReturnTypes.enabled"] = "true",
          ["propertyDeclarationTypes.enabled"] = "true",
          ["parameterNames"] = {
            ["enabled"] = "all",
            ["suppressWhenArgumentMatchesName"] = "true",
          },
          ["variableTypes"] = {
            ["enabled"] = "true",
            ["suppressWhenTypeMatchesName"] = "true",
          },
          ["parameterTypes.enabled"] = "true",
        },
      },
      ["css.customData"] = {
        "/Users/tuanha/.config/nvim/lua/user/.vscode/tailwind.json",
      },
      ["javascript"] = {
        ["inlayHints"] = {
          ["enumMemberValues.enabled"] = "true",
          ["functionLikeReturnTypes.enabled"] = "true",
          ["propertyDeclarationTypes.enabled"] = "true",
          ["parameterNames"] = {
            ["enabled"] = "all",
            ["suppressWhenArgumentMatchesName"] = "true",
          },
          ["variableTypes"] = {
            ["enabled"] = "true",
            ["suppressWhenTypeMatchesName"] = "true",
          },
          ["parameterTypes.enabled"] = "true",
        },
      },
    },
    ["tailwindcss"] = {
      ["tailwindCSS.classAttributes"] = {
        "class",
        "className",
        "ngClass",
        ".*[cC]lass.*",
        ".*[cC]lasses.*",
      },
      ["tailwindCSS.experimental.classRegex"] = {
        "[a-zA-Z]*[cC]lass\\s*=\\s*'([^']*)'",
        '[a-zA-Z]*[cC]lass\\s*=\\s*"([^"]*)"',
        "[a-zA-Z]*[cC]lass\\s*=\\s*\\{(['`\"][^\\{\\}'`\"]*['`\"])*\\}",
      },
      ["tailwindCSS.emmetCompletions"] = "true",
    },
    ["intelephense"] = {
      ["intelephense"] = {
        ["diagnostics"] = {
          ["undefinedFunctions"] = "false",
          ["undefinedConstants"] = "false",
          ["undefinedClassConstants"] = "false",
          ["undefinedMethods"] = "false",
          ["undefinedProperties"] = "false",
          ["undefinedVariables"] = "false",
          ["undefinedTypes"] = "false",
        },
      },
    },
    ["rust_analyzer"] = {
      ["rust-analyzer"] = {
        ["lens"] = {
          ["enable"] = "true",
        },
        ["checkOnSave"] = {
          ["command"] = "clippy",
          ["enable"] = "true",
        },
      },
    },
    ["tsserver"] = {
      ["typescript"] = {
        ["tsserver"] = {
          ["web"] = {
            ["projectWideIntellisense"] = {
              ["enabled"] = "true",
            },
          },
        },
        ["inlayHints"] = {
          ["enumMemberValues.enabled"] = "true",
          ["functionLikeReturnTypes.enabled"] = "true",
          ["propertyDeclarationTypes.enabled"] = "true",
          ["parameterNames"] = {
            ["enabled"] = "all",
            ["suppressWhenArgumentMatchesName"] = "true",
          },
          ["variableTypes"] = {
            ["enabled"] = "true",
            ["suppressWhenTypeMatchesName"] = "true",
          },
          ["parameterTypes.enabled"] = "true",
        },
      },
      ["javascript"] = {
        ["inlayHints"] = {
          ["enumMemberValues.enabled"] = "true",
          ["functionLikeReturnTypes.enabled"] = "true",
          ["propertyDeclarationTypes.enabled"] = "true",
          ["parameterNames"] = {
            ["enabled"] = "all",
            ["suppressWhenArgumentMatchesName"] = "true",
          },
          ["variableTypes"] = {
            ["enabled"] = "true",
            ["suppressWhenTypeMatchesName"] = "true",
          },
          ["parameterTypes.enabled"] = "true",
        },
      },
    },
    ["cssls"] = {
      ["less"] = {
        ["validate"] = "false",
      },
      ["css"] = {
        ["validate"] = "false",
      },
      ["scss"] = {
        ["validate"] = "false",
      },
    },
  },
}
Chiruno.func.print(test)
-- Chiruno.func.print(json.decode([[
-- {
--   "lspconfig": {
--     "volar": {
--       "css.customData": ["/Users/tuanha/.config/nvim/lua/user/.vscode/tailwind.json"],
--       "takeOverMode.extension": "Vue.volar",
--       "javascript": {
--         "inlayHints": {
--           "parameterNames": {
--             "enabled": "all",
--             "suppressWhenArgumentMatchesName": true
--           },
--           "variableTypes": {
--             "enabled": true,
--             "suppressWhenTypeMatchesName": true
--           },
--           "parameterTypes.enabled": true,
--           "enumMemberValues.enabled": true,
--           "functionLikeReturnTypes.enabled": true,
--           "propertyDeclarationTypes.enabled": true
--         }
--       },
--       "typescript": {
--         "tsserver": {
--           "web": {
--             "projectWideIntellisense": {
--               "enabled": true
--             }
--           }
--         },
--         "inlayHints": {
--           "variableTypes": {
--             "enabled": true,
--             "suppressWhenTypeMatchesName": true
--           },
--           "parameterNames": {
--             "enabled": "all",
--             "suppressWhenArgumentMatchesName": true
--           },
--           "parameterTypes.enabled": true,
--           "enumMemberValues.enabled": true,
--           "functionLikeReturnTypes.enabled": true,
--           "propertyDeclarationTypes.enabled": true
--         }
--       },
--       "vue": {
--         "inlayHints": {
--           "missingProps": true,
--           "inlineHandlerLeading": true,
--           "optionsWrapper": true
--         }
--       }
--     },
--     "cssls": {
--       "css": { "validate": false },
--       "scss": { "validate": false },
--       "less": { "validate": false }
--     },
--     "intelephense": {
--       "intelephense": {
--         "diagnostics": {
--           "undefinedTypes": false,
--           "undefinedFunctions": false,
--           "undefinedConstants": false,
--           "undefinedClassConstants": false,
--           "undefinedMethods": false,
--           "undefinedProperties": false,
--           "undefinedVariables": false
--         }
--       }
--     },
--     "tsserver": {
--       "javascript": {
--         "inlayHints": {
--           "parameterNames": {
--             "enabled": "all",
--             "suppressWhenArgumentMatchesName": true
--           },
--           "variableTypes": {
--             "enabled": true,
--             "suppressWhenTypeMatchesName": true
--           },
--           "parameterTypes.enabled": true,
--           "enumMemberValues.enabled": true,
--           "functionLikeReturnTypes.enabled": true,
--           "propertyDeclarationTypes.enabled": true
--         }
--       },
--       "typescript": {
--         "tsserver": {
--           "web": {
--             "projectWideIntellisense": {
--               "enabled": true
--             }
--           }
--         },
--         "inlayHints": {
--           "variableTypes": {
--             "enabled": true,
--             "suppressWhenTypeMatchesName": true
--           },
--           "parameterNames": {
--             "enabled": "all",
--             "suppressWhenArgumentMatchesName": true
--           },
--           "parameterTypes.enabled": true,
--           "enumMemberValues.enabled": true,
--           "functionLikeReturnTypes.enabled": true,
--           "propertyDeclarationTypes.enabled": true
--         }
--       }
--     },
--     "rust_analyzer": {
--       "rust-analyzer": {
--         "lens": {
--           "enable": true
--         },
--         "checkOnSave": {
--           "enable": true,
--           "command": "clippy"
--         }
--       }
--     },
--     "tailwindcss": {
--       "tailwindCSS.experimental.classRegex": [
--         "[a-zA-Z]*[cC]lass\\s*=\\s*'([^']*)'",
--         "[a-zA-Z]*[cC]lass\\s*=\\s*\"([^\"]*)\"",
--         "[a-zA-Z]*[cC]lass\\s*=\\s*\\{(['`\"][^\\{\\}'`\"]*['`\"])*\\}"
--       ],
--       "tailwindCSS.classAttributes": [
--         "class",
--         "className",
--         "ngClass",
--         ".*[cC]lass.*",
--         ".*[cC]lasses.*"
--       ],
--       "tailwindCSS.emmetCompletions": true
--     }
--   }
-- }
-- ]]))
