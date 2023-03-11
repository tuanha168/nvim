return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    local ok, null_ls = pcall(require, "null-ls")
    if not ok then
      return
    end

    local formatting = null_ls.builtins.formatting
    config.sources = {
      formatting.prettier,
      -- formatting.prettier.with {
      --   extra_args = {
      --     -- "--no-semi",
      --     "--single-quote",
      --     "--jsx-single-quote",
      --     "--tab-width",
      --     "2",
      --     "--trailing-comma",
      --     "none",
      --     -- "--arrow-parens",
      --     -- "avoid",
      --   },
      -- },
      formatting.phpcsfixer,
      formatting.stylua,
      -- diagnostics.eslint_d,
      -- code_actions.eslint_d,
    }
    return config -- return final config table
  end,
}
