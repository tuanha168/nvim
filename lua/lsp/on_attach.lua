return function(client, bufnr)
	if client.server_capabilities.workspace then
		client.server_capabilities.workspace.didChangeWatchedFiles = client.server_capabilities.workspace
				.didChangeWatchedFiles
				or {}
		client.server_capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }
	end
	if client.name == "eslint" then
		client.server_capabilities = client.server_capabilities or {}
		client.server_capabilities.documentFormattingProvider = true
		client.config.capabilities = client.config.capabilities or {}
		client.config.capabilities.documentFormattingProvider = true
	end

	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		underline = true,
		update_in_insert = false,
		show_diagnostic_autocmds = { 'InsertLeave', 'TextChanged' },
	})
	-- if client.name == "rust_analyzer" then
	--   local rt = require "rust-tools"
	--   vim.keymap.set("n", "<leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
	-- end
end
