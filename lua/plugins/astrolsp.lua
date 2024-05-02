-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        -- allow_filetypes = { -- enable format on save for specified filetypes only
        --   "typescript",
        --   "javascript",
        --   "typescriptreact",
        --   "javascriptreact",
        --   "vue",
        --   "tsx",
        --   "jsx",
        -- },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "php",
          "minifiles",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        "lua_ls",
        "jsonls",
        -- "intelephense",
        -- "eslint",
        "prettierd",
        "volar",
        "tailwindcss",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {},
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      cssls = require "lsp.config.cssls",
      eslint = require "lsp.config.eslint",
      html = require "lsp.config.html",
      intelephense = require "lsp.config.intelephense",
      omnisharp = require "lsp.config.omnisharp",
      stylelint_lsp = require "lsp.config.stylelint_lsp",
      tailwindcss = require "lsp.config.tailwindcss",
      tsserver = require "lsp.config.tsserver",
      volar = require "lsp.config.volar",
    },
    -- customize how language servers are attached
    handlers = require "lsp.setup_handlers",
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = require "lsp.mappings",
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = require "lsp.on_attach",
  },
}
