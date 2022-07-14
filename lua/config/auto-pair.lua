local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
require("nvim-autopairs").setup({
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
	},
	enable_check_bracket_line = false,
	ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
})
