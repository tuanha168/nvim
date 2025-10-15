---@type LazySpec
return {
  {
    "mfussenegger/nvim-lint",
    event = "BufRead",
    config = function()
      require("lint").linters_by_ft = {
        js = { "eslint_d" },
        typescript = { "eslint_d" },
        vue = { "eslint_d" },
      }

      vim.api.nvim_create_autocmd({ "LspAttach", "InsertLeave", "TextChanged" }, {
        callback = function()
          local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
          local client = get_clients({ bufnr = 0 })[1] or {}
          require("lint").try_lint(nil, { cwd = client.root_dir })
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufRead",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua", "lua_ls" },
        python = { "isort", "black" },
        rust = { "rustfmt" },
        javascript = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        vue = { "eslint_d", "prettier" },
        html = { "eslint_d", "prettier" },
        json = { "eslint_d", "prettier" },
        php = { "pint" },
      },
    },
  },
}
