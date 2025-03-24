---@type LazySpec
return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        -- js = { "eslint" },
        -- typescript = { "eslint" },
        -- vue = { "eslint" },
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
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "eslint", "prettierd", "prettier", stop_after_first = true },
        typescript = { "eslint", "prettierd", "prettier", stop_after_first = true },
        vue = { "eslint", "prettierd", "prettier", stop_after_first = true },
        html = { "prettier", stop_after_first = true },
        json = { "jsonls", "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
