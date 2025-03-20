return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {}
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
				volar = require("lsp.config.volar")
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- "ts_ls",
				-- "angular-language-server",
				-- "vuels",
				"cssls",
				-- "stylelint_lsp",
				"tailwindcss",
				"html",
				-- "emmet_ls",
				"jsonls",

				-- lint
				-- "eslint",

				-- php
				"intelephense",
				-- "phpactor",

				-- python
				-- "pyright",
				"pylsp",

				"rust_analyzer",

				"yamlls",

				-- "efm",

				"terraformls",
				"tflint",

				"gopls",

				-- C# .NET
				"omnisharp",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				automatic_installation = true,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						server.on_attach = require("lsp.on_attach")
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
