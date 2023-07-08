return {
  n = {
    ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
    ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
    ["<leader>l"] = {
      function() vim.diagnostic.open_float() end,
      desc = "Hover diagnostics",
    },
    ["<leader>fm"] = {
      -- function() Chiruno.operatorfunc_lua "format_motion" end,
      function() vim.lsp.buf.format(require("lsp.formatting")) end,
      -- "<cmd>Prettier<CR>",
      desc = "Format code",
    },
    ["<leader>e"] = {
      function() vim.lsp.buf.code_action() end,
      desc = "LSP code action",
    },
    ["<leader>E"] = { function() vim.lsp.codelens.run() end, desc = "Run code lens" },
    ["<leader>K"] = {
      function() vim.lsp.buf.signature_help() end,
      desc = "Signature help",
    },
    ["<leader>k"] = {
      function() vim.lsp.buf.hover() end,
      desc = "Hover symbol details",
    },
    ["<leader>gl"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
    ["gt"] = {
      function() require("telescope.builtin").lsp_type_definitions() end,
      desc = "Definition of current type",
    },
    ["gR"] = {
      function() vim.lsp.buf.rename() end,
      desc = "Rename current symbol",
    },
    ["gd"] = {
      function() require("telescope.builtin").lsp_definitions() end,
      desc = "Show the definition of current symbol",
    },
    ["gD"] = {
      function() vim.lsp.buf.declaration() end,
      desc = "Declaration of current symbol",
    },
    ["gI"] = {
      function() require("telescope.builtin").lsp_implementations() end,
      desc = "Implementation of current symbol",
    },
    ["gr"] = {
      function() require("telescope.builtin").lsp_references() end,
      desc = "References of current symbol",
    },
    ["gT"] = {
      function() require("telescope.builtin").lsp_type_definitions() end,
      desc = "Definition of current type",
    },
  },
  v = {
    ["<leader>la"] = false,
    ["<leader>fm"] = {
      function() Chiruno.operatorfunc_lua "format_motion" end,
      -- "<cmd>Prettier<CR>",
      desc = "Format code",
    },
  },
}
