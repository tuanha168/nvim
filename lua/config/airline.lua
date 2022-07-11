-- airline
vim.api.nvim_exec(
	[[
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline_section_c = '%t'
  let g:airline_theme='dark'
  let g:airline_powerline_fonts = 1
  if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif
  " unicode symbols
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.whitespace = 'Ξ'
  let g:airline_symbols.readonly = ''
]],
	false
)
