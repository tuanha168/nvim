local lazy = require("pack.lazy-load")

lazy.on_event(
  "https://github.com/mfussenegger/nvim-lint",
  "BufRead",
  function()
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
  end
)
