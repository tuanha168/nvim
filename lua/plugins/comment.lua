return {
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			ignore = "^$",
		},
		config = function(_, opts)
			local ft = require "Comment.ft"
			ft.set("dosini", "# %s")
			ft.set("hyprlang", "# %s")
			require("Comment").setup(opts)
		end,
	},
}
