return {
  {
    "catgoose/vue-goto-definition.nvim",
    event = "BufReadPre",
    config = function()
      require("vue-goto-definition").setup {
        filters = {
          auto_imports = true,
          auto_components = true,
          import_same_file = true,
          declaration = true,
          duplicate_filename = true,
        },
        filetypes = { "vue", "typescript" },
        detection = {
          nuxt = function() return vim.fn.glob ".nuxt/" ~= "" end,
          vue3 = function() return vim.fn.filereadable "vite.config.ts" == 1 or vim.fn.filereadable "src/App.vue" == 1 end,
          priority = { "nuxt", "vue3" },
        },
        lsp = {
          override_definition = true, -- override vim.lsp.buf.definition
        },
        debounce = 200,
      }
      -- vim.schedule(function()
      --   vim.keymap.set(
      --     "n",
      --     "gd",
      --     function() vim.lsp.buf.definition() end,
      --     desc = "Show the definition of current symbol"
      --   )
      -- end)
    end,
  },
}
