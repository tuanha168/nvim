return {
  generate = function()
    local haveJson, json = pcall(require, "json")
    if not haveJson then
      print "Install json lib: luarocks install json.lua"
      return
    end

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
        tailwindcss = {
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
      },
    }

    file:write(json.encode(config))

    file:close()
  end,
}
