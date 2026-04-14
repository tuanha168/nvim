local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/stevearc/conform.nvim",
  "BufRead",
  function()
    require("conform").setup {
      log_level = vim.log.levels.DEBUG,
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua", "lua_ls" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        vue = { "prettier" },
        html = { "prettier" },
        php = { "pint" },
        json = { "prettier" },
      },
    }
  end
)
