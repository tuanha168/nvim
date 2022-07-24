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
    hi def NeogitDiffAddHighlight guibg=#404040 guifg=#37edde
    hi def NeogitDiffDeleteHighlight guibg=#404040 guifg=#bd3e99
    hi def NeogitDiffContextHighlight guibg=#000 guifg=#000
    hi def NeogitHunkHeader guifg=#000 guibg=#000
    hi def NeogitHunkHeaderHighlight guifg=#000 guibg=#000
  ]],
  false
)

-- Gitsign
vim.api.nvim_exec(
  [[
    hi def GitSignsAdd guibg=#132b16 guifg=#37edde
    hi def GitSignsAddNr guibg=#132b16 guifg=#37edde
    hi def GitSignsAddLn guibg=#132b16 guifg=#37edde
    hi def GitSignsChange guibg=#373810 guifg=#f2f545
    hi def GitSignsChangeNr guibg=#373810 guifg=#f2f545
    hi def GitSignsChangeLn guibg=#373810 guifg=#f2f545
    hi def GitSignsDelete guibg=#26071d guifg=#bd3e99
    hi def GitSignsDeleteNr guibg=#26071d guifg=#bd3e99
    hi def GitSignsDeleteLn guibg=#26071d guifg=#bd3e99
  ]],
  false
)

-- diffview
vim.api.nvim_exec(
  [[
    hi DiffAdd guibg=#132b16
    hi Diffchange guibg=#373810
    hi DiffDelete  guibg=#26071d guifg=#bd3e99
    hi DiffText guibg=#226b3c
  ]],
  false
)
