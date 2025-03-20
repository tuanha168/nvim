local mappings = {
  n = {
    ["<Leader>l"] = {
      function() vim.diagnostic.open_float() end,
      desc = "Hover diagnostics",
    },
    ["<Leader>fm"] = {
      function()
        local ok, conform = pcall(require, "conform")
        if ok then
          conform.format({}, function(err, did_edit)
            if err and not did_edit then vim.lsp.buf.format() end
          end)
          return
        end

        vim.lsp.buf.format()
      end,
      desc = "Format code",
    },
    ["<Leader>E"] = { function() vim.lsp.codelens.run() end, desc = "Run code lens" },
    ["<Leader>k"] = {
      function() vim.lsp.buf.hover() end,
      desc = "Hover symbol details",
    },
  },
  i = {
    ["<C-z>i"] = {
      vim.lsp.buf.signature_help,
      desc = "Signature help",
    },
  },
  v = {
    ["<Leader>fm"] = {
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
    },
  },
}

return {
  setup = function(bufnr)
    for mode, keymaps in pairs(mappings) do
      for lhs, value in pairs(keymaps) do
        if not value then goto continue end
        local rhs, args = value[1], unpack(value, 2)
        vim.keymap.set(mode, lhs, rhs, { args and unpack(args), buffer = bufnr })
        ::continue::
      end
    end
  end,
}
