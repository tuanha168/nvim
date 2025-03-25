return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {},
      },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
        volar = require "lsp.config.volar",
        eslint = {},
        tailwindcss = {},
        jsonls = {},
        intelephense = {},
        yamlls = {},
        omnisharp = {},
      }

      require("mason-lspconfig").setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            server.capabilities = vim.tbl_deep_extend("force", {}, server.capabilities or {}, capabilities)
            server.on_attach = require "lsp.on_attach"
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        show_diagnostic_autocmds = { 'InsertLeave', 'TextChanged' },
      })
    end,
  },
}
