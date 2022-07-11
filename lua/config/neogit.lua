-- TimUntersberger/neogit and sindrets/diffview.nvim
require("neogit").setup({
	disable_commit_confirmation = true,
	integrations = {
		diffview = true,
	},
})
