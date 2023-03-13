-- If you need more control, you can use the function()...end notation
return function(local_vim)
  -- local_vim.opt.iskeyword:append "-"

  if local_vim.g.neovide then
    local opts = {
      guifont = "CaskaydiaCove Nerd Font:h15",
      clipboard = "unnamedplus",
    }
    for k, v in pairs(opts) do
      local_vim.opt[k] = v
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
      local_vim.g[k] = v
    end
  end

  local options = {
    opt = {
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
      hidden = false, -- allow hidden buffers
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
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      matchup_matchparen_offscreen = { method = "popup" },
      copilot_assume_mapped = true,
      luasnippets_path = "./lua/custom",
    },
    o = {
      background = "dark",
    },
  }
  for k, v in ipairs(options) do
    for key, val in ipairs(v) do
      local_vim[k][key] = val
    end
  end

  return local_vim
end
