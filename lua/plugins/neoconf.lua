---@type LazySpec
return {
  {
    "folke/neoconf.nvim",
    build = "luarocks install json.lua",
    opts = {
      plugin = {
        lspconfig = {
          ---@type lspconfig.options.volar
          volar = {
            settings = {
              vue = {
                server = {
                  hybridMode = false,
                },
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
          },
        },
      },
      lua_ls = {
        enabled = true,
      },
    },
  },
}
