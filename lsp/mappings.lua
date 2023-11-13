return {
  n = {
    ["<leader>ld"] = false,
    ["<leader>li"] = false,
    ["<leader>lI"] = false,
    ["<leader>lf"] = false,
    ["<leader>la"] = false,
    ["<leader>ll"] = false,
    ["<leader>lL"] = false,
    ["<leader>lr"] = false,
    ["<leader>lR"] = false,
    ["<leader>lh"] = false,
    ["<leader>lG"] = false,
    ["<leader>lD"] = false,
    ["<leader>lS"] = false,
    ["K"] = false,
    ["gT"] = false,
    ["<leader>l"] = {
      function() vim.diagnostic.open_float() end,
      desc = "Hover diagnostics",
    },
    ["<leader>fm"] = {
      -- function() Chiruno.func.operatorfunc_lua "format_motion" end,
      function() vim.lsp.buf.format(require("astronvim.utils.lsp").format_opts) end,
      -- "<cmd>Prettier<CR>",
      desc = "Format code",
    },
    ["<leader>ee"] = {
      function()
        local ok, actPrew = pcall(require, "actions-preview")
        if ok then
          actPrew.code_actions()
        else
          vim.lsp.buf.code_action()
        end
      end,
      desc = "LSP code action",
    },
    ["<leader>E"] = { function() vim.lsp.codelens.run() end, desc = "Run code lens" },
    -- ["<leader>K"] = {
    --   function() vim.lsp.buf.signature_help() end,
    --   desc = "Signature help",
    -- },
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
  },
  v = {
    ["<leader>la"] = false,
    ["<leader>fm"] = {
      function() Chiruno.func.operatorfunc_lua "format_motion" end,
      -- "<cmd>Prettier<CR>",
      desc = "Format code",
    },
  },
}
