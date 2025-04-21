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
