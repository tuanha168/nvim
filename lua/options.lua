local options = {
  opt = {
    clipboard = "unnamedplus",
    relativenumber = false,
    completeopt = { "menu", "menuone", "noselect" }, -- better autocomplete options
    copyindent = true,
    cursorline = true,
    smarttab = true,
    tabstop = 2,
    shiftwidth = 0,
    expandtab = true,
    numberwidth = 4,
    incsearch = true, -- search incremental
    hidden = true, -- allow hidden buffers
    confirm = true,
    encoding = "utf-8",
    -- termencoding = "utf-8",
    ignorecase = true,
    infercase = true,
    swapfile = false,
    title = true,
    titlestring = "%f - nvim",
    conceallevel = 3,
    wrap = true,
    linebreak = false, -- wrap lines at 'breakat'
    cmdheight = 0,
    laststatus = 3,
    splitkeep = "screen",
    scrolloff = 10,
    mouse = "a",
    number = true,
    preserveindent = true,
    shiftround = true,
    smartcase = true,
    signcolumn = "yes",
    undofile = true,
    jumpoptions = "",
    fillchars = {
      eob = " ",
      fold = " ",
      foldopen = "",
      foldsep = " ",
      foldclose = "",
    },
  },
  g = {
    mapleader = " ",
    editorconfig = false,
    matchup_matchparen_offscreen = { method = "popup" },
    copilot_assume_mapped = true,
    kitty_navigator_no_mappings = 1,
    vue_hybrid = true,
  },
  o = {
    background = "dark",
    foldcolumn = "1",
    foldenable = true,
    foldlevel = 99,
    foldlevelstart = 99,
    foldmethod = "expr",
    foldexpr = "v:lua.vim.treesitter.foldexpr()",
    foldtext = "",
    splitright = true,
  },
}

vim.cmd "set verbosefile=$HOME/.dotfile/logs/nvim.log"

vim.opt.iskeyword:append "-"

if vim.g.neovide then
  local opts = {
    guifont = "CaskaydiaCove Nerd Font:h12",
  }
  for k, v in pairs(opts) do
    options.opt[k] = v
  end
  local g = {
    -- neovide-fullscreen = true,
    -- neovide_input_use_logo = true,
    neovide_opacity = 0.8,
    neovide_remember_window_size = true,
    neovide_input_macos_alt_is_meta = true,
    -- neovide_profiler = true,
  }
  for k, v in pairs(g) do
    options.g[k] = v
  end
end

for key, value in pairs(options.opt) do
  vim.opt[key] = value
end

for key, value in pairs(options.g) do
  vim.g[key] = value
end

for key, value in pairs(options.o) do
  vim.o[key] = value
end

return options

-- return function(local_vim)
--   if vim.g.neovide then
--     local opts = {
--       guifont = "CaskaydiaCove Nerd Font:h15",
--     }
--     for k, v in pairs(opts) do
--       options.opt[k] = v
--     end
--     local g = {
--       -- neovide-fullscreen = true,
--       -- neovide_input_use_logo = true,
--       neovide_transparency = 0.8,
--       neovide_remember_window_size = true,
--       neovide_input_macos_alt_is_meta = true,
--       -- neovide_profiler = true,
--     }
--     for k, v in pairs(g) do
--       options.g[k] = v
--     end
--   end
--
--   for k, v in pairs(options) do
--     for key, val in pairs(v) do
--       options[k][key] = val
--     end
--   end
--
--   return local_vim
-- end
