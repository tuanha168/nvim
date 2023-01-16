local M = {}
local nvChadConfig = require "plugins.configs.lspconfig"
local utils = require "core.utils"

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.supports_method "textDocument/publishDiagnostics" then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      callback = function()
        if vim.g.diagnostics_active then
          vim.diagnostic.open_float(nil, { focus = false })
        end
      end,
    })
  end
end

local function lsp_keymaps(bufnr, client)
  local opts = { noremap = true, silent = true }
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader><ESC>", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- Lspsaga
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", "<cmd>Lspsaga rename<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>k", "<Cmd>Lspsaga hover_doc<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>Lspsaga code_action<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
end

local disabledFormatter = {
  sumneko_lua = true,
  tsserver = true,
  intelephense = true,
  volar = true,
}
local function setContains(set, key)
  return set[key] ~= nil
end

M.on_attach = function(client, bufnr)
  if setContains(disabledFormatter, client.name) then
    if vim.fn.has "nvim-0.7" then
      -- nightly
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    else
      -- stable
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
  end
  utils.load_mappings("lspconfig", { buffer = bufnr })
  lsp_keymaps(bufnr, client)
  -- lsp_highlight_document(client)
end

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(nvChadConfig.capabilities)
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

return M
