return function(_, _)
  local utils = require "utils"
  local get_icon = utils.get_icon
  local signs = {
    { name = "DiagnosticSignError", text = get_icon "DiagnosticError", texthl = "DiagnosticSignError" },
    { name = "DiagnosticSignWarn", text = get_icon "DiagnosticWarn", texthl = "DiagnosticSignWarn" },
    { name = "DiagnosticSignHint", text = get_icon "DiagnosticHint", texthl = "DiagnosticSignHint" },
    { name = "DiagnosticSignInfo", text = get_icon "DiagnosticInfo", texthl = "DiagnosticSignInfo" },
    { name = "DapStopped", text = get_icon "DapStopped", texthl = "DiagnosticWarn" },
    { name = "DapBreakpoint", text = get_icon "DapBreakpoint", texthl = "DiagnosticInfo" },
    { name = "DapBreakpointRejected", text = get_icon "DapBreakpointRejected", texthl = "DiagnosticError" },
    { name = "DapBreakpointCondition", text = get_icon "DapBreakpointCondition", texthl = "DiagnosticInfo" },
    { name = "DapLogPoint", text = get_icon "DapLogPoint", texthl = "DiagnosticInfo" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, sign)
  end
  vim.diagnostic.config(require "diagnostics"(signs))

  if vim.g.lsp_handlers_enabled then
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", silent = true })
  end
end
