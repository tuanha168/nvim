return {
  ---@param bufnr integer
  setup = function(bufnr)
    if not bufnr then return end

    require("which-key").add {
      {
        "<Leader>l",
        function() vim.diagnostic.open_float() end,
        desc = "Hover diagnostics",
        buffer = bufnr,
      },

      {
        "<Leader>fm",
        function()
          local ok, conform = pcall(require, "conform")
          if ok and not Chiruno.func.format_lsp() then
            conform.format()
            return
          end
        end,
        desc = "Format code",
        buffer = bufnr,
      },

      {
        "<Leader>ee",
        function()
          local ok, actPrew = pcall(require, "actions-preview")
          if ok then
            actPrew.code_actions()
          else
            vim.lsp.buf.code_action()
          end
        end,
        desc = "LSP code action",
        buffer = bufnr,
      },

      { "<Leader>E", function() vim.lsp.codelens.run() end, desc = "Run code lens", buffer = bufnr },

      {
        "<Leader>k",
        function() vim.lsp.buf.hover { border = "rounded" } end,
        desc = "Hover symbol details",
        buffer = bufnr,
      },

      {
        "gR",
        function() vim.lsp.buf.rename() end,
        desc = "Rename current symbol",
        buffer = bufnr,
      },

      {
        "<C-z>i",
        vim.lsp.buf.signature_help,
        desc = "Signature help",
        mode = { "i" },
        buffer = bufnr,
      },

      {
        "<Leader>fm",
        function()
          local ok, conform = pcall(require, "conform")
          if ok then
            conform.format({}, function(err, did_edit)
              if err and not did_edit then Chiruno.func.operatorfunc_lua "format_motion" end
            end)
            return
          end

          Chiruno.func.operatorfunc_lua "format_motion"
        end,
        -- "<cmd>Prettier<CR>",
        desc = "Format code",
        mode = { "v" },
        buffer = bufnr,
      },

      -- LLM inline completion
      {
        "<C-f>",
        function() vim.lsp.inline_completion.get() end,
        mode = { "i" },
        buffer = bufnr,
      },
      {
        "<C-j>",
        function()
          vim.lsp.inline_completion.select {
            bufnr = bufnr,
            count = 1,
          }
        end,
        mode = { "i" },
        buffer = bufnr,
      },
      {
        "<C-k>",
        function()
          vim.lsp.inline_completion.select {
            bufnr = bufnr,
            count = -1,
          }
        end,
        mode = { "i" },
        buffer = bufnr,
      },
    }
  end,
}
