---@type LazySpec
return {
  {
    "mfussenegger/nvim-lint",
    event = "BufRead",
    config = function()
      require("lint").linters_by_ft = {
        -- js = { "eslint_d" },
        -- typescript = { "eslint_d" },
        -- vue = { "eslint_d" },
      }

      vim.api.nvim_create_autocmd({ "LspAttach", "InsertLeave", "TextChanged" }, {
        callback = function(args)
          local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
          local client = get_clients({ bufnr = args.buf })[1] or {}
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
        json = { "prettier_json" },
      },
      formatters = {
        prettier_json = {
          command = "prettier",
          args = {
            "--stdin-filepath",
            "$FILENAME",
            "--parser",
            "json",
          },
          stdin = true,
        },
      },
    },
  },
}
