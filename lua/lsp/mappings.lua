return {
  n = {
    ["<Leader>ld"] = false,
    ["<Leader>li"] = false,
    ["<Leader>lI"] = false,
    ["<Leader>lf"] = false,
    ["<Leader>la"] = false,
    ["<Leader>ll"] = false,
    ["<Leader>lL"] = false,
    ["<Leader>lr"] = false,
    ["<Leader>lR"] = false,
    ["<Leader>lh"] = false,
    ["<Leader>lG"] = false,
    ["<Leader>lD"] = false,
    ["<Leader>lS"] = false,
    ["K"] = false,
    ["gT"] = false,
    ["gd"] = false,
    ["gr"] = false,
    ["<Leader>l"] = {
      function() vim.diagnostic.open_float() end,
      desc = "Hover diagnostics",
    },
    ["<Leader>fm"] = {
      -- function() Chiruno.func.operatorfunc_lua "format_motion" end,
      function()
        local ok, conform = pcall(require, "conform")
        local lint_ok, lint = pcall(require, "lint")
        if ok then
          conform.format({}, function(err, did_edit)
            if err and not did_edit then
              vim.lsp.buf.format(require("astrolsp").format_opts --[[@as vim.lsp.buf.format.Opts?]])
            end

            if lint_ok then lint.try_lint() end
          end)
          return
        end

        vim.lsp.buf.format(require("astrolsp").format_opts --[[@as vim.lsp.buf.format.Opts?]])
      end,
      -- "<cmd>Prettier<CR>",
      desc = "Format code",
    },
    ["<Leader>E"] = { function() vim.lsp.codelens.run() end, desc = "Run code lens" },
    -- ["<Leader>K"] = {
    --   function() vim.lsp.buf.signature_help() end,
    --   desc = "Signature help",
    -- },
    ["<Leader>k"] = {
      function() vim.lsp.buf.hover() end,
      desc = "Hover symbol details",
    },
    ["gR"] = {
      function() vim.lsp.buf.rename() end,
      desc = "Rename current symbol",
    },
    -- ../plugins/lsp_plugin.lua:20
    -- ["gd"] = {
    --   function() vim.lsp.buf.definition() end,
    --   desc = "Show the definition of current symbol",
    -- },
  },
  i = {
    ["<C-z>i"] = {
      vim.lsp.buf.signature_help,
      desc = "Signature help",
    },
  },
  v = {
    ["<Leader>la"] = false,
    ["<Leader>fm"] = {
      function() Chiruno.func.operatorfunc_lua "format_motion" end,
      -- "<cmd>Prettier<CR>",
      desc = "Format code",
    },
  },
}
