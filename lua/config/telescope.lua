-- delete_buffer Telescope
require("telescope").setup({
	pickers = {
		buffers = {
			show_all_buffers = true,
			sort_lastused = true,
			mappings = {
				i = {
					["<c-d>"] = "delete_buffer",
				},
			},
		},
	},
})
require("telescope").load_extension("projects")
