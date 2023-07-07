if vim.loader and vim.fn.has("nvim-0.9.1") == 1 then
	vim.loader.enable()
end

for _, source in ipairs({
	"Chiruno",
	"dejavu.options",
	"dejavu.lazy",
	"dejavu.autocmds",
	"dejavu.mappings",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end

pcall(vim.cmd.colorscheme, require("dejavu.colorscheme"))

return {
	-- heirline configuration
	icons = {
		VimIcon = "",
		ScrollText = "",
		GitBranch = "",
		GitAdd = "",
		GitChange = "",
		GitDelete = "",
	},
	-- modify variables used by heirline but not defined in the setup call directly
	heirline = {
		-- define the separators between each section
		separators = {
			left = { "", " " }, -- separator for the left side of the statusline
			right = { " ", "" }, -- separator for the right side of the statusline
			-- tab = { " ", " " },
			tab = { " ", " " },
		},
		-- add new colors that can be used by heirline
		colors = function(hl)
			local get_hlgroup = require("astronvim.utils").get_hlgroup
			-- use helper function to get highlight group properties
			local comment_fg = get_hlgroup("Comment").fg
			hl.git_branch_fg = comment_fg
			hl.git_added = comment_fg
			hl.git_changed = comment_fg
			hl.git_removed = comment_fg
			hl.blank_bg = get_hlgroup("Folded").fg
			hl.file_info_bg = get_hlgroup("Visual").bg
			hl.nav_icon_bg = get_hlgroup("String").fg
			hl.nav_fg = hl.nav_icon_bg
			hl.folder_icon_bg = get_hlgroup("Error").fg
			return hl
		end,
		attributes = {
			mode = { bold = true },
		},
		icon_highlights = {
			file_icon = {
				statusline = false,
			},
		},
	},
}
