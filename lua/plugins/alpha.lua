return { {
	"goolord/alpha-nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		local config = require("alpha.themes.startify").config
		config.layout[2] = {
			type = "text",
			val = {
				[[  _________  .__     .__                                  ]],
				[[  \_   ___ \ |  |__  |__|_______  __ __   ____    ____    ]],
				[[  /    \  \/ |  |  \ |  |\_  __ \|  |  \ /    \  /  _ \   ]],
				[[  \     \____|   Y  \|  | |  | \/|  |  /|   |  \(  <_> )  ]],
				[[   \______  /|___|  /|__| |__|   |____/ |___|  / \____/   ]],
				[[          \/      \/                         \/           ]],
				[[              ]],
			},
			opts = {
				hl = "Type",
				shrink_margin = false,
			},
		}

		require("alpha").setup(config)
	end,
}
}
