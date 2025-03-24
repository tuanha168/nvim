return function(client, bufnr)
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
