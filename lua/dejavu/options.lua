vim.opt.viewoptions:remove "curdir" -- disable saving current directory with views
vim.opt.shortmess:append { s = true, I = true } -- disable startup message
vim.opt.backspace:append { "nostop" } -- Don't stop backspace at insert
if vim.fn.has "nvim-0.9" == 1 then
  vim.opt.diffopt:append "linematch:60" -- enable linematch diff algorithm
end

local options = {
  opt = {
    relativenumber = false,
    completeopt = { "menu", "menuone", "noselect" },
    smarttab = true,
    numberwidth = 4,
    incsearch = true, -- search incremental
    hidden = true, -- allow hidden buffers
    encoding = "utf-8",
    termencoding = "utf-8",
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    swapfile = false,
    title = true,
    titlestring = "%f - nvim",
    conceallevel = 2,
    wrap = true,
    -- cmdheight = 1,
    laststatus = 3,
    breakindent = true,
    clipboard = "unnamedplus",
    cmdheight = 1,
    copyindent = true,
    cursorline = true,
    expandtab = true,
    fileencoding = "utf-8",
    fillchars = { eob = " " }, -- Disable `~` on nonexistent lines
    foldenable = true, -- enable fold for nvim-ufo
    foldlevel = 99, -- set high foldlevel for nvim-ufo
    foldlevelstart = 99, -- start with all code unfolded
    foldcolumn = vim.fn.has "nvim-0.9" == 1 and "1" or nil, -- show foldcolumn in nvim 0.9
    history = 100, -- Number of commands to remember in a history table
    ignorecase = true, -- Case insensitive searching
    infercase = true, -- Infer cases in keyword completion
    linebreak = true, -- Wrap lines at 'breakat'
    mouse = "a", -- Enable mouse support
    number = true, -- Show numberline
    preserveindent = true, -- Preserve indent structure as much as possible
    pumheight = 10, -- Height of the pop up menu
    scrolloff = 8, -- Number of lines to keep above and below the cursor
    shiftwidth = 2, -- Number of space inserted for indentation
    showmode = false, -- Disable showing modes in command line
    showtabline = 2, -- always display tabline
    sidescrolloff = 8, -- Number of columns to keep at the sides of the cursor
    signcolumn = "yes", -- Always show the sign column
    smartcase = true, -- Case sensitivie searching
    smartindent = true, -- Smarter autoindentation
    splitbelow = true, -- Splitting a new window below the current one
    splitright = true, -- Splitting a new window at the right of the current one
    tabstop = 2, -- Number of space in a tab
    termguicolors = true, -- Enable 24-bit RGB color in the TUI
    timeoutlen = 500, -- Shorten key timeout length a little bit for which-key
    undofile = true, -- Enable persistent undo
    updatetime = 300, -- Length of time to wait before triggering the plugin
    virtualedit = "block", -- allow going past end of line in visual block mode
    writebackup = false, -- Disable making a backup before overwriting a file
  },
  g = {
    mapleader = " ", -- set leader key
    maplocalleader = ",", -- set default local leader key
    matchup_matchparen_offscreen = { method = "popup" },
    copilot_assume_mapped = true,
    kitty_navigator_no_mappings = 1,
  },
  o = {
    background = "dark",
  },
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

vim.opt.iskeyword:append "-"

vim.cmd "let g:VM_default_mappings = 0"
vim.cmd "let g:VM_maps = {}"
vim.cmd 'let g:VM_maps["Find Under"] = "<C-d>"'
vim.cmd 'let g:VM_maps["Find Subword Under"] = "<C-d>"'
vim.cmd 'let g:VM_maps["Switch Mode"] = "<Tab>"'

if vim.g.neovide then
  local opts = {
    guifont = "CaskaydiaCove Nerd Font:h15",
    clipboard = "unnamedplus",
  }
  for k, v in pairs(opts) do
    options.opt[k] = v
  end
  local g = {
    -- neovide-fullscreen = true,
    -- neovide_input_use_logo = true,
    neovide_transparency = 0.8,
    neovide_remember_window_size = true,
    neovide_input_macos_alt_is_meta = true,
    -- neovide_profiler = true,
  }
  for k, v in pairs(g) do
    options.g[k] = v
  end
end
