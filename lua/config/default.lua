local options_opt = {
	completeopt = "menu,menuone,noselect", -- better autocomplete options
	mouse = "a", -- if I accidentally use the mouse
	splitright = true, -- splits to the right
	splitbelow = true, -- splits below
	expandtab = true, -- space characters instead of tab
	tabstop = 2, -- tab equals 2 spaces
	shiftwidth = 2, -- indentation
	number = true, -- show absolute line numbers
	-- relativenumber = true,
	ignorecase = true, -- search case insensitive
	smartcase = true, -- search via smartcase
	incsearch = true, -- search incremental
	hidden = true, -- allow hidden buffers
	cmdheight = 1, -- only one line for commands
	signcolumn = "yes", -- add a column for sings (e.g. LSP, ...)
	updatetime = 520, -- time until update
	undofile = true, -- persists undo tree
	encoding = "utf-8",
	fileencoding = "utf-8",
	termencoding = "utf-8",
	cursorline = true,
	termguicolors = true,
}
for k, v in pairs(options_opt) do
	vim.opt[k] = v
end

local options_g = {
	mapleader = " ", -- space as leader key
}
for k, v in pairs(options_g) do
	vim.g[k] = v
end

-- other config
vim.api.nvim_exec(
	[[
  autocmd BufEnter * syntax sync fromstart
  autocmd FileType php setlocal commentstring=\/\/\ \ %s
  let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
]],
	false
)
