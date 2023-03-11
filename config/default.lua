local options_opt = {
  completeopt = { "menu", "menuone", "noselect" }, -- better autocomplete options
  mouse = "a", -- if I accidentally use the mouse
  splitright = true, -- splits to the right
  splitbelow = true, -- splits below
  expandtab = true, -- space characters instead of tab
  smarttab = true,
  tabstop = 2, -- tab equals 2 spaces
  shiftwidth = 2, -- indentation
  number = true, -- show absolute line numbers
  relativenumber = true,
  numberwidth = 4,
  ignorecase = true, -- search case insensitive
  smartcase = true, -- search via smartcase
  incsearch = true, -- search incremental
  hidden = true, -- allow hidden buffers
  cmdheight = 2, -- only one line for commands
  signcolumn = "yes", -- add a column for sings (e.g. LSP, ...)
  updatetime = 300, -- time until update
  undofile = true, -- persists undo tree
  encoding = "utf-8",
  fileencoding = "utf-8",
  termencoding = "utf-8",
  cursorline = true,
  cursorcolumn = true,
  termguicolors = true,
  foldlevel = 20,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  scrolloff = 8,
  sidescrolloff = 8,
  swapfile = false,
  title = true,
  titlestring = "%f",
  conceallevel = 1,
}
for k, v in pairs(options_opt) do
  vim.opt[k] = v
  vim.opt.iskeyword:append "-"
end

local options_g = {
  mapleader = " ", -- space as leader key
  matchup_matchparen_offscreen = { method = "popup" },
  copilot_assume_mapped = true,
  luasnippets_path = "./lua/custom",
}
for k, v in pairs(options_g) do
  vim.g[k] = v
end

if vim.g.neovide then
  local opts = {
    guifont = "CaskaydiaCove Nerd Font:h15",
    clipboard = "unnamedplus",
  }
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
  local g = {
    -- neovide_fullscreen = true,
    -- neovide_input_use_logo = true,
    neovide_transparency = 0.8,
    neovide_remember_window_size = true,
    neovide_input_macos_alt_is_meta = true,
    -- neovide_profiler = true,
  }
  for k, v in pairs(g) do
    vim.g[k] = v
  end
end