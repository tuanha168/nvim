local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/neovim/nvim-lspconfig",
  "BufRead",
  function()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          diagnostics = { globals = { "vim", "MiniIcons" } },
          telemetry = { enable = false },
        },
      },
    }

    lspconfig.pyright.setup {}
    lspconfig.rust_analyzer.setup {}
    lspconfig.ts_ls.setup {}
    lspconfig.volar.setup {}
    lspconfig.intelephense.setup {}
  end
)
