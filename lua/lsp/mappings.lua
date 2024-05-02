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
    ["<Leader>l"] = {
      function() vim.diagnostic.open_float() end,
      desc = "Hover diagnostics",
    },
    ["<Leader>fm"] = {
      -- function() Chiruno.func.operatorfunc_lua "format_motion" end,
      function() vim.lsp.buf.format() end,
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
    ["<Leader>gl"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" },
    ["gt"] = {
      function() require("telescope.builtin").lsp_type_definitions() end,
      desc = "Definition of current type",
    },
    ["gR"] = {
      function() vim.lsp.buf.rename() end,
      desc = "Rename current symbol",
    },
    -- ../plugins/lsp_plugin.lua:20
    ["gd"] = {
      function() vim.lsp.buf.definition() end,
      desc = "Show the definition of current symbol",
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
