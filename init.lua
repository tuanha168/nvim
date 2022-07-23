require "custom.keymaps"

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- other config
vim.api.nvim_exec(
  [[
  autocmd FocusGained,BufEnter * :checktime
  autocmd BufEnter * syntax sync fromstart
  autocmd FileType php setlocal commentstring=\/\/\ \ %s
  let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
]],
  false
)

-- quick scope
vim.api.nvim_exec(
  [[
  augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
  augroup END
]],
  false
)

-- Neogit
vim.api.nvim_exec(
  [[
 hi def NeogitDiffAddHighlight guibg=#404040 guifg=#afff5f 
 hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#dc322f 
 hi def NeogitDiffContextHighlight guibg=#333333 guifg=#b2b2b2 
 hi def NeogitHunkHeader guifg=#cccccc guibg=#404040 
 hi def NeogitHunkHeaderHighlight guifg=#cccccc guibg=#4d4d4d 
]],
  false
)

-- Gitsign
vim.api.nvim_exec(
[[
 hi def GitSignsAdd guibg=#afff5f guifg=#404040
]], false
)
