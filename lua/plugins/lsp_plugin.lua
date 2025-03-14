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
  -- {
  --   "rachartier/tiny-inline-diagnostic.nvim",
  --   event = "VeryLazy", -- Or `LspAttach`
  --   priority = 1000, -- needs to be loaded in first
  --   opts = {
  --     preset = "powerline",
  --   },
  -- },
  {
      'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        js = { 'eslint' },
        ts = { 'eslint' },
        vue = { 'eslint' },
        lua = { 'stylua' },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  },
  {
"stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        -- default_options = {
        --   formatters = {
        --     go = "gofmt",
        --     javascript = "prettier",
        --     typescript = "prettier",
        --     markdown = "prettier",
        --     json = "prettier",
        --     yaml = "prettier",
        --     html = "prettier",
        --     css = "prettier",
        --     scss = "prettier",
        --     less = "prettier",
        --     java = "prettier",
        --     graphql = "prettier",
        --   },
        -- },
      })
    end,
  }
}
