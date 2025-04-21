require("lazy").setup {
	spec = {
		{ import = "plugins" },
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			config = true,
			opts = {
				library = {
					"~/.local/share/nvim/lazy/",
					"~/.local/share/nvim/lazy/json.lua/json.lua",
				},
			},
		},
	},
	-- Configure any other `lazy.nvim` configuration options here
	install = { colorscheme = { "Mofiqul/dracula.nvim" } },
	-- automatically check for plugin updates
	-- checker = { enabled = true },
}
