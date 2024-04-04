-- If you need more control, you can use the function()...end notation
local options = {
  opt = {
    clipboard = "unnamedplus",
    relativenumber = false,
    completeopt = { "menu", "menuone", "noselect" }, -- better autocomplete options
    smarttab = true,
    numberwidth = 4,
    incsearch = true, -- search incremental
    hidden = true, -- allow hidden buffers
    confirm = true,
    encoding = "utf-8",
    -- termencoding = "utf-8",
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    swapfile = false,
    title = true,
    titlestring = "%f - nvim",
    conceallevel = 3,
    wrap = true,
    linebreak = false, -- wrap lines at 'breakat'
    -- cmdheight = 1,
    laststatus = 3,
    splitkeep = "screen",
    scrolloff = 10,
    fillchars = {
      eob = " ",
      vert = " ",
    },
  },
  g = {
    matchup_matchparen_offscreen = { method = "popup" },
    copilot_assume_mapped = true,
    kitty_navigator_no_mappings = 1,
    lsp_handlers_enabled = false, -- enable or disable default vim.lsp.handlers (hover and signatureHelp)
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    resession_enabled = false,
    codelens_enabled = false,
  },
  o = {
    background = "dark",
  },
}

vim.opt.iskeyword:append "-"

if vim.g.neovide then
  local opts = {
    guifont = "CaskaydiaCove Nerd Font:h15",
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
