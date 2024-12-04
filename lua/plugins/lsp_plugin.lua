---@type LazySpec
return {
  -- {
  --   "catgoose/vue-goto-definition.nvim",
  --   event = "BufReadPre",
  --   opts = {
  --     filters = {
  --       auto_imports = true,
  --       auto_components = true,
  --       import_same_file = true,
  --       declaration = true,
  --       duplicate_filename = true,
  --     },
  --     filetypes = { "vue", "typescript" },
  --     detection = {
  --       nuxt = function() return vim.fn.glob ".nuxt/" ~= "" end,
  --       vue3 = function() return vim.fn.filereadable "vite.config.ts" == 1 or vim.fn.filereadable "src/App.vue" == 1 end,
  --       priority = { "nuxt", "vue3" },
  --     },
  --     lsp = {
  --       override_definition = true, -- override vim.lsp.buf.definition
  --     },
  --     debounce = 200,
  --   },
  -- },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    opts = {
      preset = "minimal",
      options = {
        use_icons_from_diagnostic = true,
        multiple_diag_under_cursor = true,
        multilines = true,
      },
    },
  },
}
