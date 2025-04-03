return {
	"mrjones2014/legendary.nvim",
	priority = 10000,
	lazy = false,
	opts = {
		extensions = {
			lazy_nvim = true,
			smart_splits = {
				directions = { "h", "j", "k", "l" },
				mods = {
					move = "<C>",
					resize = false,
					swap = false,
				},
			},
		},
		keymaps = require "mappings",
		autocmds = require "autocmds",
	},
	-- sqlite is only needed if you want to use frecency sorting
	-- dependencies = { 'kkharji/sqlite.lua' }
}
