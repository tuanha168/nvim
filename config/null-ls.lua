local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions

local sources = {
  formatting.prettier.with {
    extra_args = {
      "--no-semi",
      "--single-quote",
      "--jsx-single-quote",
      "--tab-width",
      "2",
      "--trailing-comma",
      "none",
      "--arrow-parens",
      "avoid",
    },
  },
  formatting.phpcsfixer,
  formatting.stylua,
  -- code_actions.gitsigns,
}

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local M = {}
M.setup = function()
  null_ls.setup {
    debug = true,
    sources = sources,

    -- auto format on save
    -- on_attach = function(client, bufnr)
    -- 	if client.supports_method("textDocument/formatting") then
    -- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    -- 		vim.api.nvim_create_autocmd("BufWritePre", {
    -- 			group = augroup,
    -- 			buffer = bufnr,
    -- 			callback = function()
    -- 				-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
    -- 				vim.lsp.buf.formatting_sync({ bufnr = bufnr })
    -- 			end,
    -- 		})
    -- 	end
    -- end,
  }
end

return M
