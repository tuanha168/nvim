return {
  ---@param bufnr integer
  setup = function(bufnr)
    if not bufnr then return end

    require("which-key").add {
      {
        "<Leader>l",
        function() vim.diagnostic.open_float() end,
        desc = "Hover diagnostics",
        bufnr = bufnr,
      },

      {
        "<Leader>fm",
        function()
          local ok, conform = pcall(require, "conform")
          if ok and not vim.b[bufnr].haveEslint then
            conform.format({}, function(err, did_edit)
              if err and not did_edit then Chiruno.func.format_lsp() end
            end)
            return
          end

          Chiruno.func.format_lsp()
        end,
        desc = "Format code",
        bufnr = bufnr,
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
        bufnr = bufnr,
      },

      { "<Leader>E", function() vim.lsp.codelens.run() end, desc = "Run code lens", bufnr = bufnr },

      {
        "<Leader>k",
        function() vim.lsp.buf.hover { border = "rounded" } end,
        desc = "Hover symbol details",
        bufnr = bufnr,
      },

      {
        "gR",
        function() vim.lsp.buf.rename() end,
        desc = "Rename current symbol",
        bufnr = bufnr,
      },

      {
        "<C-z>i",
        vim.lsp.buf.signature_help,
        desc = "Signature help",
        mode = { "i" },
        bufnr = bufnr,
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
        bufnr = bufnr,
      },
    }
  end,
}
