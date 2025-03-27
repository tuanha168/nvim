return {
  ---@param bufnr integer
  setup = function(bufnr)
    if not bufnr then return end

    require("legendary").keymaps {
      {
        "<Leader>l",
        function() vim.diagnostic.open_float() end,
        description = "Hover diagnostics",
        opts = { buffer = bufnr },
      },

      {
        "<Leader>fm",
        function()
          local ok, conform = pcall(require, "conform")
          if ok then
            conform.format({}, function(err, did_edit)
              Print({err = err, did_edit = did_edit})
              if err or not did_edit then vim.lsp.buf.format() end
            end)
            return
          end

          vim.lsp.buf.format()
        end,
        description = "Format code",
        opts = { buffer = bufnr },
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
        description = "LSP code action",
        opts = { buffer = bufnr },
      },

      { "<Leader>E", function() vim.lsp.codelens.run() end, description = "Run code lens", opts = { buffer = bufnr } },

      {
        "<Leader>k",
        function() vim.lsp.buf.hover() end,
        description = "Hover symbol details",
        opts = { buffer = bufnr },
      },

      {
        "gR",
        function() vim.lsp.buf.rename() end,
        description = "Rename current symbol",
        opts = { buffer = bufnr },
      },

      {
        "<C-z>i",
        vim.lsp.buf.signature_help,
        description = "Signature help",
        mode = { "i" },
        opts = { buffer = bufnr },
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
        description = "Format code",
        mode = { "v" },
        opts = { buffer = bufnr },
      },
    }
  end,
}
